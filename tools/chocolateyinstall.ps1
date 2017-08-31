# Ensure that ant is available
refreshenv;

python --version;
java -version;
ant -version;

$ErrorActionPreference = 'Stop';

$packageName = 'buck';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";

$clonePath = $env:SystemDrive + "\buck";

If (!(Test-Path -Path $clonePath)) {
  Write-Output "Cloning Buck... ";
  git clone "https://github.com/facebook/buck.git" $clonePath;
}

cd $clonePath;

$branch = ("tags/v" + $env:ChocolateyPackageVersion);
Write-Output $branch;
git checkout -q $branch;

Write-Output "Building Buck... ";

$javaargs = "-Djna.nosys=true";
$javaargs | Out-File -encoding ASCII ".buckjavaargs.local";

ant;

$binFilePath = $clonePath + "\bin\buck.bat";

Write-Output $binFilePath;

Install-BinFile "buck" $binFilePath
