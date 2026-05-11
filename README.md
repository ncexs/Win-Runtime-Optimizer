# ⚡ ncexs Auto Task (NAT)

🌐 **English** | [Bahasa Indonesia](README.id.md)

📄 **[Changelog](CHANGELOG.md)** | 🛠️ **v2.0.0-Auto**

**ncexs Auto Task** is a lightweight, portable PowerShell script designed for safe, silent, and stable Windows runtime maintenance and optimization, without interrupting your active applications or browser sessions.

---

## 🎯 Purpose & Design Principles

<table width="100%">
  <tr>
    <th width="50%" align="left">🎯 Purpose</th>
    <th width="50%" align="left">🧠 Design Principles</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li>Maintain consistent system performance and stability.</li>
        <li>Reduce latency and system lag by clearing accumulated temporary files and caches.</li>
        <li>Safely clean up redundant runtime files.</li>
        <li>Enable fully automated background execution without user interruption.</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li><b>Safety > Aggressiveness</b></li>
        <li>Long-term stability and reliability.</li>
        <li>Zero interference with active user applications.</li>
        <li>Perfect as a lightweight, scheduled maintenance routine.</li>
      </ul>
    </td>
  </tr>
</table>

---

## ⚡ Script Scope & Capabilities

<table width="100%">
  <tr>
    <th width="50%" align="left">✅ What the Script Does</th>
    <th width="50%" align="left">❌ What the Script Does NOT Do</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li><b>Safe & Lightweight System Cache Cleanup:</b>
          <ul>
            <li>User Temporary Files (<code>%TEMP%</code>)</li>
            <li>System Temporary Files (<code>C:\Windows\Temp</code>)</li>
            <li>Prefetch Cache (contents only - restricted to HDD to avoid SSD wear)</li>
            <li><b>GPU & Shader Cache</b> (AMD, NVIDIA, and Intel DXCache, GLCache, ComputeCache, ShaderCache)</li>
          </ul>
        </li>
        <li><b>Process-Aware Web Browser & App Cache:</b>
          <ul>
            <li>Safely deletes non-critical caches (Cache, Code Cache, GPUCache, DawnWebGPUCache, ShaderCache).</li>
            <li><b>Per-Application Process Checking:</b> If Google Chrome is active but Firefox or Edge is closed, the script safely bypasses Chrome and cleans Firefox/Edge without global lockups.</li>
          </ul>
        </li>
        <li><b>Supported Applications:</b> Google Chrome, Microsoft Edge, Brave Browser, Opera Stable, Opera GX, Mozilla Firefox, and Discord.</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li>Does <b>NOT</b> close open web browsers or kill active processes.</li>
        <li>Does <b>NOT</b> log you out of active web apps or websites.</li>
        <li>Does <b>NOT</b> delete browser cookies.</li>
        <li>Does <b>NOT</b> clear Local Storage, Session Storage, or IndexedDB.</li>
        <li>Does <b>NOT</b> modify Windows registry settings or system policies.</li>
        <li>Purely focused on safe <b>runtime maintenance</b>, avoiding aggressive or destructive system tweaks.</li>
      </ul>
    </td>
  </tr>
</table>

---

## ▶️ How to Run

### Manual Execution

Run PowerShell (which will automatically prompt for Administrator privileges if executed in interactive mode) and run the following command:

```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1
```

#### ⚙️ Optional Parameters (Advanced)

Customize execution using these parameters:

* **`-Silent`**: Runs the script completely in the background without any console output. Recommended for Task Scheduler.
* **`-SkipUpdate`**: Skips the automatic update check (Self-Updater) at startup.
* **`-ForceUpdate`**: Forces the script to re-download itself from the GitHub repository even if the local version is identical.
* **`-CustomBranch "branch_name"`**: Sets a custom branch for checking updates (defaults to `"main"`).

Usage Example:
```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1 -Silent -SkipUpdate
```

---

## ⚙️ Advanced Guides & Setup

<details>
<summary><b>⏱️ Click to view Automatic Setup (Task Scheduler) Guide</b></summary>

### 1️⃣ Open Task Scheduler
Press **Win + R**, type:
```
taskschd.msc
```
Press **Enter**.

---

### 2️⃣ Create a New Task
Click **Create Task** (do not select *Basic Task*)

**General Tab**
- Name: `ncexs Auto Task`
- Check:
  - Run whether user is logged on or not
  - Run with highest privileges

