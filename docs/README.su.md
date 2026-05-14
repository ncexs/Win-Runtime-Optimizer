# ⚡ ncexs Auto Task (NAT)

🌐 [English](../README.md) | [Bahasa Indonesia](README.id.md) | [Basa Jawa](README.jv.md) | **Basa Sunda** | [हिन्दी](README.hi.md) | [Русский](README.ru.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [简体中文](README.zh.md) | [العربية](README.ar.md)

📄 **[Catetan Parobihan](CHANGELOG.su.md)** | 🛠️ **v2.0.0-Auto**

**ncexs Auto Task** mangrupikeun skrip PowerShell portabel pikeun optimisasi runtime Windows sacara **aman, silent, sareng stabil**, tanpa ngaganggu aplikasi atanapi sési anu nuju jalan.

---

## 🎯 Tujuan & Prinsip Desain

<table width="100%">
  <tr>
    <th width="50%" align="left">🎯 Tujuan</th>
    <th width="50%" align="left">🧠 Prinsip Desain</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li>Ngajaga performa Windows tetep stabil.</li>
        <li>Ngirangan lag kusabab cache sareng temp anu numpuk.</li>
        <li>Ngabersihan runtime runtah anu aman pikeun dihapus.</li>
        <li>Ngarojong éksékusi otomatis tanpa ngaganggu pangguna.</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li><b>Aman > Agrésif</b></li>
        <li>Stabilitas jangka panjang.</li>
        <li>Henteu ngaganggu aplikasi aktif.</li>
        <li>Cocog dijalankeun rutin salaku pangropéa (maintenance) hampang.</li>
      </ul>
    </td>
  </tr>
</table>

---

## ⚡ Cakupan & Kamampuhan Skrip

<table width="100%">
  <tr>
    <th width="50%" align="left">✅ Anu Dilakukeun Skrip</th>
    <th width="50%" align="left">❌ Anu HENTEU Dilakukeun</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li><b>Pangberesih Cache Sistem Hampang sareng Aman:</b>
          <ul>
            <li>User Temp (<code>%TEMP%</code>)</li>
            <li>System Temp (<code>C:\Windows\Temp</code>)</li>
            <li>Prefetch (eusi folder wungkul - khusus HDD)</li>
            <li><b>GPU & Shader Cache</b> (AMD, NVIDIA, Intel - DXCache, GLCache, ComputeCache, ShaderCache)</li>
          </ul>
        </li>
        <li><b>Pangberesih Cache Browser & Aplikasi Hampang (Proses-Aware):</b>
          <ul>
            <li>Mung ngahapus berkas cache non-kritis (Cache, Code Cache, GPUCache, DawnWebGPUCache, ShaderCache).</li>
            <li><b>Mendakan aplikasi per-item:</b> Upami Chrome aktif tapi Firefox/Edge ditutup, skrip bakal tetep ngabersihan Firefox/Edge sacara aman sareng mung ngalangkungan Chrome!</li>
          </ul>
        </li>
        <li><b>Ngarojong Aplikasi:</b> Google Chrome, Microsoft Edge, Brave Browser, Opera Stable, Opera GX, Mozilla Firefox, sareng Discord.</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li>Henteu nutup browser atanapi ngajantengkeun proses anu nuju aktif.</li>
        <li>Henteu kaluar (logout) tina aplikasi web atanapi situs web.</li>
        <li>Henteu ngahapus Cookies browser.</li>
        <li>Henteu ngahapus Local Storage, Session Storage, atanapi IndexedDB.</li>
        <li>Henteu ngarobih registry atanapi system policy Windows.</li>
        <li>Fokus kana <b>runtime cleanup</b>, sanes optimisasi agrésif anu ngaruksak sistem.</li>
      </ul>
    </td>
  </tr>
</table>

---

## ▶️ Cara Ngajalankeun

### Manual Execution

Jalankeun PowerShell (bakal otomatis nyuhunkeun hak aksés Administrator upami jalan sacara interaktif) nganggo parentah ieu:

```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1
```

#### ⚙️ Parameter Opsional (Advanced)

Anjeun tiasa nambihan parameter ieu pikeun nyesuaikeun jalanna skrip:

* **`-Silent`**: Ngajalankeun skrip di latar pengker (silent) tanpa output ka layar konsol pisan. Cocog pisan pikeun otomatisasi Task Scheduler.
* **`-SkipUpdate`**: Ngalangkungan pamariksaan pembaruan otomatis (self-updater) di awal éksékusi.
* **`-ForceUpdate`**: Maksa ngunduh ulang skrip tina GitHub sanaos vérsi lokal anjeun parantos sami sareng vérsi remote.
* **`-CustomBranch "nami_branch"`**: Ngarobih target branch pikeun pembaruan skrip (default: `"main"`).

Conto panggunaan:
```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1 -Silent -SkipUpdate
```

---

## ⚙️ Panduan Lanjutan & Setup

<details>
<summary><b>⏱️ Klik pikeun ningali Panduan Setup Otomatis (Task Scheduler)</b></summary>

### 1️⃣ Buka Task Scheduler
Tekan **Win + R**, lajeng ketik:
```
taskschd.msc
```
Tekan **Enter**.

---

### 2️⃣ Damel Task Anyar
Klik **Create Task** (ulah milih *Basic Task*)

**Tab General**
- Name: `ncexs Auto Task`
- Centang:
  - Run whether user is logged on or not
  - Run with highest privileges

---

### 3️⃣ Tab Triggers
- Klik **New**
- Begin the task: **On a schedule**
- Pilih **Daily**

**Advanced settings (opsional):**
- Repeat task every: **6 hours**  
  *(atanapi kosongkeun upami mung hoyong jalan sakali sadinten)*
- For a duration of: **Indefinitely**
- Centang **Enable**
- Klik **OK**

> ⚠️ Dropdown mung nampilkeun dugi ka 1 hour, anjeun tiasa ngetik manual **6 hours** atanapi **06:00:00**. Ngajalankeun unggal 1 jam **henteu disarankeun** kumargi skrip ieu mangrupikeun pangropéa hampang, sanes real-time optimizer.

---

### 4️⃣ Tab Actions
- Klik **New**
- Action: **Start a program**
- Program/script: `powershell.exe`
- Add arguments:
  ```
  -ExecutionPolicy Bypass -File "C:\Path\Ka\ncexs-AutoTask.ps1" -Silent
  ```
- Start in (optional): `C:\Path\Ka`

> ⚠️ Ganti `C:\Path\Ka` dumasar lokasi anjeun nyimpen skrip.

---

### 5️⃣ Tab Conditions
- Ilangkeun centang: `Start the task only if the computer is on AC power`

---

### 6️⃣ Tab Settings
- Centang:
  - Allow task to be run on demand
  - Run task as soon as possible after a scheduled start is missed
- Ulah centang: `Stop the task if it runs longer than`

Klik **OK**, lajeng lebetkeun password Windows anjeun upami disuhunkeun.
> ⚠️ Upami hoyong tanpa password, anggo akun **SYSTEM** nalika ngadamel task (dina dropdown *Change User or Group...* ketik **SYSTEM**).

</details>

<details>
<summary><b>🔒 Klik pikeun ningali Fitur Kaamanan & Stabilitas di Task Scheduler</b></summary>

Skrip ieu parantos dirancang khusus supados aman 100% nalika jalan otomatis ngalangkungan **Task Scheduler** di latar pengker tanpa pangawasan:

1. **Auto-Detect Non-Interactive (`UserInteractive`):** Upami skrip dijalankeun ku Task Scheduler (sanaos anjeun hilap nambihan parameter `-Silent`), skrip sacara otomatis mendakan yén anjeunna jalan di latar pengker sareng maksa mode silent (`$Silent = $true`). Ieu nyegah skrip janten beku (*freeze*) kusabab ngantosan input pangguna (kawas parentah interaktif `Read-Host` dina proses update).
2. **Process-Aware Protection:** Sateuacan ngabersihan cache aplikasi (Chrome, Edge, Brave, Opera, Firefox, Discord), skrip mariksa naha aplikasi éta nuju aktif. Upami aktif, pangberesih aplikasi éta dilangkungan sacara cerdas supados henteu ngaganggu sési aktif anjeun atanapi ngabalukarkeun korupsi data.
3. **Graceful Elevation Check:** Upami Task Scheduler hilap dikonfigurasi nganggo "Highest Privileges", skrip henteu bakal ngaluarkeun pop-up UAC Windows anu tiasa ngagantung di background. Skrip mendakan hal ieu sacara rerencepan, nyatet eror dina berkas log, lajeng kaluar sacara beresih.
4. **Smart Windows Update Cleanup:** Layanan Windows Update (`wuauserv`) mung bakal dihentikeun samentawis upami waktos éta statusna nuju jalan, sareng bakal dihurungkeun deui saparantos pangberesih réngsé. Upami statusna kawit awal parantos mati, skrip henteu bakal ngarobih preferensi sistem anjeun.

</details>

<details>
<summary><b>📂 Klik pikeun ningali Daptar Area anu Dibersihan</b></summary>

Mung folder sareng area ieu anu dibersihan:
- `%TEMP%` (User Temp)
- `C:\Windows\Temp` (System Temp)
- `C:\Windows\Prefetch` (Mung eusi folder, khusus pikeun HDD)
- **Windows Update Download Cache** (`C:\Windows\SoftwareDistribution\Download`)
- **GPU & Shader Cache** (NVIDIA, AMD, Intel - DXCache, GLCache, ComputeCache, ShaderCache)
- **Browser & App Caches non-kritis** (Chrome, Edge, Brave, Opera Stable, Opera GX, Firefox, Discord):
  - Cache & cache2
  - Code Cache & startupCache
  - GPUCache & DawnWebGPUCache
  - ShaderCache, jumpListCache, & thumbnail

Folder autentikasi, cookies, sareng session **pisan henteu disenggol**.

</details>

<details>
<summary><b>🔧 Klik pikeun ningali Panduan Pangropéa (Maintenance)</b></summary>

Upami aya parobihan struktur OS atanapi browser di mangsa payun:
- Review deui path cache.
- Mastikeun data session tetep aman.
- Sesuaikan logic detéksi process upami peryogi.

</details>

---

## 📄 Status & Info

- **Automated Project Tool** sareng sistem pembaruan otomatis terintegrasi.
- **Auto-Versioning** (dikawitan tina `v1.0.0` salaku vérsi stabil munggaran).
- **Self-Updating**: Sacara otomatis mariksa sareng ngunduh vérsi panganyarna langsung tina repositori GitHub anjeun (`ncexs/ncexs-AutoTask`) nalika dijalankeun.
- Cocog diintegrasikeun sareng Windows Task Scheduler pikeun pangropéa rutin tanpa pipilueun manual.

---

## 📜 Lisénsi

MIT License - tingali berkas [LICENSE](../LICENSE) pikeun rincianna.  
Anggo kalayan résiko anjeun sorangan ⚠️.
