[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$PayloadDirectory,
    [Parameter(Mandatory)][string]$OutputDirectory,
    [Parameter(Mandatory)][string]$IsccPath
)
$ErrorActionPreference = 'Stop'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$payload = (Resolve-Path -LiteralPath $PayloadDirectory).Path
$compiler = (Resolve-Path -LiteralPath $IsccPath).Path
$exeName = 'Harbor-Studio.exe'
if (-not (Test-Path -LiteralPath (Join-Path $payload $exeName) -PathType Leaf)) {
    throw "Missing $exeName in payload directory"
}
# Package only distributable files. Never package settings/recovery from a running install.
$inputFiles = @(Get-ChildItem -LiteralPath $payload -Recurse -Force)
if ($inputFiles | Where-Object { $_.Attributes -band [IO.FileAttributes]::ReparsePoint }) {
    throw 'Payload must not contain reparse points'
}
$toml = Get-Content -LiteralPath (Join-Path $repo 'Cargo.toml') -Raw
$match = [regex]::Match($toml, '(?ms)^\[workspace\.package\]\s*.*?^version\s*=\s*"([0-9]+\.[0-9]+\.[0-9]+)"')
if (-not $match.Success) { throw 'Workspace version not found' }
$version = $match.Groups[1].Value
$out = [IO.Path]::GetFullPath($OutputDirectory)
New-Item -ItemType Directory -Force -Path $out | Out-Null
$stage = Join-Path $out ('stage-Harbor-Studio-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $stage | Out-Null
Copy-Item -LiteralPath (Join-Path $payload $exeName) -Destination $stage
Copy-Item -LiteralPath (Join-Path $repo 'assets/harbor/icon.ico') -Destination (Join-Path $stage 'Harbor.ico')
foreach ($file in Get-ChildItem -LiteralPath $payload -File) {
    if ($file.Name -match '^(LICENSE.*|NOTICE|ATTRIBUTION\.(md|toml)|README\.txt|portable\.txt)$') {
        Copy-Item -LiteralPath $file.FullName -Destination $stage
    }
}
foreach ($name in @('licenses', 'dependency-notices')) {
    $directory = Join-Path $payload $name
    if (Test-Path -LiteralPath $directory -PathType Container) {
        Copy-Item -LiteralPath $directory -Destination $stage -Recurse
    }
}
if (-not (Test-Path (Join-Path $stage 'licenses'))) { throw 'License notices directory is required' }
& $compiler "/DPayloadDir=$stage" "/DOutputDir=$out" "/DAppVersion=$version" (Join-Path $PSScriptRoot 'installer.iss')
if ($LASTEXITCODE -ne 0) { throw "Installer compilation failed: $LASTEXITCODE" }
$setup = Join-Path $out "Harbor-Studio-$version-windows-x64-setup.exe"
Get-FileHash -LiteralPath $setup -Algorithm SHA256
