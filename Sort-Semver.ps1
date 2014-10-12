#param (
#  [switch] $PreRelease
#)
$suffix = ""
#if($PreRelease) {
#  $suffix = "-"
#}

Function CompareTo ($adir, $bdir) 
{
  $a = $adir.Name
  $b = $bdir.Name

  $semverregex = "^([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?(?:\+[0-9A-Za-z-]+)?$"
  $a -match $semverregex
  [int]$amajor = $Matches[1]
  [int]$aminor = $Matches[2]
  [int]$apatch = $Matches[3]
  [int]$apatch = $Matches[3]
  $aprerelease = $Matches[4]
  Write-Host $a $amajor + $aminor + $apatch + $aprerelease

  $b -match $semverregex
  [int]$bmajor = $Matches[1]
  [int]$bminor = $Matches[2]
  [int]$bpatch = $Matches[3]
  [int]$bpatch = $Matches[3]
  $bprerelease = $Matches[4]

  if( $a -lt $b) 
  {
    return -1
  } elseif ($a -eq $b) {
    return 0
  } else {
    return 1
  }
}

Function Sort-Dirs
{
  param ( $theArray = @() ) 
 
  # False when swaps occur 
  [bool] $sorted = $false 
  $counter = 0 
  for ($pass = 1; ($pass -lt $theArray.Count) -and -not $sorted; $pass++) 
  { 
      # Assume the array is sorted 
      $sorted = $true 
      for ($index = 0; $index -lt ($theArray.Count - $pass); $index++) 
      { 
          $counter++ 
          $nextIndex = $index + 1 
          if ((CompareTo $theArray[$index] $theArray[$nextIndex]) -gt 0) 
          { 
              # Swap items 
              $temp = $theArray[$index] 
              $theArray[$index] = $theArray[$nextIndex] 
              $theArray[$nextIndex] = $temp 
              $sorted = $false 
          } 
      } 
  }
  return $theArray  
}

$versionDirs = Get-ChildItem -Recurse | Where-Object { $_.PSIsContainer } | Where-Object { $_.Name -match ("^[0-9]+\.[0-9]+\.[0-9]+" + $suffix) } | Sort-Object -Property LastWriteTime

Write-Host 'ver' $versionDirs
 
$sortedDirs = Sort-Dirs $versionDirs

Write-Host 'sor' $sortedDirs
