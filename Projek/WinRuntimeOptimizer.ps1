# =====================================================
# Win Runtime Optimizer
# Silent | Safe | Scheduler Ready
# =====================================================

$ErrorActionPreference = "SilentlyContinue"

# -------------------------------
# Helper: Clear folder contents
# -------------------------------
function Clear-FolderSafe {
    param ([string]$Path)

    if (Test-Path $Path) {
        Get-ChildItem $Path -Force -ErrorAction SilentlyContinue |
            Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# -------------------------------
# Detect active browsers (IMPORTANT)
# -------------------------------
$activeBrowsers = @(
    "chrome",
    "msedge",
    "brave",
    "firefox"
)

$runningBrowserNames = Get-Process -ErrorAction SilentlyContinue |
    Where-Object { $activeBrowsers -contains $_.ProcessName } |
    Select-Object -ExpandProperty ProcessName -Unique

# -------------------------------
# Browser Cache Cleanup (SAFE ONLY)
# Tidak sentuh login/session WA Web
# -------------------------------
$browserProfiles = @{
    Chrome = "$env:LOCALAPPDATA\Google\Chrome\User Data"
    Edge   = "$env:LOCALAPPDATA\Microsoft\Edge\User Data"
    Brave  = "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data"
}

foreach ($browser in $browserProfiles.Keys) {

    # Skip cleanup jika browser sedang aktif
    if ($runningBrowserNames -contains $browser.ToLower()) { continue }

    $root = $browserProfiles[$browser]

    if (Test-Path $root) {
        Get-ChildItem $root -Directory | ForEach-Object {
            Clear-FolderSafe "$($_.FullName)\Cache"
            Clear-FolderSafe "$($_.FullName)\Code Cache"
            Clear-FolderSafe "$($_.FullName)\GPUCache"
            Clear-FolderSafe "$($_.FullName)\ShaderCache"
        }
    }
}

# -------------------------------
# Firefox Cache Cleanup (SAFE)
# -------------------------------
if (-not ($runningBrowserNames -contains "firefox")) {
    $firefoxProfiles = "$env:APPDATA\Mozilla\Firefox\Profiles"
    if (Test-Path $firefoxProfiles) {
        Get-ChildItem $firefoxProfiles -Directory | ForEach-Object {
            Clear-FolderSafe "$($_.FullName)\cache2"
            Clear-FolderSafe "$($_.FullName)\startupCache"
        }
    }
}

# -------------------------------
# System Cache (Aman & umum)
# -------------------------------
$systemTargets = @(
    $env:TEMP,
    "$env:SystemRoot\Temp",
    "$env:SystemRoot\Prefetch",
    "$env:LOCALAPPDATA\AMD\DxCache",
    "$env:LOCALAPPDATA\NVIDIA\GLCache",
    "$env:LOCALAPPDATA\Intel\ShaderCache"
)

foreach ($path in $systemTargets) {
    Clear-FolderSafe $path
}

# -------------------------------
# RAM Optimization (Selective)
# Skip browser & system critical
# -------------------------------
Add-Type @"
using System;
using System.Runtime.InteropServices;

public static class RamCleaner {
    [DllImport("psapi.dll")]
    public static extern bool EmptyWorkingSet(IntPtr hProcess);
}
"@

Get-Process | Where-Object {
    $_.Id -ne $PID -and
    $_.ProcessName -notmatch "chrome|msedge|brave|firefox|explorer|dwm"
} | ForEach-Object {
    try {
        [RamCleaner]::EmptyWorkingSet($_.Handle) | Out-Null
    } catch {}
}

[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()

exit 0
