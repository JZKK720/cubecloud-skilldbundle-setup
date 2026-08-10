$ErrorActionPreference = 'Stop'

$agentsRoot = "$env:USERPROFILE\.agents"
$skillsRoot = "$agentsRoot\skills"
$claudeRoot = "$env:USERPROFILE\.claude\skills"
$upstreamRoot = "$env:USERPROFILE\dev\upstream"

New-Item -ItemType Directory -Force -Path $agentsRoot | Out-Null
New-Item -ItemType Directory -Force -Path $claudeRoot | Out-Null
New-Item -ItemType Directory -Force -Path $upstreamRoot | Out-Null

@(
  '# Global Agent Skills Stack',
  '',
  'This directory is the VS Code Copilot Chat skill discovery root.',
  'See ~/dev/setup/SETUP_GUIDE.md for full setup instructions.',
  '',
  '## Install pipeline',
  'All skills installed via ~/dev/bin/install-skill.ps1 (SkillSpector scan -> skills-ref validate -> copy).',
  '',
  '## Security policy',
  'SkillSpector is a hard gate. No skill lands without a passing scan (exit 0).',
  'See ~/dev/upstream/SCAN_LOG.md for full verdict history.'
) | Out-File "$agentsRoot\README.md" -Encoding UTF8

@(
  '# Known Conflicts',
  '',
  'Active methodology: superpowers (single).',
  'Caveman: disabled by default (opt-in token compression).',
  'Memory: gbrain MCP (primary).'
) | Out-File "$agentsRoot\CONFLICTS.md" -Encoding UTF8

@(
  '# Memory Policy',
  '',
  'Primary: gbrain MCP (PGLite, zero-config).',
  'EverOS: Windows-incompatible (fcntl). Not used.',
  'recall: Claude Code only (needs hooks).'
) | Out-File "$agentsRoot\MEMORY_POLICY.md" -Encoding UTF8

@(
  '# Update Policy',
  '',
  'Monthly: git pull upstreams, re-scan changed skills, uv tool upgrade --all.',
  'After any skill change: reload VS Code window.'
) | Out-File "$agentsRoot\UPDATE_POLICY.md" -Encoding UTF8

$scanLog = "$upstreamRoot\SCAN_LOG.md"
if (-not (Test-Path $scanLog)) {
  @(
    '# SkillSpector Scan Log',
    '',
    '| Date | Repo | Skill | Verdict | Status | Notes |',
    '|---|---|---|---|---|---|'
  ) | Out-File $scanLog -Encoding UTF8
}

$skillDirs = Get-ChildItem $skillsRoot -Directory -ErrorAction Stop
foreach ($sd in $skillDirs) {
  $dest = Join-Path $claudeRoot $sd.Name
  if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
  New-Item -ItemType Directory -Force -Path $dest | Out-Null
  Copy-Item -Path (Join-Path $sd.FullName '*') -Destination $dest -Recurse -Force
}

Write-Host "Synced $($skillDirs.Count) skills to $claudeRoot"
Write-Host 'Governance docs repaired'
