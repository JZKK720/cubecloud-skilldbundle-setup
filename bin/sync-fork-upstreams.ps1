<#
.SYNOPSIS
  Add an `upstream` remote to each JZKK720 fork mirror and fast-forward sync it
  with the real upstream source, so forks track upstream instead of drifting.

.DESCRIPTION
  Each fork mirror in ~/dev/forks/JZKK720/ was cloned from the JZKK720 fork and
  only has an `origin` remote. This script:
    1. Adds an `upstream` remote pointing at the real upstream repo (if missing).
    2. Fetches upstream.
    3. Fast-forwards the local default branch to upstream's default branch.
  It is idempotent and safe: it never force-pushes, never rewrites history, and
  leaves the fork's `origin` remote untouched.

.PARAMETER ForksRoot
  Root directory containing the fork mirrors. Default: ~/dev/forks/JZKK720

.PARAMETER DryRun
  Show what would be done without changing anything.

.EXAMPLE
  .\sync-fork-upstreams.ps1
  .\sync-fork-upstreams.ps1 -DryRun
#>
[CmdletBinding()]
param(
    [string]$ForksRoot = "$env:USERPROFILE\dev\forks\JZKK720",
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

# Map: local fork dir name -> real upstream owner/repo
$upstreamMap = @{
    "Gskills"                     = "google/skills"
    "caveman"                     = "JuliusBrussee/caveman"
    "last30days-skill"            = "mvanhorn/last30days-skill"
    "EverOS"                      = "EverMind-AI/EverOS"
    "agentskills"                 = "agentskills/agentskills"
    "markitdown"                  = "microsoft/markitdown"
    "firecrawl"                   = "firecrawl/firecrawl"
    "ponytail"                    = "DietrichGebert/ponytail"
    "improve"                     = "shadcn/improve"
    "headroom"                    = "headroomlabs-ai/headroom"
    "taste-skill"                 = "Leonxlnx/taste-skill"
    "ECC"                         = "affaan-m/ECC"
    "gstack"                      = "garrytan/gstack"
    "gbrain"                      = "garrytan/gbrain"
    "agent-skills"                = "addyosmani/agent-skills"
    "spec-kit"                    = "github/spec-kit"
    "superpowers"                 = "obra/superpowers"
    "llm_wiki"                    = "nashsu/llm_wiki"
    "hallmark"                    = "Nutlope/hallmark"
    "Scrapling"                   = "D4Vinci/Scrapling"
    "graphify"                    = "Graphify-Labs/graphify"
    "oz-skills"                   = "warpdotdev/oz-skills"
    "loop-engineering"            = "cobusgreyling/loop-engineering"
    "awesome-design-md"           = "VoltAgent/awesome-design-md"
    "SkillOpt"                    = "microsoft/SkillOpt"
    "open-code-review"            = "alibaba/open-code-review"
    "compound-engineering-plugin" = "EveryInc/compound-engineering-plugin"
    "awesome-llm-apps"            = "Shubhamsaboo/awesome-llm-apps"
}

if (-not (Test-Path $ForksRoot)) {
    Write-Host "Forks root not found: $ForksRoot" -ForegroundColor Red
    exit 1
}

$ok = 0; $skipped = 0; $failed = 0

foreach ($dir in (Get-ChildItem $ForksRoot -Directory | Sort-Object Name)) {
    $name = $dir.Name
    if (-not $upstreamMap.ContainsKey($name)) {
        Write-Host "  SKIP $name (no upstream mapping)" -ForegroundColor DarkYellow
        $skipped++
        continue
    }
    $upstream = $upstreamMap[$name]
    $repo = $dir.FullName

    # Determine default branch
    $defaultBranch = git -C $repo symbolic-ref --short HEAD 2>$null
    if (-not $defaultBranch) { $defaultBranch = "main" }

    if ($DryRun) {
        Write-Host "  [dry-run] $name : add upstream=$upstream, fetch, ff $defaultBranch"
        continue
    }

    try {
        # Add upstream remote if missing
        $remotes = git -C $repo remote
        if ($remotes -notcontains "upstream") {
            git -C $repo remote add upstream "https://github.com/$upstream.git" 2>$null
            Write-Host "  $name : added upstream -> $upstream" -ForegroundColor Green
        }

        # Fetch upstream
        git -C $repo fetch upstream 2>$null
        if ($LASTEXITCODE -ne 0) { throw "fetch failed" }

        # Fast-forward local default branch to upstream default branch
        $upstreamBranch = "upstream/$defaultBranch"
        $localHead = git -C $repo rev-parse HEAD 2>$null
        $upstreamHead = git -C $repo rev-parse "$upstreamBranch" 2>$null
        if (-not $upstreamHead) {
            Write-Host "  $name : upstream branch '$upstreamBranch' not found, skipping" -ForegroundColor DarkYellow
            $skipped++
            continue
        }
        if ($localHead -eq $upstreamHead) {
            Write-Host "  $name : already up to date" -ForegroundColor DarkGray
            $skipped++
            continue
        }
        git -C $repo merge --ff-only "$upstreamBranch" 2>$null
        if ($LASTEXITCODE -ne 0) { throw "ff merge failed (local changes?)" }
        Write-Host "  $name : fast-forwarded to upstream ($upstreamBranch)" -ForegroundColor Green
        $ok++
    }
    catch {
        Write-Host "  $name : FAILED - $($_.Exception.Message)" -ForegroundColor Red
        $failed++
    }
}

Write-Host ""
Write-Host "Done. Synced: $ok, Already-up-to-date/skipped: $skipped, Failed: $failed" -ForegroundColor Cyan
