# s-expression token
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

# s-expression parse
filter s_prs {
    begin {
        [xml]$doc = [System.Xml.XmlDocument]::new()
        $doc.AppendChild($doc.CreateXmlDeclaration("1.0", $null, $null)) | Out-Null
        $node = $doc; $seq = $lvl = 0
        $sn = @("name", "rename")
        $nm = @(
            "edif", "design", "external", "library", "cell", "view", "page", 
            "instance", "port", "portBundle", "portListAlias", "portImplementation", 
            "viewRef", "portRef", "instanceRef", "cellRef", "libraryRef", 
            "figureGroup", "figureGroupOverride", "figure", "offpageConnector",
            "net", "netBundle", "property", "parameter", "display", "keywordDisplay"
        )
    }
    process {
        if ($_ -eq "(") { if ($lvl) { $lvl++; break } $seq = 1; break }
        if ($_ -eq ")") { if ($lvl) { $lvl--; break } $node = $node.ParentNode; $seq = 4; break }
        $s = $_
        if ($s -match "%") {
            $s = [regex]::replace($s, "%(\d+)%", { [char]([int]($args.groups[1].value)) })
            $s | Out-Host
        }
        switch ($seq) {
            1 {
                $node = $node.AppendChild($doc.CreateNode("element", $s, $null))
                $seq = if ($nm -contains $s) { 2 } elseif ($sn -contains $s) { 3 } else { 4 }
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

# xslt transformation
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

# sort xml-file for edif
function sort_xml($path, $out_path) {
    if (Test-Path $path) {
        $xsl_path = Join-Path (Get-Location).path "edif_sort.xsl"
        xslt $path $xsl_path $out_path
    }
}

# format xml-file
function format_xml($path, $out_path) {
    if (Test-Path $path) {
        $doc = [xml](Get-Content $path)
        $doc.Save($out_path)
    }
}

# path: ./test/test.edn
# encoding: utf-8, shift_jis, euc-jp
function edif2svg($path, $encoding = "utf-8") {
    $dirs = Split-Path $path | Convert-Path
    $name = Split-Path $path -Leaf
    $path = Join-Path $dirs $name
    "in:  ${path}" |Out-Host
    $name = $name -replace "\.ed[nif]+$", ""
    $org_path = Join-Path $dirs "${name}.org"
    $xml_path = Join-Path $dirs "${name}.xml"
    $tmp_path = Join-Path $dirs "_tmp"
    "out: ${xml_path}" |Out-Host

    # convert edif to xml
    if (-not (Test-Path $org_path)) {
        $enc = [Text.Encoding]::GetEncoding($encoding)
        $doc = [System.IO.File]::ReadAllLines($path, $enc) | s_tok | s_prs
        $doc.Save($org_path)
    }
    if (-not (Test-Path $xml_path)) {
        sort_xml $org_path $tmp_path
        format_xml $tmp_path $xml_path
    }

    $cmd = @("node", "page", "group")
    $cmd | ForEach-Object {
        $kw = $_
        $xslt_path = Join-Path (Get-Location).path "edif_${kw}.xsl"
        "xslt: ${xslt_path}" | Out-Host
        $out_path = Join-Path $dirs "_${kw}.lst"
        xslt $xml_path $xslt_path $out_path
    }

    $cmd = @("refs", "svg")
    Get-Content (Join-Path $dirs "_page.lst") | ForEach-Object {
        $page = $_
        $cmd | ForEach-Object {
            $kw = $_
            $xslt_path = Join-Path (Get-Location).path "edif_${kw}.xsl"
            $out_path = Join-Path $dirs "_${kw}_${page}.lst"
            "convert to ${out_path}" | Out-Host
            xslt $xml_path $xslt_path $out_path @{ page = $page }
        }
    
        #output schematic
        $out_path = Join-Path $dirs "${name}_${page}.svg"
        format_xml (Join-Path $dirs "_svg_${page}.lst") $out_path
    }
}
