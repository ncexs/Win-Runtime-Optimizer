# ==========================================================
# WIN RUNTIME OPTIMIZER (v2.0.0-Auto)
# Full Auto | Win10/11 | SSD/HDD Aware | WA Safe | Self-Updating
# ==========================================================
# GitHub Repo: https://github.com/ncexs/Win-Runtime-Optimizer
# Author: Ncexs
# ==========================================================

param(
    [switch]$Silent,
    [switch]$SkipUpdate,
    [switch]$ForceUpdate,
    [string]$CustomBranch = "main"
)

# Auto-detect non-interactive environments (like Task Scheduler or background jobs)
if (-not [Environment]::UserInteractive) {
    $Silent = $true
}

# Version definition for Auto-Updater
$VERSION = "2.0.0"

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
# LOGGING SYSTEM (WITH MODERN COLOR FEEDBACK)
# ==========================================================
function Write-Log {
    param(
        [string]$Text,
        [string]$Level = "INFO"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogPath -Value "[$timestamp] [$Level] $Text"
    
    if (-not $Silent) {
        switch ($Level) {
            "SUCCESS" { Write-Host "[+] $Text" -ForegroundColor Green }
            "WARNING" { Write-Host "[!] $Text" -ForegroundColor Yellow }
            "ERROR"   { Write-Host "[-] ERROR: $Text" -ForegroundColor Red }
            "INFO"    { Write-Host "[*] $Text" -ForegroundColor Cyan }
            "DETAIL"  { Write-Host "    > $Text" -ForegroundColor Gray }
            default   { Write-Host "[*] $Text" }
        }
    }
}

# ==========================================================
# ADMIN PRIVILEGE ENFORCEMENT
# ==========================================================
$IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $IsAdmin) {
    if ($Silent) {
        Write-Log "Script must run as Administrator. Exiting." "ERROR"
        Exit 1
    } else {
        Write-Host "==========================================================" -ForegroundColor Red
        Write-Host "          ADMINISTRATOR PRIVILEGES REQUIRED               " -ForegroundColor Red
        Write-Host "==========================================================" -ForegroundColor Red
        Write-Host "This script needs to optimize Windows Services and clear system caches." -ForegroundColor Yellow
        Write-Host "Attempting to elevate privileges..." -ForegroundColor Cyan
        try {
            # Restart with admin privileges and carry over parameters
            $argsList = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
            if ($SkipUpdate) { $argsList += " -SkipUpdate" }
            if ($ForceUpdate) { $argsList += " -ForceUpdate" }
            if ($CustomBranch -ne "main") { $argsList += " -CustomBranch `"$CustomBranch`"" }
            
            Start-Process powershell.exe -ArgumentList $argsList -Verb RunAs -ErrorAction Stop
            Exit
        } catch {
            Write-Host "Failed to elevate. Please run PowerShell as Administrator." -ForegroundColor Red
            Exit 1
        }
    }
}

# Show Modern Banner if not running silently (Using safe ASCII characters)
if (-not $Silent) {
    Clear-Host
    Write-Host "+==========================================================+" -ForegroundColor Cyan
    Write-Host "|                WIN RUNTIME OPTIMIZER                     |" -ForegroundColor Cyan
    Write-Host "|                    Version $VERSION                      |" -ForegroundColor Cyan
    Write-Host "|          Full Auto | SSD/HDD Aware | WA Safe             |" -ForegroundColor Cyan
    Write-Host "+==========================================================+" -ForegroundColor Cyan
    Write-Host ""
}

# ==========================================================
# SELF-UPDATER (AUTO-UPDATE) SYSTEM
# ==========================================================
function Check-ForUpdates {
    if ($SkipUpdate) { 
        Write-Log "Update check skipped via parameter." "INFO"
        return 
    }
    
    $RepoOwner = "ncexs"
    $RepoName = "Win-Runtime-Optimizer"
    $Branch = $CustomBranch
    $RemoteUrl = "https://raw.githubusercontent.com/$RepoOwner/$RepoName/$Branch/Projek/WinRuntimeOptimizer.ps1"
    
    Write-Log "Checking for updates..." "INFO"
    
    try {
        # Configure TLS 1.2/1.3 for older Windows 10 compatibility
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
        
        $webClient = New-Object System.Net.WebClient
        $webClient.Timeout = 6000 # 6-second timeout
        
        $remoteScript = $webClient.DownloadString($RemoteUrl)
        
        if ($remoteScript -match '\$VERSION\s*=\s*"([^"]+)"') {
            $RemoteVersionStr = $Matches[1]
            $CurrentVersionStr = $VERSION
            
            $remoteVer = [System.Version]$RemoteVersionStr
            $currentVer = [System.Version]$CurrentVersionStr
            
            if ($remoteVer -gt $currentVer -or $ForceUpdate) {
                if ($ForceUpdate) {
                    Write-Log "Force-update triggered. Reinstalling v$RemoteVersionStr..." "WARNING"
                } else {
                    Write-Log "New update found: v$RemoteVersionStr (Current: v$CurrentVersionStr)" "WARNING"
                }
                
                if ($Silent) {
                    Write-Log "Applying update silently..." "INFO"
                    $remoteScript | Out-File -FilePath $PSCommandPath -Encoding utf8 -Force
                    Write-Log "Successfully updated to v$RemoteVersionStr. Restarting script..." "SUCCESS"
                    
                    # Restart with silent parameter and skip update to avoid infinite loops
                    $argsList = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -Silent -SkipUpdate"
                    if ($CustomBranch -ne "main") { $argsList += " -CustomBranch `"$CustomBranch`"" }
                    Start-Process powershell.exe -ArgumentList $argsList -WindowStyle Hidden
                    Exit
                } else {
                    Write-Host ""
                    Write-Host "==========================================================" -ForegroundColor Yellow
                    Write-Host "  UPDATE AVAILABLE!                                       " -ForegroundColor Yellow
                    if ($ForceUpdate) {
                        Write-Host "  Reinstalling Version: v$RemoteVersionStr" -ForegroundColor Green
                    } else {
                        Write-Host "  New version: v$RemoteVersionStr (Current: v$CurrentVersionStr)" -ForegroundColor Green
                    }
                    Write-Host "==========================================================" -ForegroundColor Yellow
                    Write-Host ""
                    
                    $choice = Read-Host "Do you want to update now? (Y/N)"
                    if ($choice -eq 'Y' -or $choice -eq 'y') {
                        Write-Host "Downloading and installing update..." -ForegroundColor Cyan
                        $remoteScript | Out-File -FilePath $PSCommandPath -Encoding utf8 -Force
                        Write-Host "Updated successfully! Restarting..." -ForegroundColor Green
                        Start-Sleep -Seconds 2
                        
                        $argsList = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -SkipUpdate"
                        if ($CustomBranch -ne "main") { $argsList += " -CustomBranch `"$CustomBranch`"" }
                        Start-Process powershell.exe -ArgumentList $argsList
                        Exit
                    } else {
                        Write-Log "Update declined. Continuing with current version." "WARNING"
                    }
                }
            } else {
                Write-Log "Script is up-to-date (v$CurrentVersionStr)." "SUCCESS"
            }
        } else {
            Write-Log "Failed to parse remote version tag." "WARNING"
        }
    } catch {
        Write-Log "Update check skipped (Unable to connect to GitHub or repository file missing)." "WARNING"
        Write-Log "Details: $_" "DETAIL"
    }
}

# Run Update Check on start
Check-ForUpdates

# ==========================================================
# SYSTEM DETECTION
# ==========================================================
Write-Log "Detecting system hardware and OS..." "INFO"

$OSCaption = (Get-CimInstance Win32_OperatingSystem).Caption
$OSVersion = (Get-CimInstance Win32_OperatingSystem).Version
$TotalRAM = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)

# Fail-safe drive detection
$DriveType = "SSD"
try {
    $disks = Get-PhysicalDisk -ErrorAction SilentlyContinue
    if ($disks) {
        $hasHDD = $disks | Where-Object { $_.MediaType -eq "HDD" }
        if ($hasHDD) {
            $DriveType = "HDD"
        } else {
            $DriveType = ($disks | Select-Object -First 1).MediaType
        }
    }
} catch {
    Write-Log "Failed to query physical disks. Defaulting to SSD behavior." "WARNING"
}

$IsWin11 = $OSVersion -like "10.0.2*"
$LowRAM = $TotalRAM -le 8
$IsHDD = $DriveType -eq "HDD"

Write-Log "OS: $OSCaption" "DETAIL"
$RAMStrategyText = if ($LowRAM) { "Low RAM Strategy" } else { "Standard RAM Strategy" }
$DriveStrategyText = if ($IsHDD) { "HDD Strategy" } else { "SSD Strategy" }
Write-Log "RAM: $TotalRAM GB ($RAMStrategyText)" "DETAIL"
Write-Log "Drive: $DriveType ($DriveStrategyText)" "DETAIL"

# ==========================================================
# OPTIMIZATION UTILITIES
# ==========================================================
function Clear-FolderSafe {
    param([string]$Path)
    if (Test-Path $Path) {
        $cleared = $false
        try {
            $items = Get-ChildItem -Path $Path -Force -ErrorAction SilentlyContinue
            if ($items) {
                $items | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
                $cleared = $true
            }
        } catch {
            Write-Log "Failed to clear some active/locked files in: $Path" "DETAIL"
        }
        if ($cleared) {
            Write-Log "Cleaned: $Path" "SUCCESS"
        }
    }
}

function Safe-SetService {
    param(
        [string]$Name,
        [string]$Mode
    )
    $svc = Get-Service -Name $Name -ErrorAction SilentlyContinue
    if ($svc) {
        if ($svc.StartType -ne $Mode) {
            try {
                Set-Service -Name $Name -StartupType $Mode -ErrorAction Stop
                Write-Log "Service '$Name' startup set to '$Mode'" "SUCCESS"
            } catch {
                Write-Log "Failed to change service '$Name' startup type: $_" "WARNING"
            }
        } else {
            Write-Log "Service '$Name' already in status '$Mode'" "DETAIL"
        }
    } else {
        Write-Log "Service '$Name' not found on this system. Skipped." "DETAIL"
    }
}

# ==========================================================
# 1. AUTO SERVICE TUNING
# ==========================================================
Write-Host ""
Write-Log "Optimizing active Windows Services..." "INFO"

# SysMain logic (Superfetch)
if ($LowRAM -and $IsHDD) {
    Safe-SetService "SysMain" "Manual"
} else {
    Safe-SetService "SysMain" "Automatic"
}

# Windows Search logic
if ($LowRAM) {
    Safe-SetService "WSearch" "Manual"
} else {
    Safe-SetService "WSearch" "Automatic"
}

# Telemetry
Safe-SetService "DiagTrack" "Manual"

# Xbox services (non-critical, set to manual so they only start when games open)
Safe-SetService "XblGameSave" "Manual"
Safe-SetService "XboxNetApiSvc" "Manual"

# Windows 11 specific tweak (ClipSVC/License validation on low ram)
if ($IsWin11 -and $LowRAM) {
    Safe-SetService "ClipSVC" "Manual"
}

# ==========================================================
# 2. SYSTEM FILES CLEANUP
# ==========================================================
Write-Host ""
Write-Log "Cleaning temporary and cache files..." "INFO"

# Clean system & user temps
Clear-FolderSafe "$env:TEMP"
Clear-FolderSafe "C:\Windows\Temp"

# Prefetch is only cleaned on HDD systems to avoid redundant SSD wear
if ($IsHDD) {
    Clear-FolderSafe "C:\Windows\Prefetch"
} else {
    Write-Log "Skipped Prefetch cleanup (SSD drive detected)." "DETAIL"
}

# Clean Windows Update Download Cache safely
$wuSvc = Get-Service -Name wuauserv -ErrorAction SilentlyContinue
if ($wuSvc) {
    $wasRunning = $wuSvc.Status -eq "Running"
    if ($wasRunning) {
        Write-Log "Stopping Windows Update service (wuauserv)..." "DETAIL"
        Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
        
        $timeout = 10
        while ((Get-Service -Name wuauserv).Status -ne "Stopped" -and $timeout -gt 0) {
            Start-Sleep -Seconds 1
            $timeout--
        }
    }
    
    Clear-FolderSafe "C:\Windows\SoftwareDistribution\Download"
    
    if ($wasRunning) {
        Write-Log "Restarting Windows Update service..." "DETAIL"
        Start-Service -Name wuauserv -ErrorAction SilentlyContinue
    }
}

# ==========================================================
# 3. GPU & SHADER CACHE CLEANUP
# ==========================================================
Write-Host ""
Write-Log "Cleaning GPU & Shader Caches..." "INFO"

$GPUCachePaths = @(
    "$env:LOCALAPPDATA\NVIDIA\DXCache",
    "$env:LOCALAPPDATA\NVIDIA\GLCache",
    "$env:LOCALAPPDATA\NVIDIA\ComputeCache",
    "$env:APPDATA\NVIDIA\ComputeCache",
    "$env:LOCALAPPDATA\AMD\DxCache",
    "$env:LOCALAPPDATA\AMD\OglCache",
    "$env:LOCALAPPDATA\Intel\ShaderCache"
)

foreach ($path in $GPUCachePaths) {
    Clear-FolderSafe $path
}

# ==========================================================
# 4. PROCESS-AWARE CACHE CLEANUP (CHROME, EDGE, BRAVE, OPERA, FIREFOX, DISCORD)
# ==========================================================
Write-Host ""
Write-Log "Performing safe multi-browser & app cache cleanup..." "INFO"

$AppProfiles = @(
    @{
        Name = "Google Chrome"
        ProcessNames = @("chrome")
        CachePaths = @("$env:LOCALAPPDATA\Google\Chrome\User Data")
        Type = "Chromium"
    },
    @{
        Name = "Microsoft Edge"
        ProcessNames = @("msedge")
        CachePaths = @("$env:LOCALAPPDATA\Microsoft\Edge\User Data")
        Type = "Chromium"
    },
    @{
        Name = "Brave Browser"
        ProcessNames = @("brave")
        CachePaths = @("$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data")
        Type = "Chromium"
    },
    @{
        Name = "Opera Stable"
        ProcessNames = @("opera")
        CachePaths = @(
            "$env:LOCALAPPDATA\Opera Software\Opera Stable",
            "$env:APPDATA\Opera Software\Opera Stable"
        )
        Type = "ChromiumOpera"
    },
    @{
        Name = "Opera GX"
        ProcessNames = @("opera")
        CachePaths = @(
            "$env:LOCALAPPDATA\Opera Software\Opera GX Stable",
            "$env:APPDATA\Opera Software\Opera GX Stable"
        )
        Type = "ChromiumOpera"
    },
    @{
        Name = "Mozilla Firefox"
        ProcessNames = @("firefox")
        CachePaths = @("$env:LOCALAPPDATA\Mozilla\Firefox\Profiles")
        Type = "Firefox"
    },
    @{
        Name = "Discord"
        ProcessNames = @("discord")
        CachePaths = @("$env:APPDATA\discord")
        Type = "Chromium"
    }
)

foreach ($app in $AppProfiles) {
    # Check if app is active
    $isRunning = $false
    foreach ($proc in $app.ProcessNames) {
        if (Get-Process -Name $proc -ErrorAction SilentlyContinue) {
            $isRunning = $true
            break
        }
    }
    
    if ($isRunning) {
        Write-Log "$($app.Name) is active. Skipped cache clean to avoid data lock." "WARNING"
        continue
    }
    
    $cleanedAny = $false
    
    if ($app.Type -eq "Chromium" -or $app.Type -eq "ChromiumOpera") {
        foreach ($basePath in $app.CachePaths) {
            if (Test-Path $basePath) {
                # Clean direct caches (like Opera structures)
                $directCaches = @(
                    "$basePath\Cache",
                    "$basePath\Code Cache",
                    "$basePath\GPUCache",
                    "$basePath\DawnWebGPUCache",
                    "$basePath\ShaderCache"
                )
                foreach ($dc in $directCaches) {
                    if (Test-Path $dc) {
                        Clear-FolderSafe $dc
                        $cleanedAny = $true
                    }
                }
                
                # Clean profile-based caches (Chrome, Edge, Brave subfolders)
                Get-ChildItem $basePath -Directory -ErrorAction SilentlyContinue | ForEach-Object {
                    $profilePath = $_.FullName
                    $profileCaches = @(
                        "$profilePath\Cache",
                        "$profilePath\Code Cache",
                        "$profilePath\GPUCache",
                        "$profilePath\DawnWebGPUCache",
                        "$profilePath\ShaderCache"
                    )
                    foreach ($pc in $profileCaches) {
                        if (Test-Path $pc) {
                            Clear-FolderSafe $pc
                            $cleanedAny = $true
                        }
                    }
                }
            }
        }
    } elseif ($app.Type -eq "Firefox") {
        foreach ($basePath in $app.CachePaths) {
            if (Test-Path $basePath) {
                Get-ChildItem $basePath -Directory -ErrorAction SilentlyContinue | ForEach-Object {
                    $profilePath = $_.FullName
                    $ffCaches = @(
                        "$profilePath\cache2",
                        "$profilePath\startupCache",
                        "$profilePath\jumpListCache",
                        "$profilePath\thumbnail"
                    )
                    foreach ($ffc in $ffCaches) {
                        if (Test-Path $ffc) {
                            Clear-FolderSafe $ffc
                            $cleanedAny = $true
                        }
                    }
                }
            }
        }
    }
    
    if ($cleanedAny) {
        Write-Log "$($app.Name) cache cleared safely." "SUCCESS"
    } else {
        Write-Log "$($app.Name) cache already clean or no profile detected." "DETAIL"
    }
}

# ==========================================================
# 5. MEMORY STRATEGY (LOW RAM ONLY)
# ==========================================================
if ($LowRAM) {
    Write-Host ""
    Write-Log "Running Memory Optimization Strategy (Low RAM)..." "INFO"
    
    $signature = @"
using System;
using System.Runtime.InteropServices;
public class Mem {
    [DllImport("psapi.dll")]
    public static extern int EmptyWorkingSet(IntPtr hwProc);
}
"@

    # Safely load the .NET/C# Assembly in PowerShell sessions
    if (-not ([System.Management.Automation.PSTypeName]"Mem").Type) {
        Add-Type $signature -ErrorAction SilentlyContinue
    }
    
    # Trim RAM of all idle applications except core web and active system items
    Get-Process | Where-Object {
        $_.ProcessName -notmatch "chrome|msedge|brave|opera|firefox|discord|powershell|explorer"
    } | ForEach-Object {
        try { 
            [Mem]::EmptyWorkingSet($_.Handle) | Out-Null
        } catch {}
    }
    
    Write-Log "Low RAM memory trim executed successfully." "SUCCESS"
}

# ==========================================================
# 6. FLUSH NETWORK CACHE
# ==========================================================
Write-Host ""
Write-Log "Flushing DNS resolver cache..." "INFO"
ipconfig /flushdns | Out-Null
Write-Log "DNS resolver cache flushed." "SUCCESS"

# ==========================================================
# FINALIZATION
# ==========================================================
Write-Host ""
Write-Log "System Optimization completed successfully." "SUCCESS"
if (-not $Silent) {
    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "  Optimization finished! Log saved to: " -NoNewline -ForegroundColor Gray
    Write-Host "optimizer-final-log.txt" -ForegroundColor White
    Write-Host "==========================================================" -ForegroundColor Cyan
}