---

### 3️⃣ Triggers Tab
- Click **New**
- Begin the task: **On a schedule**
- Select **Daily**

**Advanced settings (optional):**
- Repeat task every: **6 hours**  
  *(or leave unchecked if you want it to run once daily)*
- For a duration of: **Indefinitely**
- Check **Enabled**
- Click **OK**

> ⚠️ The scheduler dropdown menu maxes out at 1 hour, but you can type **6 hours** manually. Running the script every hour is **strongly discouraged** as this is a lightweight maintenance tool, not a real-time monitor.

---

### 4️⃣ Actions Tab
- Click **New**
- Action: **Start a program**
- Program/script: `powershell.exe`
- Add arguments:
  ```
  -ExecutionPolicy Bypass -File "C:\Path\To\ncexs-AutoTask.ps1" -Silent
  ```
- Start in (optional): `C:\Path\To`

> ⚠️ Replace `C:\Path\To` with the exact folder path where you saved the script.

---

### 5️⃣ Conditions Tab
- Uncheck: `Start the task only if the computer is on AC power`

---

### 6️⃣ Settings Tab
- Check:
  - Allow task to be run on demand
  - Run task as soon as possible after a scheduled start is missed
- Uncheck: `Stop the task if it runs longer than`

Click **OK**, and enter your Windows password if prompted.
> ⚠️ To run the task without a password prompt, set the security user to **SYSTEM** (click *Change User or Group...*, type **SYSTEM**, and click OK).

</details>

<details>
<summary><b>🔒 Click to view Security & Stability Features in Task Scheduler</b></summary>

This script is engineered to run 100% safely and unattended via **Task Scheduler** in the background:

1. **Auto-Detect Non-Interactive (`UserInteractive`):** If executed via Task Scheduler (even if you omit the `-Silent` parameter), the script automatically detects the background execution environment and forces silent mode (`$Silent = $true`). This prevents the script from hanging or freezing on interactive input prompts (like `Read-Host` during updates).
2. **Process-Aware Protection:** Before cleaning browser or app caches, the script verifies if those applications are active. If active, cleanup for that specific program is skipped to protect active sessions and prevent database corruption.
3. **Graceful Elevation Check:** If the task is misconfigured without "Highest Privileges", the script will not block or trigger a hidden UAC pop-up in Session 0. It logs a clean warning to the log file and exits gracefully.
4. **Smart Windows Update Cleanup:** The Windows Update service (`wuauserv`) is stopped temporarily only if it was already running, and is restarted immediately after. If it was disabled or stopped originally, the script preserves your settings.

</details>

<details>
<summary><b>📂 Click to view Targeted Directories for Cleanup</b></summary>

Only the following specific folders are targeted for cleanup:
- `%TEMP%` (User Temp)
- `C:\Windows\Temp` (System Temp)
- `C:\Windows\Prefetch` (Folder contents, restricted to HDD only)
- **Windows Update Download Cache** (`C:\Windows\SoftwareDistribution\Download`)
- **GPU & Shader Cache** (NVIDIA, AMD, Intel - DXCache, GLCache, ComputeCache, ShaderCache)
- **Non-critical Browser & App Caches** (Chrome, Edge, Brave, Opera Stable, Opera GX, Firefox, Discord):
  - Cache & cache2
  - Code Cache & startupCache
  - GPUCache & DawnWebGPUCache
  - ShaderCache, jumpListCache, & thumbnail

Authentication folders, active user sessions, and cookies are **completely untouched**.

</details>

<details>
<summary><b>🔧 Click to view Maintenance & Review Guide</b></summary>

If system files, OS structure, or browser directory paths change in future updates:
- Review directory paths for browser profiles and caches.
- Ensure user data and session storage remain fully protected.
- Adjust the running process checking logic where necessary.

</details>

---

## 📄 Status & Info

- **Automated Project Tool** with fully integrated self-updating mechanism.
- **Auto-Versioning** (commencing at `v1.0.0` as the first stable release basis).
- **Self-Updating**: Automatically queries and fetches the newest release from your GitHub repository (`ncexs/ncexs-AutoTask`) upon launch.
- Highly optimized for Windows Task Scheduler scheduling.

---

## 📜 License

MIT License - see the [LICENSE](LICENSE) file for details.  
Use at your own risk ⚠️.
