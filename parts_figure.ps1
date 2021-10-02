#!powershell
$path = "parts_list.csv"

function gen_pin($app, $n, $x1, $y1, $x2, $y2, $px, $py, $pw) {
    if ($n -gt 0) {
        $grp = @()
        for ($i = 0; $i -lt $n; $i++) {
            $x = (1.0 + 2 * $i) / (2 * $n) * ($x2 - $x1) + $x1 + 100
            $y = (1.0 + 2 * $i) / (2 * $n) * ($y2 - $y1) + $y1 + 100
            $app.ActiveSheet.Shapes.AddConnector(1, $x, $y, $x + $px, $y + $py).Select()
            $grp += $app.Selection.ShapeRange.Name
        }
        if ($n -gt 1) {
            $app.ActiveSheet.Shapes.Range($grp).Group().Select()
        }
        $app.Selection.ShapeRange.Line.ForeColor.RGB = [int]0x808080
        $app.Selection.ShapeRange.Line.Weight = $pw
        $app.Selection.ShapeRange.Name
    }
}

function gen_figure($path) {
    $src = (Get-Location).path + "\" + $path
    $src = Resolve-Path $src
    $out = $src -replace "\.[^.]+$", "_out.xlsx"
    "in:  ${src}" | Out-Host
    "out: ${out}" | Out-Host

    $col = Import-Csv $src -Delimiter ","
    try {
        $app = New-Object -ComObject Excel.Application
        #$app.Visible = $True
        $app.Visible = $False
        #$app.DisplayAlerts = $False
        $app.ScreenUpdating = $False
        $app.EnableEvents = $False
        "start generate" | Out-Host
        $book = $app.Workbooks.Add()
        $app.Calculation = $False
        # ---
        $book.Worksheets.Item(1).Select()
        $app.ActiveSheet.Name = $app.ActiveSheet.Name -replace "sheet", ("" + [char]0x56f3)
        $app.ActiveSheet.Cells.ColumnWidth = 1 * (72 / 2.54 / 10) + 1.3   # 10mm
        $app.ActiveSheet.Cells.RowHeight = 1 * 72 / 2.54 + 0.5            # 1cm
        # ---
        $pos = 1
        $col | ForEach-Object {
            $line = $_
            $w = [float]$line.width / 10 * 72 / 2.54
            $h = [float]$line.height / 10 * 72 / 2.54
            $s = $line.text

            $r = [float]$line.r
            $n1 = [int]$line.n1
            $n2 = [int]$line.n2
            $n3 = [int]$line.n3
            $n4 = [int]$line.n4

            $x = ([float]$line.x + 10) / 10 * 72 / 2.54
            $y = ([float]$line.y + 10) / 10 * 72 / 2.54
            $a = [int]$line.angle % 360

            "${pos}: ${s}" | Out-Host
            $app.ActiveSheet.Shapes.AddShape(1, ($x + 100), ($y + 100), $w, $h).Select()
            $app.Selection.ShapeRange.TextFrame2.TextRange.Text = $s
            $app.Selection.ShapeRange.TextFrame2.TextRange.Font.Fill.ForeColor.RGB = [int]0
            $app.Selection.ShapeRange.TextFrame.HorizontalOverflow = 0
            $app.Selection.ShapeRange.Fill.ForeColor.RGB = [int]$line.color
            if ([int]($line.font) -ne 0) {
                $app.Selection.ShapeRange.TextFrame2.TextRange.Font.Size = [int]$line.font
            }
            if ((($n1 + $n2 + $n3 + $n4) * $r) -gt 0) {
                $grp = @($app.Selection.ShapeRange.Name)
                $grp += gen_pin $app $n1 $x $y $x ($y + $h) (-$r) 0 6
                $grp += gen_pin $app $n2 $x ($y + $h) ($x + $w) ($y + $h) 0 $r 6
                $grp += gen_pin $app $n3 ($x + $w) ($y + $h) ($x + $w) $y $r 0 6
                $grp += gen_pin $app $n4 ($x + $w) $y $x $y 0 (-$r) 6
                $app.ActiveSheet.Shapes.Range($grp).Group().Select()
            }
            $app.Selection.ShapeRange.TextFrame2.AutoSize = 0
            $app.Selection.ShapeRange.TextFrame2.WordWrap = 0
            $app.Selection.ShapeRange.TextFrame2.VerticalAnchor = 3
            $app.Selection.ShapeRange.TextFrame2.HorizontalAnchor = 2
            $app.Selection.ShapeRange.TextFrame2.MarginLeft = 2.83
            $app.Selection.ShapeRange.TextFrame2.MarginRight = 2.83
            $app.Selection.ShapeRange.TextFrame2.MarginTop = 2.83
            $app.Selection.ShapeRange.TextFrame2.MarginBottom = 2.83
            $app.Selection.ShapeRange.LockAspectRatio = -1
            if ($a) { $app.Selection.ShapeRange.Rotation = $a }
            $app.Selection.Placement = 3
            $pos ++
            # $name = $app.Selection.ShapeRange.Name
            # "name: ${name}" | Out-Host
        }
        # ---
        $book.SaveAs($out, 51)
        "end generate" | Out-Host
    }
    catch {
    }
    finally {
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
