$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectDir

$projName = Split-Path -Leaf $projectDir
$noteDir = Split-Path -Parent $env:SYPLUGINDIR
$noteDir = Split-Path -Parent $noteDir
$targetDir = "$noteDir\conf\appearance\themes\$projName"

Remove-Item -Path $targetDir -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $targetDir | Out-Null
Copy-Item -Path "$projectDir/*" `
    -Exclude .git, .github, .gitignore `
    -Destination $targetDir -Recurse -Force -ErrorAction SilentlyContinue
