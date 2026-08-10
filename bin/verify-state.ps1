$ErrorActionPreference = 'Stop'
$env:PATH = "$env:USERPROFILE\.local\bin;$env:USERPROFILE\.bun\bin;$env:APPDATA\npm;$env:PATH"

Write-Host '=== CLI CHECK ==='
$tools = @(
  'skillspector','skills-ref','specify','skillopt-eval','agent-reach','graphify',
  'markitdown','scrapling','uipro','firecrawl','gbrain','headroom'
)
foreach ($t in $tools) {
  $cmd = Get-Command $t -ErrorAction SilentlyContinue
  if ($cmd) {
    Write-Host "PASS $t -> $($cmd.Source)"
  } else {
    Write-Host "MISS $t"
  }
}

Write-Host "`n=== MCP CHECK ==="
$mcpPath = "$env:APPDATA\Code\User\mcp.json"
if (-not (Test-Path $mcpPath)) {
  Write-Host "MISS mcp.json at $mcpPath"
  exit 1
}
try {
  $m = Get-Content $mcpPath -Raw | ConvertFrom-Json
  Write-Host 'PASS mcp.json valid'
  $m.servers.PSObject.Properties.Name | ForEach-Object { Write-Host "SERVER $_" }
} catch {
  Write-Host "FAIL mcp.json invalid: $($_.Exception.Message)"
  exit 1
}
