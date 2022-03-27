$p = Get-Date -Format "yyyyMMdd_hhmmss"
New-Item -ItemType Directory $p | Out-Null
while ($True) {
  $img = Get-Clipboard -Format Image
  if (-not $img) { Start-Sleep 1; continue }
  $img.Save("./${p}/{0:00}.bmp" -f (++$idx))
  "Saved {0:00}" -f $idx | Out-Host
  Set-Clipboard $null
}
