# ⚡ Win Runtime Optimizer

🌐 **Bahasa Indonesia** | [English](README.md)

📄 **[Catatan Perubahan](CHANGELOG.md)** | 🛠️ **v2.0.0-Auto**

Win Runtime Optimizer adalah skrip PowerShell portable untuk optimisasi runtime Windows  
secara **aman, silent, dan stabil**, tanpa mengganggu aplikasi atau sesi yang sedang berjalan.

---

## 🎯 Tujuan

- Menjaga performa Windows tetap stabil
- Mengurangi lag akibat cache dan temp yang menumpuk
- Membersihkan runtime sampah yang aman untuk dihapus
- Mendukung eksekusi otomatis tanpa mengganggu user

---

## ✅ Yang Dilakukan Skrip

- **Pembersihan Cache Sistem Ringan dan Aman:**
  - User Temp (`%TEMP%`)
  - System Temp (`C:\Windows\Temp`)
  - Prefetch (isi folder saja - khusus HDD)
  - **GPU & Shader Cache** (AMD, NVIDIA, Intel - DXCache, GLCache, ComputeCache, ShaderCache)
- **Pembersihan Cache Browser & Aplikasi Ringan (Proses-Aware):**
  - Hanya menghapus file cache non-kritis (Cache, Code Cache, GPUCache, DawnWebGPUCache, ShaderCache)
  - **Mendeteksi aplikasi per-item:** Jika Chrome aktif tetapi Firefox/Edge tertutup, skrip akan tetap membersihkan Firefox/Edge dengan aman dan hanya melemwati Chrome!
  - Mendukung aplikasi:
    - Google Chrome
    - Microsoft Edge
    - Brave Browser
    - Opera Stable & **Opera GX** (Gaming Browser)
    - Mozilla Firefox
    - **Discord** (Aplikasi chat/gaming, cache-nya sering menumpuk hingga GB)

---

## ❌ Yang TIDAK Dilakukan

- Tidak menutup browser
- Tidak kill process
- Tidak logout web app
- Tidak menghapus Cookies
- Tidak menghapus Local Storage
- Tidak menghapus IndexedDB
- Tidak mengubah registry atau system policy

Script ini fokus pada **runtime cleanup**, bukan optimisasi agresif.

---

## 📂 Area yang Dibersihkan

Hanya folder dan area berikut:

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

Folder autentikasi, cookies, dan session **tidak disentuh**.

---

## ▶️ Cara Menjalankan Manual

Jalankan PowerShell (akan otomatis meminta hak akses Administrator jika berjalan secara interaktif) dengan perintah berikut:

```powershell
powershell -ExecutionPolicy Bypass -File WinRuntimeOptimizer.ps1
```

### ⚙️ Parameter Opsional (Advanced)

Anda bisa menambahkan parameter berikut untuk menyesuaikan jalannya skrip:

* **`-Silent`**: Menjalankan skrip secara latar belakang (silent) tanpa output ke layar konsol sama sekali. Sangat cocok untuk otomatisasi Task Scheduler.
* **`-SkipUpdate`**: Melewati pengecekan pembaruan otomatis (self-updater) di awal eksekusi.
* **`-ForceUpdate`**: Memaksa pengunduhan ulang skrip dari GitHub meskipun versi lokal Anda sudah sama dengan versi remote.
* **`-CustomBranch "nama_branch"`**: Mengubah target branch untuk pembaruan skrip (default: `"main"`).

Contoh pemakaian:
```powershell
powershell -ExecutionPolicy Bypass -File WinRuntimeOptimizer.ps1 -Silent -SkipUpdate
```

---

## ⏱️ Setup Otomatis (Task Scheduler)

### 1️⃣ Buka Task Scheduler

Tekan **Win + R**, lalu ketik:

    taskschd.msc

Tekan **Enter**

---

### 2️⃣ Buat Task Baru

Klik **Create Task** (jangan pilih *Basic Task*)

**Tab General**
- Name:
  
      Win Runtime Optimizer

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

