$ErrorActionPreference = 'Stop'
$destRoot = "$env:USERPROFILE\dev\forks\JZKK720"
$dest = Join-Path $destRoot 'headroom'
New-Item -ItemType Directory -Force -Path $destRoot | Out-Null
if (-not (Test-Path $dest)) {
  git clone --depth 1 "https://github.com/JZKK720/headroom.git" $dest
}
Write-Host (Test-Path $dest)
