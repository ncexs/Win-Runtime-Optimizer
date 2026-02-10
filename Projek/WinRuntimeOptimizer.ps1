# ============================================================
# Win Runtime Optimizer (Optimized)
# SYSTEM-safe runtime cleanup script
# ============================================================

$ErrorActionPreference = "SilentlyContinue"

# -----------------------------
# Helper: cek process aktif
# -----------------------------
function Test-ProcessRunning {
    param ([string[]]$ProcessNames)

    foreach ($name in $ProcessNames) {
        if (Get-Process -Name $name -ErrorAction SilentlyContinue) {
            return $true
        }
    }
    return $false
}

# -----------------------------
# Helper: hapus isi folder saja
# -----------------------------
function Clear-FolderContent {
    param ([string]$Path)

    if (Test-Path $Path) {
        Get-ChildItem -Path $Path -Recurse -Force -ErrorAction SilentlyContinue |
            Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# ============================================================
# 1. Runtime Temp Cleanup
# ============================================================

Clear-FolderContent "$env:TEMP"
Clear-FolderContent "C:\Windows\Temp"
Clear-FolderContent "C:\Windows\Prefetch"

# ============================================================
# 2. GPU / Shader Cache
# ============================================================

$gpuPaths = @(
    "C:\ProgramData\NVIDIA Corporation\NV_Cache",
    "C:\Users\*\AppData\Local\NVIDIA\DXCache",
    "C:\Users\*\AppData\Local\NVIDIA\GLCache",
    "C:\Users\*\AppData\Local\AMD\DxCache",
    "C:\Users\*\AppData\Local\AMD\GLCache",
    "C:\Users\*\AppData\Local\Intel\ShaderCache"
)

foreach ($path in $gpuPaths) {
    Clear-FolderContent $path
}

# ============================================================
# 3. Browser Cache Cleanup (SAFE MODE)
# ============================================================

$browsers = @(
    @{
        Process = @("chrome")
        Paths = @(
            "C:\Users\*\AppData\Local\Google\Chrome\User Data\*\Cache",
            "C:\Users\*\AppData\Local\Google\Chrome\User Data\*\Code Cache",
            "C:\Users\*\AppData\Local\Google\Chrome\User Data\*\GPUCache"
        )
    },
    @{
        Process = @("msedge")
        Paths = @(
            "C:\Users\*\AppData\Local\Microsoft\Edge\User Data\*\Cache",
            "C:\Users\*\AppData\Local\Microsoft\Edge\User Data\*\Code Cache",
            "C:\Users\*\AppData\Local\Microsoft\Edge\User Data\*\GPUCache"
        )
    },
    @{
        Process = @("brave")
        Paths = @(
            "C:\Users\*\AppData\Local\BraveSoftware\Brave-Browser\User Data\*\Cache",
            "C:\Users\*\AppData\Local\BraveSoftware\Brave-Browser\User Data\*\Code Cache",
            "C:\Users\*\AppData\Local\BraveSoftware\Brave-Browser\User Data\*\GPUCache"
        )
    },
    @{
        Process = @("firefox")
        Paths = @(
            "C:\Users\*\AppData\Local\Mozilla\Firefox\Profiles\*\cache2"
        )
    }
)

foreach ($browser in $browsers) {
    if (-not (Test-ProcessRunning $browser.Process)) {
        foreach ($path in $browser.Paths) {
            Clear-FolderContent $path
        }
    }
}

exit 0
