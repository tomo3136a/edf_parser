$path = "parts_list.csv"
$out = "parts_out.xlsx"

$path = (Get-Location).path + "\" + $path
$out = (Get-Location).path + "\" + $out

try {
    $app = New-Object -ComObject Excel.Application
    #$app.Visible = $False
    #$app.DisplayAlerts = $False
    $book = $app.Workbooks.Add()
    
    $sheet = $app.Worksheets.Item(1)
    $sheet.Name = $sheet.Name -replace "sheet", "ê}"
    # ---
    $sheet.Cells.ColumnWidth = 1 * (72 / 2.54 / 10) + 1.3 # 10mm
    $sheet.Cells.RowHeight = 1 * 72 / 2.54 + 0.5        # 1cm
    
    $col = Import-Csv $path -Delimiter "`t"
    $col | ForEach-Object {
        $line=$_
        $w = [int]($line.width)/10
        $h = [int]($line.height)/10
        $shape = $sheet.Shapes.AddShape(1, 100, 100, $w * 72 / 2.54, $h * 72 / 2.54)
        $shape.ShapeStyle = 1
        $shape.Placement = 3
        $shape.LockAspectRatio = -1
        $shape.TextFrame2.WordWrap = 0
        $shape.TextFrame2.VerticalAnchor = 3
        $shape.TextFrame2.HorizontalAnchor = 2
        $shape.TextFrame2.MarginLeft = 2.83
        $shape.TextFrame2.MarginRight = 2.83
        $shape.TextFrame2.MarginTop = 2.83
        $shape.TextFrame2.MarginBottom = 2.83
        $shape.TextFrame2.TextRange.Text = $line.text
        $shape.Fill.ForeColor.RGB = [int]($line.color)
    }

    # ---
    $book.SaveAs($out, 51)
}
catch {
}
finally {
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
