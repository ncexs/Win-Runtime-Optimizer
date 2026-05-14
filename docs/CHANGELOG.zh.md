# 📋 更新日志 (Changelog)

🌐 [English](../CHANGELOG.md) | [Bahasa Indonesia](CHANGELOG.id.md) | [Basa Jawa](CHANGELOG.jv.md) | [Basa Sunda](CHANGELOG.su.md) | [हिन्दी](CHANGELOG.hi.md) | [Русский](CHANGELOG.ru.md) | [日本語](CHANGELOG.ja.md) | [한국어](CHANGELOG.ko.md) | **简体中文** | [العربية](CHANGELOG.ar.md)

---

**ncexs Auto Task** 项目的所有重要更改都将记录在此文件中。

---

## 🚀 [2.0.0-Auto] - 2026-05-10

### 🛠️ 问题修复 (Bug Fixes)
- **Safe-SetService 修复:** 修正了一个严重的拼写错误：在 v1.0.0 中调用了 `Safe-SetService`，但该函数被定义为 `Set-ServiceStartupSafely`。该错误此前导致所有 Windows 服务启动优化在静默运行中失效。

### ✨ 新增特性 (New Features)
- **集成自动更新:** 脚本现在可以在启动时自动检测、下载、应用并重新加载 GitHub 仓库 (`ncexs/Win-Runtime-Optimizer`) 中的最新版本。
- **扩展应用支持:** 新增了对 **Mozilla Firefox**、**Opera GX**（游戏浏览器）以及 **Discord**（知名通讯软件）的缓存安全清理。
- **GPU 与着色器缓存清理:** 增加了对 **NVIDIA** (DXCache, GLCache, ComputeCache)、**AMD** (DxCache, OglCache) 及 **Intel** (ShaderCache) 图形处理器的物理着色器缓存目录清理。
- **高级执行参数:** 引入了强大的命令行参数控制：
  - `-Silent`（在后台完全静默运行，无任何控制台输出）
  - `-SkipUpdate`（在启动时跳过自动更新检查）
  - `-ForceUpdate`（即使本地版本相同，也强制从 GitHub 重新下载脚本）
  - `-CustomBranch`（设定用于检查更新的自定义 GitHub 分支）

### 🔒 安全与稳定性 (Security & Stability)
- **非交互模式自动检测 (`UserInteractive`):** 如果通过任务计划程序或后台服务执行，脚本会自动识别非交互环境并强制开启静默模式 (`$Silent = $true`)。这避免了脚本在更新过程中因等待用户输入（如 `Read-Host`）而卡死或挂起。
- **感知进程的独立清理:** 浏览器与应用程序的运行检测现在更加精确。如果 Google Chrome 正在运行而 Firefox 已关闭，脚本会安全地跳过 Chrome 并清理 Firefox（此前若有任意单一浏览器运行，则会全局跳过所有浏览器）。
- **纯 ASCII 兼容:** 将控制台横幅及日志中的所有 Unicode 边框符号替换为 100% 标准 ASCII 字符表示。这避免了在旧版 Windows PowerShell 5.1 环境下因解析或编码问题导致的崩溃。

---

## 📦 [1.0.0] - 2026-05-10

### ✨ 初始发布 (Initial Release)
便携、安全、静默且稳定的 Windows 运行时维护脚本初始版本发布。

- 增加了在每次脚本运行时的自动日志重置功能。
- 升级浏览器缓存清理机制，使其支持进程检测。
- 从浏览器清理中移除 GPUCache 与 ShaderCache 的删除操作，以防止基于 Chromium 的应用程序出现视觉故障 (glitch)。
- 解决了在手动刷新页面前导致浏览器视图损坏的竞争条件 (race condition)。
- 采用符合规范的 PowerShell 动词重命名内部辅助函数 (`Is-` -> `Test-`)，完全遵守 PSScriptAnalyzer 准则。
- 实现了自动硬件及系统检测（Windows 10/11、RAM 容量以及 SSD 与 HDD 驱动器识别）。
- 将 Prefetch 清理配置为仅在 HDD 机械硬盘上执行（防止不必要的 SSD 写入损耗）。
- 实现了自适应的 Windows 服务启动调优 (SysMain, WSearch, DiagTrack, Xbox 及 ClipSVC)。
- 专为低内存系统 (<= 8 GB) 设计了内存工作集缩减策略（内存整理），且不影响正在运行的网页浏览器。
- 增加了对 Windows Update 下载的安装文件的安全完整清理。
- 集成了结构化及带有时间戳的文件日志记录。
- 确保脚本完全兼容每 6 小时通过任务计划程序进行的无人值守后台运行。

**1.0.0 版本成果:**
- 无浏览器界面损坏或视觉故障。
- 运行中的 WhatsApp Web 会话保持绝对稳定。
- 安全顺畅的定时自动后台运行。
