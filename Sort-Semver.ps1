# började 16:37
$versionDirs = Get-ChildItem -Recurse | Where-Object { $_.PSIsContainer }
$sortedDirs = $versionDirs | Select-Object -ExpandProperty Name | % { New-Object -TypeName System.Version -ArgumentList $_ } | Sort-Object
Write-Host $versionDirs
Write-Host $sortedDirs
