$csvPath = "setup\skills-list.csv"
$lines = Get-Content $csvPath
foreach ($line in $lines) {
    if ($line -match "^\s*#" -or $line -match "^\s*$") { continue }
    $parts = $line -split '\|'
    $repo = $parts[0].Trim()
    $name = $parts[1].Trim()
    $skillRelPath = $parts[2].Trim()
    $disabled = $parts[3].Trim()
    if ($disabled -eq "true") { continue }
    $args = @("-Repo", $repo, "-Name", $name)
    if ($skillRelPath) { $args += @("-SkillRelPath", $skillRelPath) }
    & ".\setup\install-skill.ps1" @args
}