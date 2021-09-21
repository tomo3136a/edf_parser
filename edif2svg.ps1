filter s_tok {
    begin { $s = ""; $seq = 0; $skip = 0 }
    process {
        :L1 foreach ($c in $_.GetEnumerator()) {
            if ($seq) {
                $s += $c; 
                if ($skip) { $skip = 0 }
                elseif ($c -eq "\") { $skip = 1 }
                elseif ($c -eq "`"") { $s; $s = ""; $seq = 0; }
                continue
            }
            switch ($c) {
                { $_ -in "#", ";" } { if ($s) { $s } $s = ""; break L1 }
                { $_ -in "(", ")" } { if ($s) { $s } $s = ""; $c }
                { $_ -in " ", "`t" } { if ($s) { $s } $s = "" }
                "`"" { if ($s) { $s } $s = $c; $seq = 1 }
                default { $s += $c }
            }
        }
        if ($seq -eq 1) { $s += "`n" }
    }
    end { if ($s) { $s; $s = "" } }
}

filter s_prs {
    begin {
        [xml]$doc = [System.Xml.XmlDocument]::new()
        $doc.AppendChild($doc.CreateXmlDeclaration("1.0", $null, $null)) | Out-Null
        $node = $doc; $seq = $lvl = 0
        # $sk = @(
        #     "portImplementation", "figureGroup", "figure", "status", "edifLevel")
        $nm = @(
            "edif", "design", "external", "library", "cell", "view", "page", "property", 
            "portImplementation", "figureGroup", "figure", "port", "instance", "net", 
            "viewref", "portref", "instanceref", "cellref", "libraryref", "figureGroupOverride")
    }
    process {
        if ($_ -eq "(") { if ($lvl) { $lvl++; break } $seq = 1; break }
        if ($_ -eq ")") { if ($lvl) { $lvl--; break } $node = $node.ParentNode; $seq = 4; break }
        $s = $_
        #$s = $_ -replace "%(\d+)%","\`$1"
        if ($s -match "%") {
            $s = [regex]::replace($s, "%(\d+)%", { [char]([int]($args.groups[1].value)) })
            $s | Out-Host
        }
        switch ($seq) {
            1 {
                #if ($sk -contains $s) { $lvl++; $seq = 0; break }
                $node = $node.AppendChild($doc.CreateNode("element", $s, $null))
                $seq = if ($nm -contains $s) { 2 } elseif ($s -eq "rename") { 3 } else { 4 }
            }
            2 { $node.SetAttribute("name", $s) | Out-Null; $seq = 5 }
            3 { $node.ParentNode.SetAttribute("name", $s) | Out-Null; $seq = 4 }
            4 { $node.AppendChild($doc.CreateTextNode($s)) | Out-Null; $seq = 5 }
            5 {
                $node.AppendChild($doc.CreateWhitespace(" ")) | Out-Null
                $node.AppendChild($doc.CreateTextNode($s)) | Out-Null 
            }
        }
    }
    end { $doc }
}

function xslt($xmlPath, $xsltPath, $outPath, $col = @{}) {
    $xslt = New-Object System.Xml.Xsl.XslCompiledTransform
    $xslt.Load($xsltPath)
    $arglist = New-Object System.Xml.Xsl.XsltArgumentList
    $col.GetEnumerator() | ForEach-Object { $arglist.AddParam($_.Name, "", $_.Value) }
    $ws = New-Object System.Xml.XmlWriterSettings;
    $ws.ConformanceLevel = "Fragment"
    $wrt = [System.Xml.XmlWriter]::Create($outPath, $ws)
    $xslt.Transform($xmlPath, $arglist, $wrt)
    $wrt.Close()
}

function edif2svg($path) {
    # $path = ".\test2.edn"
    $name = $path -replace "\.ed[nif]+$", ""
    $edif_path = (Get-Location).path + "\\" + $path + ".xml"
    if (-not (Test-Path $edif_path)) {
        $doc = Get-Content $path -Encoding UTF8 | s_tok | s_prs
        $doc.Save($edif_path)
    }
    # output page list
    $xslt_path = (Get-Location).path + "\\edif_pages.xsl"
    $page_path = (Get-Location).path + "\\" + $name + "_pages.txt"
    xslt $edif_path $xslt_path $page_path

    #output schematic
    Get-Content $page_path | ForEach-Object {
        $xslt_path = (Get-Location).path + "\\edif_refs.xsl"
        $out_path = (Get-Location).path + "\\" + $name + "_" + $_ + "_refs.txt"
        xslt $edif_path $xslt_path $out_path @{page = $_}

        $xslt_path = (Get-Location).path + "\\edif2svg.xsl"
        $out_path = (Get-Location).path + "\\" + $name + "_" + $_ + ".svg"
        $_ | Out-Host
        xslt $edif_path $xslt_path $out_path @{page = $_}
    }
}
