$Sources = "src/edif2xml.cs"
$ReferencedAssemblies = "System.Xml", "System.Windows.Forms"
$OutputPath = Join-Path (Resolve-Path ".") "edif2xml.exe"

#Add-Type -OutputType WindowsApplication
Add-Type -OutputType ConsoleApplication `
  -Path $Sources -OutputAssembly $OutputPath `
  -ReferencedAssemblies $ReferencedAssemblies
