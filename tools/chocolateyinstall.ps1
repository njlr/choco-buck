$ErrorActionPreference = 'Stop';

$packageName = 'buck';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";

$extractionPath = "C:\" + $packageName
$url = "https://github.com/facebook/buck/archive/v" + $env:ChocolateyPackageVersion + ".zip"

Install-ChocolateyZipPackage "$packageName" "$url" "$extractionPath"

$buckPath = $extractionPath + "\" + $packageName + "-" + $env:ChocolateyPackageVersion

cd $buckPath;

Write-Output "Building Buck... "

ant;

Write-Output "Finished building Buck. "

$executablePath = $buckPath + "\bin\buck";

Install-ChocolateyPath $executablePath;
