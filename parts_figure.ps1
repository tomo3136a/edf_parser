$path = "parts_list.csv"
#$out = "parts_out.xlsx"

function gen_figure($path) {
    $src = (Get-Location).path + "\" + $path
    $src = Resolve-Path $src
    $out = $src -replace "\.[^.]+$", "_out.xlsx"
    "src: ${src}" | Out-Host
    "out: ${out}" | Out-Host

    $col = Import-Csv $src -Delimiter ","
    
    try {
        $app = New-Object -ComObject Excel.Application
        $app.Visible = $True
        #$app.Visible = $False
        #$app.DisplayAlerts = $False
        $book = $app.Workbooks.Add()
        $sheet = $app.Worksheets.Item(1)
        $sheet.Name = $sheet.Name -replace "sheet", "`zu"
        # ---
        $sheet.Cells.ColumnWidth = 1 * (72 / 2.54 / 10) + 1.3   # 10mm
        $sheet.Cells.RowHeight = 1 * 72 / 2.54 + 0.5            # 1cm
        $pos = 0
        $col | ForEach-Object {
            $line = $_
            $w = (1.0 * [int]($line.width)) / 10 * 72 / 2.54
            $h = (1.0 * [int]($line.height)) / 10 * 72 / 2.54
            $fs = 11

            $r = (1.0 * [int]($line.r)) + 5
            $n1 = (1.0 * [int]($line.n1))
            $n2 = (1.0 * [int]($line.n2))
            $n3 = (1.0 * [int]($line.n3))
            $n4 = (1.0 * [int]($line.n4))
            $weight = 6

            $x = (1.0 * [int]($line.x + 10)) / 10 * 72 / 2.54
            $y = (1.0 * [int]($line.y + 10)) / 10 * 72 / 2.54
            $a = (1.0 * [int]($line.angle))

            "${w},${h},${fs}  ${r},${n1},${n2},${n3},${n4},${weight}  ${x},${y},${a}" | Out-Host
            $shape = $sheet.Shapes.AddShape(1, $x, $y, $w, $h)
            $shape.Rotation = $a
            $shape.Placement = 3
            $shape.LockAspectRatio = -1
            $shape.TextFrame2.AutoSize = 0
            $shape.TextFrame2.WordWrap = 0
            $shape.TextFrame2.VerticalAnchor = 3
            $shape.TextFrame2.HorizontalAnchor = 2
            $shape.TextFrame2.MarginLeft = 2.83
            $shape.TextFrame2.MarginRight = 2.83
            $shape.TextFrame2.MarginTop = 2.83
            $shape.TextFrame2.MarginBottom = 2.83
            $shape.TextFrame2.TextRange.Text = $line.text
            $shape.Fill.ForeColor.RGB = [int]($line.color)
            $shape.TextFrame.HorizontalOverflow = 0
            if ([int]($line.font) -ne 0) {
                $fs = [int]($line.font)
            }
            $shape.TextFrame2.TextRange.Font.Size = $fs
            $grp = @($shape.Name)
            if ($n1 -gt 0) {
                $d = $w / (2 * $n1)
                for ($i = 0; $i -lt $n1; $i++) {
                    $j = 2 * $i + 1
                    $shape = $sheet.Shapes.AddConnector(1, $x, $y + $d * $j, $x - $r, $y + $d * $j)
                    $shape.Line.Weight = $weight
                    $grp += $shape.Name
                }
            }
            if ($n2 -gt 0) {
                $d = $h / (2 * $n2)
                for ($i = 0; $i -lt $n2; $i++) {
                    $j = 2 * $i + 1
                    $shape = $sheet.Shapes.AddConnector(1, $x + $d * $j, $y + $h, $x + $d * $j, $y + $h + $r)
                    $shape.Line.Weight = $weight
                    $grp += $shape.Name
                }
            }
            if ($n3 -gt 0) {
                $d = $w / (2 * $n3)
                for ($i = 0; $i -lt $n3; $i++) {
                    $j = 2 * $i + 1
                    $shape = $sheet.Shapes.AddConnector(1, $x + $w, $y + $h - $d * $j, $x + $w + $r, $y + $h - $d * $j)
                    $shape.Line.Weight = $weight
                    $grp += $shape.Name
                }
            }
            if ($n4 -gt 0) {
                $d = $h / (2 * $n4)
                for ($i = 0; $i -lt $n4; $i++) {
                    $j = 2 * $i + 1
                    $shape = $sheet.Shapes.AddConnector(1, $x + $w - $d * $j, $y, $x + $w - $d * $j, $y - $r)
                    $shape.Line.Weight = $weight
                    $grp += $shape.Name
                }
            }
            $sheet.Shapes.Range($grp).Group() | Out-Null
            $pos ++
        }
        # ---
        $book.SaveAs($out, 51)
    }
    catch {
    }
    finally {
        if ($shape) {
            [System.Runtime.InteropServices.Marshal]::ReleaseComObject($shape) | Out-Null
            $shape = $null
        }
        if ($sheet) {
            [System.Runtime.InteropServices.Marshal]::ReleaseComObject($sheet) | Out-Null
            $sheet = $null
        }
        if ($book) {
            [System.Runtime.InteropServices.Marshal]::ReleaseComObject($book) | Out-Null
            $book = $null
        }
        if ($app) {
            $app.Quit()
            [System.Runtime.InteropServices.Marshal]::ReleaseComObject($app) | Out-Null
            $app = $null
        }
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
        [System.GC]::Collect()
    }
    
}

gen_figure($path)
