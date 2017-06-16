$ErrorActionPreference = 'Stop';

$packageName = 'buck';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";

Write-Output "Cloning Buck... "
cd C:\;
If (!(Test-Path -Path "buck")) {
  git clone "https://github.com/facebook/buck.git";
}
cd buck;
$branch = ("tags/v" + $env:ChocolateyPackageVersion);
Write-Output $branch
git checkout -q $branch;
Write-Output "Done. "

Write-Output "Building Buck... "
ant;
Write-Output "Done. "

Install-ChocolateyPath "C:\buck\bin\buck";