> ⚠️ Dropdown hanya menampilkan sampai 1 hour,
kamu bisa mengetik manual 6 hours atau 06:00:00.
Menjalankan setiap 1 jam **tidak direkomendasikan** karena script ini bersifat maintenance ringan, bukan real-time optimizer.

---

### 4️⃣ Tab Actions

- Klik **New**
- Action: **Start a program**
- Program/script:

      powershell.exe

- Add arguments:

      -ExecutionPolicy Bypass -File "C:\Users\ncexs\Downloads\WinRuntimeOptimizer.ps1" -Silent

- Start in (optional):

      C:\Users\ncexs\Downloads

> ⚠️ Ganti path sesuai lokasi kamu menyimpan script.

---

### 5️⃣ Tab Conditions

- Hilangkan centang:
  - Start the task only if the computer is on AC power

---

### 6️⃣ Tab Settings

- Centang:
  - Allow task to be run on demand
  - Run task as soon as possible after a scheduled start is missed
- Jangan centang:
  - Stop the task if it runs longer than

Klik **OK**, lalu masukkan password Windows jika diminta.
> ⚠️ Jika ingin tanpa password, gunakan akun SYSTEM saat membuat task (di dropdown Change User or Group... ketik SYSTEM).

## 🔒 Keamanan & Stabilitas di Task Scheduler

Skrip ini telah dirancang khusus agar aman 100% saat berjalan otomatis melalui **Task Scheduler** di latar belakang tanpa pengawasan:

1. **Auto-Detect Non-Interactive (`UserInteractive`):** Jika skrip dijalankan oleh Task Scheduler (bahkan jika Anda lupa menambahkan parameter `-Silent`), skrip secara otomatis mendeteksi bahwa ia berjalan di latar belakang dan memaksa mode silent (`$Silent = $true`). Ini mencegah skrip membeku (*freeze*) akibat menunggu input pengguna (seperti perintah interaktif `Read-Host` pada proses update).
2. **Process-Aware Protection:** Sebelum membersihkan cache aplikasi (Chrome, Edge, Brave, Opera, Firefox, Discord), skrip mengecek apakah aplikasi tersebut sedang aktif. Jika aktif, pembersihan aplikasi tersebut dilewati secara cerdas agar tidak mengganggu sesi aktif Anda atau menyebabkan korupsi data.
3. **Graceful Elevation Check:** Jika Task Scheduler lupa dikonfigurasi dengan "Highest Privileges", skrip tidak akan memunculkan pop-up UAC Windows yang dapat menggantung di background. Skrip mendeteksi hal ini secara diam-diam, mencatat eror ke file log, lalu keluar secara bersih.
4. **Smart Windows Update Cleanup:** Layanan Windows Update (`wuauserv`) hanya akan dihentikan sementara jika saat itu statusnya sedang berjalan, dan akan dinyalakan kembali setelah pembersihan selesai. Jika statusnya sejak awal memang sedang mati, skrip tidak akan mengubah preferensi sistem Anda.

---

## 🧠 Prinsip Desain

- Aman > agresif
- Stabilitas jangka panjang
- Tidak mengganggu aplikasi aktif
- Cocok dijalankan rutin sebagai maintenance ringan

---

## 📄 Status

- **Automated Project Tool** dengan sistem pembaruan otomatis terintegrasi.
- **Auto-Versioning** (dimulai dari `v1.0.0` sebagai versi stabil pertama).
- **Self-Updating**: Secara otomatis mengecek dan mengunduh versi terbaru langsung dari repositori GitHub Anda (`ncexs/Win-Runtime-Optimizer`) saat dijalankan.
- Cocok diintegrasikan dengan Windows Task Scheduler untuk pemeliharaan rutin tanpa campur tangan manual.

---

## 🔧 Maintenance

Jika ada perubahan struktur OS atau browser:

- Review ulang path cache
- Pastikan data session tetap aman
- Sesuaikan logic deteksi process bila diperlukan
