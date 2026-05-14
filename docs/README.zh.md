# ⚡ ncexs Auto Task (NAT)

🌐 [English](../README.md) | [Bahasa Indonesia](README.id.md) | [Basa Jawa](README.jv.md) | [Basa Sunda](README.su.md) | [हिन्दी](README.hi.md) | [Русский](README.ru.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | **简体中文** | [العربية](README.ar.md)

📄 **[更新日志](CHANGELOG.zh.md)** | 🛠️ **v2.0.0-Auto**

**ncexs Auto Task** 是一款轻量级、便携的 PowerShell 脚本，专为安全、静默且稳定的 Windows 运行时维护与优化而设计，并且不会中断您正在运行的应用程序或浏览器会话。

---

## 🎯 目的与设计准则

<table width="100%">
  <tr>
    <th width="50%" align="left">🎯 目的</th>
    <th width="50%" align="left">🧠 设计准则</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li>保持系统性能与稳定性的长期一致。</li>
        <li>通过清理积累的临时文件和缓存来降低系统延迟与卡顿。</li>
        <li>安全地清理多余的运行时文件。</li>
        <li>实现完全自动化的后台运行，无需用户干预。</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li><b>安全性 > 激进性</b></li>
        <li>注重长期稳定性与可靠性。</li>
        <li>对用户正在运行的应用程序零干扰。</li>
        <li>作为轻量级的定期计划维护任务非常理想。</li>
      </ul>
    </td>
  </tr>
</table>

---

## ⚡ 脚本清理范围与能力

<table width="100%">
  <tr>
    <th width="50%" align="left">✅ 脚本所做的工作</th>
    <th width="50%" align="left">❌ 脚本不会做的工作</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li><b>安全、轻量级的系统缓存清理:</b>
          <ul>
            <li>用户临时文件 (<code>%TEMP%</code>)</li>
            <li>系统临时文件 (<code>C:\Windows\Temp</code>)</li>
            <li>Prefetch 缓存（仅限文件夹内容 - 且限制在 HDD 机械硬盘上以避免 SSD 损耗）</li>
            <li><b>GPU 与着色器缓存</b> (AMD, NVIDIA, Intel - DXCache, GLCache, ComputeCache, ShaderCache)</li>
          </ul>
        </li>
        <li><b>感知进程的浏览器与应用缓存清理:</b>
          <ul>
            <li>安全删除非核心缓存文件 (Cache, Code Cache, GPUCache, DawnWebGPUCache, ShaderCache)。</li>
            <li><b>单项应用进程检查:</b> 如果 Google Chrome 正在运行，但 Firefox 或 Edge 已关闭，脚本会安全地跳过 Chrome 并清理 Firefox/Edge，不会导致全局锁定。</li>
          </ul>
        </li>
        <li><b>支持的应用程序:</b> Google Chrome, Microsoft Edge, Brave Browser, Opera Stable, Opera GX, Mozilla Firefox, 以及 Discord。</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li><b>不会</b>关闭您打开的浏览器或终止正在运行的进程。</li>
        <li><b>不会</b>使您退出已登录的 Web 应用或网站。</li>
        <li><b>不会</b>删除浏览器 Cookies。</li>
        <li><b>不会</b>清除 Local Storage、Session Storage 或 IndexedDB。</li>
        <li><b>不会</b>修改 Windows 注册表设置或系统策略。</li>
        <li>纯粹专注于安全的<b>运行时维护</b>，避免激进或破坏性的系统修改。</li>
      </ul>
    </td>
  </tr>
</table>

---

## ▶️ 如何运行

### 手动执行

打开 PowerShell（在交互式运行模式下会自动弹出请求管理员权限提示），输入并运行以下命令：

```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1
```

#### ⚙️ 可选参数 (高级)

您可以使用以下命令行参数自定义运行方式：

* **`-Silent`**: 在后台完全静默运行脚本，无任何控制台输出。极力推荐在任务计划程序中使用。
* **`-SkipUpdate`**: 启动时跳过自动更新检查（自更新程序）。
* **`-ForceUpdate`**: 即使本地脚本版本与远程相同，也强制从 GitHub 仓库重新下载脚本。
* **`-CustomBranch "分支名称"`**: 设定用于检查更新的自定义分支（默认值为 `"main"`）。

使用示例：
```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1 -Silent -SkipUpdate
```

---

## ⚙️ 高级配置与设置指南

<details>
<summary><b>⏱️ 点击查看自动配置 (任务计划程序) 指南</b></summary>

### 1️⃣ 打开任务计划程序
按下 **Win + R** 键，输入：
```
taskschd.msc
```
按下 **Enter** 键。

---

### 2️⃣ 创建新任务
点击右侧的 **“创建任务”**（请勿选择“创建基本任务”）

**“常规”选项卡**
- 名称：`ncexs Auto Task`
- 勾选：
  - 不管用户是否登录都要运行
  - 使用最高权限运行

---

### 3️⃣“触发器”选项卡
- 点击 **“新建”**
- 开始任务：**“按计划”**
- 选择 **“每天”**

**高级设置 (可选):**
- 重复任务间隔：**“6 小时”**  
  *(或者如果您仅想每天运行一次，请保持不勾选)*
- 持续时间：**“无限期”**
- 勾选 **“启用”**
- 点击 **“确定”**

> ⚠️ 下拉菜单可能仅显示到 1 小时，但您可以手动输入 **6 小时** 或 **06:00:00**。**强烈不建议**每小时运行一次脚本，因为这是一款轻量级的维护工具，而不是实时监控软件。

---

### 4️⃣“操作”选项卡
- 点击 **“新建”**
- 操作：**“启动程序”**
- 程序/脚本：`powershell.exe`
- 添加参数：
  ```
  -ExecutionPolicy Bypass -File "C:\Path\To\ncexs-AutoTask.ps1" -Silent
  ```
- 起始于 (可选)：`C:\Path\To`

> ⚠️ 请将 `C:\Path\To` 替换为您保存脚本的实际文件夹路径。

---

### 5️⃣“条件”选项卡
- 取消勾选：`只有在计算机使用交流电源时才启动此任务`

---

### 6️⃣“设置”选项卡
- 勾选：
  - 允许按需运行任务
  - 如果过了计划的开始时间，立即启动任务
- 取消勾选：`如果任务运行时间超过以下时间，停止该任务`

点击 **“确定”**，并在弹出提示时输入您的 Windows 密码。
> ⚠️ 如果希望在运行任务时无需输入密码，请将运行用户更改为 **SYSTEM**（点击“更改用户或组...”，输入 **SYSTEM**，然后点击确定）。

</details>

<details>
<summary><b>🔒 点击查看任务计划程序中的安全与稳定性特性</b></summary>

本脚本经过精心设计，可 100% 安全且无人值守地通过 **任务计划程序** 在后台运行：

1. **非交互模式自动检测 (`UserInteractive`):** 如果脚本通过任务计划程序执行（即使您漏写了 `-Silent` 参数），脚本会自动检测到后台运行环境并强制开启静默模式 (`$Silent = $true`)。这防止了脚本在更新过程中因等待交互式输入（如 `Read-Host`）而卡死或挂起。
2. **感知进程保护:** 在清理浏览器或应用缓存前，脚本会验证这些应用程序是否处于活动状态。如果正在运行，则会智能跳过该程序的清理，以保护您的活动会话并防止数据库损坏。
3. **优雅的权限检查:** 如果任务计划程序配置不当且未赋予“最高权限”，脚本不会被阻止，也不会在 Session 0 中弹出不可见的 UAC 提示窗口。它会向日志文件写入一条清晰的警告并优雅退出。
4. **智能 Windows Update 清理:** 仅当 Windows Update 服务 (`wuauserv`) 在脚本执行时正在运行，脚本才会暂时将其停止，并在清理结束后立即重新启动。如果该服务一开始就处于禁用或停止状态，脚本会保持您的系统首选项不变。

</details>

<details>
<summary><b>📂 点击查看清理的目标目录列表</b></summary>

仅有以下特定目录会被纳入清理范围：
- `%TEMP%` (用户临时文件夹)
- `C:\Windows\Temp` (系统临时文件夹)
- `C:\Windows\Prefetch` (仅限文件夹内容，且仅在机械硬盘 HDD 上执行)
- **Windows Update 下载缓存目录** (`C:\Windows\SoftwareDistribution\Download`)
- **GPU 与着色器缓存** (NVIDIA, AMD, Intel - DXCache, GLCache, ComputeCache, ShaderCache)
- **非核心的浏览器与应用缓存** (Chrome, Edge, Brave, Opera Stable, Opera GX, Firefox, Discord):
  - Cache & cache2
  - Code Cache & startupCache
  - GPUCache & DawnWebGPUCache
  - ShaderCache, jumpListCache, & thumbnail

身份验证文件夹、活动用户会话以及 Cookies 保持**绝对不受影响**。

</details>

<details>
<summary><b>🔧 点击查看维护与审阅指南</b></summary>

如果未来系统文件、操作系统结构或浏览器目录路径发生变化：
- 请审阅并检查浏览器配置文件和缓存的目录路径。
- 确保用户数据和会话存储受到完全保护。
- 在必要时调整运行进程的检测逻辑。

</details>

---

## 📄 状态与信息

- 集成了完整自动更新机制的**自动化项目工具**。
- **自动版本控制**（从第一个稳定发布版 `v1.0.0` 开始计算）。
- **自动更新**: 在运行时自动查询并下载您 GitHub 仓库 (`ncexs/ncexs-AutoTask`) 中的最新版本。
- 针对 Windows 任务计划程序的定时任务进行了高度优化。

---

## 📜 许可证

MIT 许可证 - 详情请参阅 [LICENSE](../LICENSE) 文件。  
风险自担 ⚠️。
