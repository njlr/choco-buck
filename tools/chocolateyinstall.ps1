# Ensure that ant is available
refreshenv;

$ErrorActionPreference = 'SilentlyContinue';

$packageName = 'buck';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";

$clonePath = $env:SystemDrive + "\buck";

$tag = "v" + $env:ChocolateyPackageVersion;
$branch = "tags/" + $tag;

Write-Output $branch;

If (!(Test-Path -Path $clonePath)) {
  Write-Output "Cloning Buck... ";
  Write-Output "git clone --branch $tag --single-branch https://github.com/facebook/buck.git $clonePath";
  git clone --quiet --branch $tag --single-branch https://github.com/facebook/buck.git $clonePath;
  cd $clonePath;
} else {
  cd $clonePath;
  git checkout -q $branch;
}

Write-Output "Building Buck... ";

$env:BUCK_EXTRA_JAVA_ARGS = "-Djna.nosys=true";

$javaargs = "-Djna.nosys=true";
$javaargs | Out-File -encoding ASCII ".buckjavaargs.local";

ant;
bin\\buck build buck;

$binFilePath = $clonePath + "\bin\buck.bat";

Write-Output $binFilePath;

Install-BinFile "buck" $binFilePath
