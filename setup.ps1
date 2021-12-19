#build edif2xml.exe
#
$AppName = "edif2xml.exe"
$OutputPath = "."

$Sources = "src/edif2xml.cs"
$ReferencedAssemblies = "System.Xml", "System.Drawing", "System.Windows.Forms"
#$orgs = "setup1.org", "setup2.org", "setup3.org"

if (-not (Test-Path "$OutputPath")) {
  New-Item "$OutputPath" -ItemType Directory
}
$OutputPath = Join-Path (Resolve-Path "$OutputPath") "$AppName"

Write-Host "build start." -ForegroundColor Yellow

$OutputDir = Resolve-Path (Join-Path "$OutputPath" "..")
if (-not (Test-Path "$OutputDir")) {
  New-Item "$OutputDir" -ItemType Directory
  Write-Output "make directory."
}

Write-Output "build appication: $AppName"
Write-Output "    Sources:    $Sources"
Write-Output "    OutputPath: $OutputPath"
Write-Output "    References: $ReferencedAssemblies"
#Add-Type -OutputType WindowsApplication
Add-Type -OutputType ConsoleApplication `
  -Path $Sources -OutputAssembly $OutputPath `
  -ReferencedAssemblies $ReferencedAssemblies
Write-Output "build completed."

#$host.UI.RawUI.ReadKey() | Out-Null
