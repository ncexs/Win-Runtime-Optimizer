# ==========================================================
# Win Runtime Optimizer FINAL
# Full Auto | Win10/11 | SSD/HDD Aware | WA Safe
# ==========================================================

param([switch]$Silent)

$ErrorActionPreference = "SilentlyContinue"
$LogPath = "$PSScriptRoot\optimizer-final-log.txt"

# ==========================================================
# RESET LOG EACH RUN
# ==========================================================

if (Test-Path $LogPath) {
    Remove-Item $LogPath -Force -ErrorAction SilentlyContinue
}

New-Item -Path $LogPath -ItemType File -Force | Out-Null

# ==========================================================
# LOG FUNCTION
# ==========================================================

function Write-Log {
    param([string]$Text)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogPath -Value "[$timestamp] $Text"
    if (-not $Silent) { Write-Host $Text }
}

function Clear-FolderSafe {
    param([string]$Path)
    if (Test-Path $Path) {
        Get-ChildItem $Path -Recurse -Force -ErrorAction SilentlyContinue |
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        Write-Log "Cleaned: $Path"
    }
}

function Set-ServiceStartupSafely {
    param(
        [string]$Name,
        [string]$Mode
    )
    $svc = Get-Service -Name $Name -ErrorAction SilentlyContinue
    if ($svc -and $svc.StartType -ne $Mode) {
        Set-Service -Name $Name -StartupType $Mode
        Write-Log "Service $Name set to $Mode"
    }
}

# ==========================================================
# SYSTEM DETECTION
# ==========================================================

$OSCaption = (Get-CimInstance Win32_OperatingSystem).Caption
$OSVersion = (Get-CimInstance Win32_OperatingSystem).Version
$TotalRAM = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB,2)
$DriveType = (Get-PhysicalDisk | Select-Object -First 1).MediaType

$IsWin11 = $OSVersion -like "10.0.2*"
$LowRAM = $TotalRAM -le 8
$IsHDD = $DriveType -eq "HDD"

Write-Log "OS: $OSCaption"
Write-Log "RAM: $TotalRAM GB"
Write-Log "Drive: $DriveType"

# ==========================================================
# 1. AUTO SERVICE TUNING
# ==========================================================

Write-Log "Auto service tuning..."

# SysMain logic
if ($LowRAM -and $IsHDD) {
    Safe-SetService "SysMain" "Manual"
} else {
    Safe-SetService "SysMain" "Automatic"
}

# Search logic
if ($LowRAM) {
    Safe-SetService "WSearch" "Manual"
} else {
    Safe-SetService "WSearch" "Automatic"
}

# Telemetry ringan
Safe-SetService "DiagTrack" "Manual"

# Xbox services (non-critical)
Safe-SetService "XblGameSave" "Manual"
Safe-SetService "XboxNetApiSvc" "Manual"

# Win11 specific tweak
if ($IsWin11 -and $LowRAM) {
    Safe-SetService "ClipSVC" "Manual"
}

# ==========================================================
# 2. SYSTEM CLEAN
# ==========================================================

Write-Log "Cleaning temp..."

Clear-FolderSafe "$env:TEMP"
Clear-FolderSafe "C:\Windows\Temp"

if ($IsHDD) {
    Clear-FolderSafe "C:\Windows\Prefetch"
}

Stop-Service wuauserv -Force
Clear-FolderSafe "C:\Windows\SoftwareDistribution\Download"
Start-Service wuauserv

# ==========================================================
# 3. WA SAFE MULTI-BROWSER CACHE CLEAN (PROCESS AWARE)
# ==========================================================

Write-Log "Browser safe clean..."

function Test-BrowserRunning {
    return Get-Process chrome,msedge,brave,opera -ErrorAction SilentlyContinue
}

if (-not (Test-BrowserRunning)) {

    $BrowserProfiles = @(
        "$env:LOCALAPPDATA\Google\Chrome\User Data",
        "$env:LOCALAPPDATA\Microsoft\Edge\User Data",
        "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data",
        "$env:APPDATA\Opera Software"
    )

    foreach ($base in $BrowserProfiles) {
        if (Test-Path $base) {
            Get-ChildItem $base -Directory | ForEach-Object {
                $BrowserProfilePath = $_.FullName
                $SafeCache = @(
                    "$BrowserProfilePath\Cache",
                    "$BrowserProfilePath\Code Cache"
                )
                foreach ($c in $SafeCache) {
                    Clear-FolderSafe $c
                }
            }
        }
    }

    Write-Log "Browser cache cleaned safely."

} else {

    Write-Log "Browser running. Cache clean skipped."

}

# ==========================================================
# 4. MEMORY STRATEGY (LOW RAM ONLY)
# ==========================================================

if ($LowRAM) {

$signature = @"
using System;
using System.Runtime.InteropServices;
public class Mem {
    [DllImport("psapi.dll")]
    public static extern int EmptyWorkingSet(IntPtr hwProc);
}
"@

Add-Type $signature -ErrorAction SilentlyContinue

Get-Process | Where-Object {
    $_.ProcessName -notmatch "chrome|msedge|brave|opera"
} | ForEach-Object {
    try { [Mem]::EmptyWorkingSet($_.Handle) } catch {}
}

Write-Log "Low RAM memory trim executed."
}

ipconfig /flushdns | Out-Null

Write-Log "Optimization completed."
