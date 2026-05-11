# ⚡ ncexs Auto Task (NAT)

🌐 [English](README.md) | **Bahasa Indonesia**

📄 **[Catatan Perubahan](CHANGELOG.md)** | 🛠️ **v2.0.0-Auto**

**ncexs Auto Task** adalah skrip PowerShell portable untuk optimisasi runtime Windows secara **aman, silent, dan stabil**, tanpa mengganggu aplikasi atau sesi yang sedang berjalan.

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
        <li>Menjaga performa Windows tetap stabil.</li>
        <li>Mengurangi lag akibat cache dan temp yang menumpuk.</li>
        <li>Membersihkan runtime sampah yang aman untuk dihapus.</li>
        <li>Mendukung eksekusi otomatis tanpa mengganggu user.</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li><b>Aman > Agresif</b></li>
        <li>Stabilitas jangka panjang.</li>
        <li>Tidak mengganggu aplikasi aktif.</li>
        <li>Cocok dijalankan rutin sebagai maintenance ringan.</li>
      </ul>
    </td>
  </tr>
</table>

---

## ⚡ Cakupan & Kemampuan Skrip

<table width="100%">
  <tr>
    <th width="50%" align="left">✅ Yang Dilakukan Skrip</th>
    <th width="50%" align="left">❌ Yang TIDAK Dilakukan</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li><b>Pembersihan Cache Sistem Ringan dan Aman:</b>
          <ul>
            <li>User Temp (<code>%TEMP%</code>)</li>
            <li>System Temp (<code>C:\Windows\Temp</code>)</li>
            <li>Prefetch (isi folder saja - khusus HDD)</li>
            <li><b>GPU & Shader Cache</b> (AMD, NVIDIA, Intel - DXCache, GLCache, ComputeCache, ShaderCache)</li>
          </ul>
        </li>
        <li><b>Pembersihan Cache Browser & Aplikasi Ringan (Proses-Aware):</b>
          <ul>
            <li>Hanya menghapus file cache non-kritis (Cache, Code Cache, GPUCache, DawnWebGPUCache, ShaderCache).</li>
            <li><b>Mendeteksi aplikasi per-item:</b> Jika Chrome aktif tetapi Firefox/Edge tertutup, skrip akan tetap membersihkan Firefox/Edge dengan aman dan hanya melewati Chrome!</li>
          </ul>
        </li>
        <li><b>Mendukung Aplikasi:</b> Google Chrome, Microsoft Edge, Brave Browser, Opera Stable, Opera GX, Mozilla Firefox, dan Discord.</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li>Tidak menutup browser atau menghentikan proses aktif.</li>
        <li>Tidak logout dari aplikasi web atau website.</li>
        <li>Tidak menghapus Cookies browser.</li>
        <li>Tidak menghapus Local Storage, Session Storage, atau IndexedDB.</li>
        <li>Tidak mengubah registry atau system policy Windows.</li>
        <li>Fokus pada <b>runtime cleanup</b>, bukan optimisasi agresif yang merusak sistem.</li>
      </ul>
    </td>
  </tr>
</table>

---

## ▶️ Cara Menjalankan

### Manual Execution

Jalankan PowerShell (akan otomatis meminta hak akses Administrator jika berjalan secara interaktif) dengan perintah berikut:

```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1
```

#### ⚙️ Parameter Opsional (Advanced)

Anda bisa menambahkan parameter berikut untuk menyesuaikan jalannya skrip:

* **`-Silent`**: Menjalankan skrip secara latar belakang (silent) tanpa output ke layar konsol sama sekali. Sangat cocok untuk otomatisasi Task Scheduler.
* **`-SkipUpdate`**: Melewati pengecekan pembaruan otomatis (self-updater) di awal eksekusi.
* **`-ForceUpdate`**: Memaksa pengunduhan ulang skrip dari GitHub meskipun versi lokal Anda sudah sama dengan versi remote.
* **`-CustomBranch "nama_branch"`**: Mengubah target branch untuk pembaruan skrip (default: `"main"`).

Contoh pemakaian:
```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1 -Silent -SkipUpdate
```

---

## ⚙️ Panduan Lanjutan & Setup

<details>
<summary><b>⏱️ Klik untuk melihat Panduan Setup Otomatis (Task Scheduler)</b></summary>

### 1️⃣ Buka Task Scheduler
Tekan **Win + R**, lalu ketik:
```
taskschd.msc
```
Tekan **Enter**.

---

### 2️⃣ Buat Task Baru
Klik **Create Task** (jangan pilih *Basic Task*)

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
  *(atau kosongkan jika hanya ingin jalan sekali sehari)*
- For a duration of: **Indefinitely**
- Centang **Enable**
- Klik **OK**

> ⚠️ Dropdown hanya menampilkan sampai 1 hour, kamu bisa mengetik manual **6 hours** atau **06:00:00**. Menjalankan setiap 1 jam **tidak direkomendasikan** karena script ini bersifat maintenance ringan, bukan real-time optimizer.

