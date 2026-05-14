# Vue Vben CRUD Code Quality Check Script (PowerShell)
# Usage: powershell -File .trae/skills/project-page-builder/scripts/check.ps1 -ApiPath <api-path> -ViewsPath <views-path>
# Example: powershell -File .trae/skills/project-page-builder/scripts/check.ps1 -ApiPath src/api/system/push -ViewsPath src/views/system/push

param(
    [Parameter(Mandatory=$true)][string]$ApiPath,
    [Parameter(Mandatory=$true)][string]$ViewsPath
)

Write-Host "🔍 Starting checks"
Write-Host "   API  path: $ApiPath"
Write-Host "   Views path: $ViewsPath"
$Errors = 0

# ── 1. Check Required Files ─────────────────────────
Write-Host ""
Write-Host "📌 Step 1: Check if all required files are generated"

$Files = @(
    "$ApiPath/types.ts",
    "$ApiPath/index.ts",
    "$ViewsPath/index.vue",
    "$ViewsPath/modules/form.vue",
    "$ViewsPath/data.ts"
)

foreach ($File in $Files) {
    if (-not (Test-Path $File)) {
        Write-Host "❌ Missing file: $File"
        $Errors++
    } else {
        Write-Host "✅ $File"
    }
}

# ── 2. Check Relative Paths ─────────────────────────────────
Write-Host ""
Write-Host "📌 Step 2: Check for relative paths (should use #/ alias)"

$Relative = Get-ChildItem -Path $ApiPath, $ViewsPath -Recurse -Include *.ts,*.vue -ErrorAction SilentlyContinue | Select-String -Pattern "\.\.\/" -ErrorAction SilentlyContinue
if ($Relative) {
    Write-Host "⚠️  Found relative paths (sub-module imports like '../data' are acceptable):"
    $Relative | ForEach-Object { Write-Host "   $($_.RelativePath):$($_.LineNumber): $($_.Line.Trim())" }
} else {
    Write-Host "✅ No relative paths"
}

# ── 3. Check 'any' Type Abuse ────────────────────────────
Write-Host ""
Write-Host "📌 Step 3: Check for 'any' type abuse"

$AnyUsage = Get-ChildItem -Path $ApiPath, $ViewsPath -Recurse -Include *.ts,*.vue -ErrorAction SilentlyContinue | Select-String -Pattern ": any" -ErrorAction SilentlyContinue
if ($AnyUsage) {
    Write-Host "⚠️  Found 'any' type, recommend replacing with specific types:"
    $AnyUsage | ForEach-Object { Write-Host "   $($_.RelativePath):$($_.LineNumber): $($_.Line.Trim())" }
} else {
    Write-Host "✅ No 'any' type abuse"
}

# ── 4. Summary ─────────────────────────────────────
Write-Host ""
Write-Host "════════════════════════════════"
if ($Errors -gt 0) {
    Write-Host "❌ Checks failed, found $Errors error(s), please fix and re-run the script"
    exit 1
}
Write-Host "🎉 All checks passed, ready to output final summary"
