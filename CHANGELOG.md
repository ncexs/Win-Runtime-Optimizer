# 📋 Changelog

🌐 **English** | [Bahasa Indonesia](docs/CHANGELOG.id.md) | [Basa Jawa](docs/CHANGELOG.jv.md) | [Basa Sunda](docs/CHANGELOG.su.md) | [हिन्दी](docs/CHANGELOG.hi.md) | [Русский](docs/CHANGELOG.ru.md) | [日本語](docs/CHANGELOG.ja.md) | [한국어](docs/CHANGELOG.ko.md) | [简体中文](docs/CHANGELOG.zh.md) | [العربية](docs/CHANGELOG.ar.md)

---

All notable changes to the **ncexs Auto Task** project will be documented in this file.

---

## 🚀 [2.0.0-Auto] - 2026-05-10

### 🛠️ Bug Fixes
- **Safe-SetService Fix:** Corrected a critical typo where `Safe-SetService` was called but the function was defined as `Set-ServiceStartupSafely` in v1.0.0, which previously caused all Windows Services startup optimizations to fail silently.

### ✨ New Features
- **Integrated Self-Updater:** The script can now automatically detect, download, apply, and reload the latest version directly from the GitHub repository (`ncexs/Win-Runtime-Optimizer`) upon launch.
- **Expanded Application Support:** Added safe cache cleaning for **Mozilla Firefox**, **Opera GX** (gaming browser), and **Discord** (popular communication application).
- **GPU & Shader Cache Cleanup:** Added physical folder shader cache cleanup for **NVIDIA** (DXCache, GLCache, ComputeCache), **AMD** (DxCache, OglCache), and **Intel** (ShaderCache) graphics processors.
- **Advanced Execution Parameters:** Introduced powerful parameter controls:
  - `-Silent` (runs entirely in the background with no console output)
  - `-SkipUpdate` (bypasses the initial auto-update check)
  - `-ForceUpdate` (forces a clean re-download of the script from GitHub)
  - `-CustomBranch` (targets a custom release branch on GitHub)

### 🔒 Security & Stability
- **Non-Interactive Auto-Detection (`UserInteractive`):** If executed by Task Scheduler or background services, the script automatically detects the non-interactive environment and forces silent mode (`$Silent = $true`). This prevents the script from freezing due to blocked user input prompts (like `Read-Host` during updates).
- **Process-Aware Per-Item Cleaning:** Browser and app checks are now precise. If Google Chrome is active but Firefox is closed, the script safely skips Chrome and cleans Firefox (previously skipped all browsers globally if any single browser was active).
- **Pure ASCII Compatibility:** Replaced all Unicode box-drawing characters in the console banners and logs with 100% standard ASCII representations. This prevents parse/encoding crashes on legacy Windows PowerShell 5.1 environments.

---

## 📦 [1.0.0] - 2026-05-10

### ✨ Initial Release
Initial release of the portable, safe, silent, and stable Windows runtime maintenance script.

- Added automatic log file reset on every script run.
- Upgraded browser cache cleaning to be process-aware.
- Removed GPUCache and ShaderCache cleaning from browsers to prevent visual glitching in Chromium-based applications.
- Resolved race conditions that caused browser viewport corruption prior to a manual page refresh.
- Renamed internal helper functions using approved PowerShell verbs (`Is-` -> `Test-`) to fully comply with PSScriptAnalyzer guidelines.
- Implemented automatic hardware and system detection (Windows 10/11, RAM capacity, and SSD vs. HDD drive detection).
- Configured Prefetch cleanup to only execute on HDD storage drives (preventing redundant SSD write wear).
- Implemented adaptive Windows Services startup tuning (SysMain, WSearch, DiagTrack, Xbox, and ClipSVC).
- Designed memory-working-set reduction strategy (memory trim) specifically for low-RAM systems (<= 8 GB) without impacting active web browsers.
- Added safe and complete deletion of Windows Update downloaded installation files.
- Integrated structured and timestamped logging to file.
- Ensured absolute script compatibility for unattended background execution via Task Scheduler every 6 hours.

**Release 1.0.0 Outcomes:**
- No browser display corruption or visual glitches.
- Absolute stability for active WhatsApp Web sessions.
- Safe and seamless scheduled automated background runs.