---

### 4️⃣ Tab Actions
- Klik **New**
- Action: **Start a program**
- Program/script: `powershell.exe`
- Add arguments:
  ```
  -ExecutionPolicy Bypass -File "C:\Path\Ke\ncexs-AutoTask.ps1" -Silent
  ```
- Start in (optional): `C:\Path\Ke`

> ⚠️ Ganti `C:\Path\Ke` sesuai lokasi kamu menyimpan script.

---

### 5️⃣ Tab Conditions
- Hilangkan centang: `Start the task only if the computer is on AC power`

---

### 6️⃣ Tab Settings
- Centang:
  - Allow task to be run on demand
  - Run task as soon as possible after a scheduled start is missed
- Jangan centang: `Stop the task if it runs longer than`

Klik **OK**, lalu masukkan password Windows jika diminta.
> ⚠️ Jika ingin tanpa password, gunakan akun **SYSTEM** saat membuat task (di dropdown *Change User or Group...* ketik **SYSTEM**).

</details>

<details>
<summary><b>🔒 Klik untuk melihat Fitur Keamanan & Stabilitas di Task Scheduler</b></summary>

Skrip ini telah dirancang khusus agar aman 100% saat berjalan otomatis melalui **Task Scheduler** di latar belakang tanpa pengawasan:

1. **Auto-Detect Non-Interactive (`UserInteractive`):** Jika skrip dijalankan oleh Task Scheduler (bahkan jika Anda lupa menambahkan parameter `-Silent`), skrip secara otomatis mendeteksi bahwa ia berjalan di latar belakang dan memaksa mode silent (`$Silent = $true`). Ini mencegah skrip membeku (*freeze*) akibat menunggu input pengguna (seperti perintah interaktif `Read-Host` pada proses update).
2. **Process-Aware Protection:** Sebelum membersihkan cache aplikasi (Chrome, Edge, Brave, Opera, Firefox, Discord), skrip mengecek apakah aplikasi tersebut sedang aktif. Jika aktif, pembersihan aplikasi tersebut dilewati secara cerdas agar tidak mengganggu sesi aktif Anda atau menyebabkan korupsi data.
3. **Graceful Elevation Check:** Jika Task Scheduler lupa dikonfigurasi dengan "Highest Privileges", skrip tidak akan memunculkan pop-up UAC Windows yang dapat menggantung di background. Skrip mendeteksi hal ini secara diam-diam, mencatat eror ke file log, lalu keluar secara bersih.
4. **Smart Windows Update Cleanup:** Layanan Windows Update (`wuauserv`) hanya akan dihentikan sementara jika saat itu statusnya sedang berjalan, dan akan dinyalakan kembali setelah pembersihan selesai. Jika statusnya sejak awal memang sedang mati, skrip tidak akan mengubah preferensi sistem Anda.

</details>

<details>
<summary><b>📂 Klik untuk melihat Daftar Area yang Dibersihkan</b></summary>

Hanya folder dan area berikut yang dibersihkan:
- `%TEMP%` (User Temp)
- `C:\Windows\Temp` (System Temp)
- `C:\Windows\Prefetch` (Hanya isi folder, khusus untuk HDD)
- **Windows Update Download Cache** (`C:\Windows\SoftwareDistribution\Download`)
- **GPU & Shader Cache** (NVIDIA, AMD, Intel - DXCache, GLCache, ComputeCache, ShaderCache)
- **Browser & App Caches non-kritis** (Chrome, Edge, Brave, Opera Stable, Opera GX, Firefox, Discord):
  - Cache & cache2
  - Code Cache & startupCache
  - GPUCache & DawnWebGPUCache
  - ShaderCache, jumpListCache, & thumbnail

Folder autentikasi, cookies, dan session **sama sekali tidak disentuh**.

</details>

<details>
<summary><b>🔧 Klik untuk melihat Panduan Pemeliharaan (Maintenance)</b></summary>

Jika ada perubahan struktur OS atau browser di masa mendatang:
- Review ulang path cache.
- Pastikan data session tetap aman.
- Sesuaikan logic deteksi process bila diperlukan.

</details>

---

## 📄 Status & Info

- **Automated Project Tool** dengan sistem pembaruan otomatis terintegrasi.
- **Auto-Versioning** (dimulai dari `v1.0.0` sebagai versi stabil pertama).
- **Self-Updating**: Secara otomatis mengecek dan mengunduh versi terbaru langsung dari repositori GitHub Anda (`ncexs/ncexs-AutoTask`) saat dijalankan.
- Cocok diintegrasikan dengan Windows Task Scheduler untuk pemeliharaan rutin tanpa campur tangan manual.

---

## 📜 Lisensi

MIT License - lihat file [LICENSE](LICENSE) untuk detailnya.  
Gunakan dengan risiko Anda sendiri ⚠️.
