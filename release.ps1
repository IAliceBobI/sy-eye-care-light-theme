$projDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location -Path $projDir

$themeJson = Get-Content -Raw -Path $projDir\theme.json | ConvertFrom-Json
$currentVersion = $themeJson.version
$major, $minor, $patch = $currentVersion -split '\.'
$patch = [int]$patch + 1
$newVersion = "$major.$minor.$patch"
$themeJson.version = $newVersion
$themeJson | ConvertTo-Json -Depth 100 | Set-Content -Path $projDir\theme.json

git add -A
git commit -m "auto"
git tag v$newVersion
git push origin v$newVersion
git push origin

.\deploy.ps1

