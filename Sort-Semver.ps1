param (
  [switch] $PreRelease
)
# började 16:37
$suffix = ""
if($PreRelease) {
  $suffix = "-"
}
$versionDirs = Get-ChildItem -Recurse | Where-Object { $_.PSIsContainer } | Where-Object { $_.Name -match ("^[0-9]+\.[0-9]+\.[0-9]+" + $suffix) }
$sortedDirs = $versionDirs | Select-Object -ExpandProperty Name | % { New-Object -TypeName System.Version -ArgumentList $_ } | Sort-Object
Write-Host $versionDirs
Write-Host $sortedDirs
