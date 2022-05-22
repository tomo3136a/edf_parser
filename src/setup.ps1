$app = "edif2xml"
#Add-Type -OutputType WindowsApplication
Add-Type -OutputType ConsoleApplication `
  -Path "./*.cs" `
  -OutputAssembly (Join-Path (Resolve-Path "..") "${app}.exe") `
  -ReferencedAssemblies "System.Configuration", `
  "System.Xml", "System.Windows.Forms"
