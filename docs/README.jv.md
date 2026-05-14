# ⚡ ncexs Auto Task (NAT)

🌐 [English](../README.md) | [Bahasa Indonesia](README.id.md) | **Basa Jawa** | [Basa Sunda](README.su.md) | [हिन्दी](README.hi.md) | [Русский](README.ru.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [简体中文](README.zh.md) | [العربية](README.ar.md)

📄 **[Cathetan Owah-owahan](CHANGELOG.jv.md)** | 🛠️ **v2.0.0-Auto**

**ncexs Auto Task** minangka skrip PowerShell portabel kanggo optimisasi runtime Windows kanthi **aman, silent, lan stabil**, tanpa ngganggu aplikasi utawa sesi sing lagi mlaku.

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
        <li>Njaga performa Windows tetep stabil.</li>
        <li>Nyuda lag amarga cache lan temp sing tumpuk-undung.</li>
        <li>Ngresiki runtime sampah sing aman kanggo dibusak.</li>
        <li>Ndhukung eksekusi otomatis tanpa ngganggu pangguna.</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li><b>Aman > Agresif</b></li>
        <li>Stabilitas jangka panjang.</li>
        <li>Ora ngganggu aplikasi aktif.</li>
        <li>Cocog dilakokake rutin minangka pangopènan (maintenance) entheng.</li>
      </ul>
    </td>
  </tr>
</table>

---

## ⚡ Cakupan & Kemampuan Skrip

<table width="100%">
  <tr>
    <th width="50%" align="left">✅ Sing Dilakokake Skrip</th>
    <th width="50%" align="left">❌ Sing ORA Dilakokake</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li><b>Reresik Cache Sistem Entheng lan Aman:</b>
          <ul>
            <li>User Temp (<code>%TEMP%</code>)</li>
            <li>System Temp (<code>C:\Windows\Temp</code>)</li>
            <li>Prefetch (isi folder wae - khusus HDD)</li>
            <li><b>GPU & Shader Cache</b> (AMD, NVIDIA, Intel - DXCache, GLCache, ComputeCache, ShaderCache)</li>
          </ul>
        </li>
        <li><b>Reresik Cache Browser & Aplikasi Entheng (Proses-Aware):</b>
          <ul>
            <li>Mung mbusak berkas cache non-kritis (Cache, Code Cache, GPUCache, DawnWebGPUCache, ShaderCache).</li>
            <li><b>Ndeteksi aplikasi per-item:</b> Yen Chrome aktif nanging Firefox/Edge ditutup, skrip bakal tetep ngresiki Firefox/Edge kanthi aman lan mung ngliwati Chrome!</li>
          </ul>
        </li>
        <li><b>Ndhukung Aplikasi:</b> Google Chrome, Microsoft Edge, Brave Browser, Opera Stable, Opera GX, Mozilla Firefox, lan Discord.</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li>Ora nutup browser utawa nghentikake proses sing lagi aktif.</li>
        <li>Ora metu (logout) saka aplikasi web utawa situs web.</li>
        <li>Ora mbusak Cookies browser.</li>
        <li>Ora mbusak Local Storage, Session Storage, utawa IndexedDB.</li>
        <li>Ora ngowahi registry utawa system policy Windows.</li>
        <li>Fokus ing <b>runtime cleanup</b>, dudu optimisasi agresif sing ngrusak sistem.</li>
      </ul>
    </td>
  </tr>
</table>

---

## ▶️ Cara Nglakokake

### Manual Execution

Lakonana PowerShell (bakal otomatis njaluk hak akses Administrator yen mlaku kanthi interaktif) nganggo printah ing ngisor iki:

```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1
```

#### ⚙️ Parameter Opsional (Advanced)

Sampeyan bisa nambahake parameter iki kanggo nyesuaikake lakune skrip:

* **`-Silent`**: Nglakokake skrip ing latar mburi (silent) tanpa output menyang layar konsol babar blas. Cocog banget kanggo otomatisasi Task Scheduler.
* **`-SkipUpdate`**: Ngliwati pengecekan pembaruan otomatis (self-updater) ing wiwitan eksekusi.
* **`-ForceUpdate`**: Meksa ngundhuh ulang skrip saka GitHub sanajan versi lokal sampeyan wis padha karo versi remote.
* **`-CustomBranch "jeneng_branch"`**: Ngowahi target branch kanggo pembaruan skrip (default: `"main"`).

Conto panganggo:
```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1 -Silent -SkipUpdate
```

---

## ⚙️ Panduan Lanjutan & Setup

<details>
<summary><b>⏱️ Klik kanggo ndeleng Panduan Setup Otomatis (Task Scheduler)</b></summary>

### 1️⃣ Buka Task Scheduler
Pencet **Win + R**, banjur ketik:
```
taskschd.msc
```
Pencet **Enter**.

---

### 2️⃣ Gawe Task Anyar
Klik **Create Task** (aja milih *Basic Task*)

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
  *(utawa kosongake yen mung pengin mlaku sepisan sedina)*
- For a duration of: **Indefinitely**
- Centang **Enable**
- Klik **OK**

> ⚠️ Dropdown mung nampilake nganti 1 hour, sampeyan bisa ngetik manual **6 hours** utawa **06:00:00**. Nglakokake saben 1 jam **ora disaranake** amarga skrip iki asipat pangopènan entheng, dudu real-time optimizer.

---

### 4️⃣ Tab Actions
- Klik **New**
- Action: **Start a program**
- Program/script: `powershell.exe`
- Add arguments:
  ```
  -ExecutionPolicy Bypass -File "C:\Path\Menyang\ncexs-AutoTask.ps1" -Silent
  ```
- Start in (optional): `C:\Path\Menyang`

> ⚠️ Ganti `C:\Path\Menyang` manut lokasi sampeyan nyimpen skrip.

---

### 5️⃣ Tab Conditions
- Ilangake centang: `Start the task only if the computer is on AC power`

---

### 6️⃣ Tab Settings
- Centang:
  - Allow task to be run on demand
  - Run task as soon as possible after a scheduled start is missed
- Aja centang: `Stop the task if it runs longer than`

Klik **OK**, banjur lebokake sandi (password) Windows sampeyan yen dijaluk.
> ⚠️ Yen pengin tanpa sandi, gunakake akun **SYSTEM** nalika nggawe task (ing dropdown *Change User or Group...* ketik **SYSTEM**).

</details>

<details>
<summary><b>🔒 Klik kanggo ndeleng Fitur Keamanan & Stabilitas ing Task Scheduler</b></summary>

Skrip iki wis dirancang khusus supaya aman 100% nalika mlaku otomatis liwat **Task Scheduler** ing latar mburi tanpa pengawasan:

1. **Auto-Detect Non-Interactive (`UserInteractive`):** Yen skrip dilakokake dening Task Scheduler (sanajan sampeyan lali nambahake parameter `-Silent`), skrip kanthi otomatis ndeteksi yen lagi mlaku ing latar mburi lan meksa mode silent (`$Silent = $true`). Iki nyegah skrip dadi beku (*freeze*) amarga ngenteni input pangguna (kaya printah interaktif `Read-Host` ing proses update).
2. **Process-Aware Protection:** Sadurunge ngresiki cache aplikasi (Chrome, Edge, Brave, Opera, Firefox, Discord), skrip ngecek apa aplikasi kasebut lagi aktif. Yen aktif, reresik aplikasi kasebut diliwati kanthi cerdas supaya ora ngganggu sesi aktif sampeyan utawa nyebabake korupsi data.
3. **Graceful Elevation Check:** Yen Task Scheduler lali dikonfigurasi nganggo "Highest Privileges", skrip ora bakal ngetokake pop-up UAC Windows sing bisa nggantung ing background. Skrip ndeteksi prekara iki kanthi meneng-menengan, nyathet eror ing berkas log, banjur metu kanthi resik.
4. **Smart Windows Update Cleanup:** Layanan Windows Update (`wuauserv`) mung bakal dihentikake sementara yen wektu iku statusé lagi mlaku, lan bakal diuripake maneh sawise reresik rampung. Yen statusé wiwit awal pancen lagi mati, skrip ora bakal ngowahi preferensi sistem sampeyan.

</details>

<details>
<summary><b>📂 Klik kanggo ndeleng Daftar Area sing Diresiki</b></summary>

Mung folder lan area ing ngisor iki sing diresiki:
- `%TEMP%` (User Temp)
- `C:\Windows\Temp` (System Temp)
- `C:\Windows\Prefetch` (Mung isi folder, khusus kanggo HDD)
- **Windows Update Download Cache** (`C:\Windows\SoftwareDistribution\Download`)
- **GPU & Shader Cache** (NVIDIA, AMD, Intel - DXCache, GLCache, ComputeCache, ShaderCache)
- **Browser & App Caches non-kritis** (Chrome, Edge, Brave, Opera Stable, Opera GX, Firefox, Discord):
  - Cache & cache2
  - Code Cache & startupCache
  - GPUCache & DawnWebGPUCache
  - ShaderCache, jumpListCache, & thumbnail

Folder autentikasi, cookies, lan session **babar blas ora disenggol**.

</details>

<details>
<summary><b>🔧 Klik kanggo ndeleng Panduan Pemeliharaan (Maintenance)</b></summary>

Yen ana owah-owahan struktur OS utawa browser ing mangsa ngarep:
- Review maneh path cache.
- Pesthekake data session tetep aman.
- Sesuaikan logic deteksi process yen dibutuhake.

</details>

---

## 📄 Status & Info

- **Automated Project Tool** kanthi sistem pembaruan otomatis terintegrasi.
- **Auto-Versioning** (diwiwiti saka `v1.0.0` minangka versi stabil pisanan).
- **Self-Updating**: Kanthi otomatis ngecek lan ngundhuh versi paling anyar langsung saka repositori GitHub sampeyan (`ncexs/ncexs-AutoTask`) nalika dilakokake.
- Cocog diintegrasikake karo Windows Task Scheduler kanggo pangopènan rutin tanpa campur tangan manual.

---

## 📜 Lisensi

MIT License - deleng berkas [LICENSE](../LICENSE) kanggo rinciané.  
Gunakake kanthi risiko sampeyan dhewe ⚠️.
