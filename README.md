# Win Runtime Optimizer

Win Runtime Optimizer adalah skrip PowerShell portable untuk optimisasi runtime Windows  
secara **aman, silent, dan stabil**, tanpa mengganggu aplikasi atau sesi yang sedang berjalan.

Script ini digunakan sebagai **tools internal di dalam folder project**,  
bukan untuk public release atau distribusi umum.

---

## 🎯 Tujuan

- Menjaga performa Windows tetap stabil
- Mengurangi lag akibat cache dan temp yang menumpuk
- Membersihkan runtime sampah yang aman untuk dihapus
- Mendukung eksekusi otomatis tanpa mengganggu user

---

## ✅ Yang Dilakukan Skrip

- Membersihkan runtime cache ringan dan aman:
  - User Temp (`%TEMP%`)
  - System Temp (`C:\Windows\Temp`)
  - Prefetch (isi folder saja)
  - GPU / Shader Cache (AMD, NVIDIA, Intel)
- Membersihkan browser cache **non-kritis**:
  - Cache
  - Code Cache
  - GPUCache
  - ShaderCache
- Mendeteksi browser yang sedang aktif
- **Skip cleanup browser jika sedang digunakan**
- Mendukung browser:
  - Google Chrome
  - Microsoft Edge
  - Brave Browser
  - Mozilla Firefox

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

- `%TEMP%`
- `C:\Windows\Temp`
- `C:\Windows\Prefetch` (isi saja)
- GPU / Shader Cache vendor
- Browser cache non-kritis:
  - Cache
  - Code Cache
  - GPUCache
  - ShaderCache

Folder autentikasi dan session **tidak disentuh**.

---

## ▶️ Cara Menjalankan Manual

Jalankan PowerShell dengan perintah berikut:

    powershell -ExecutionPolicy Bypass -File WinRuntimeOptimizer.ps1

Script berjalan **silent tanpa output**.

---

## ⏱️ Setup Otomatis (Task Scheduler)

Bagian ini ditujukan untuk pengguna awam maupun internal  
yang ingin menjalankan script secara otomatis.

---

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

> Catatan: Menjalankan setiap 1 jam **tidak direkomendasikan**  
> karena script ini bersifat maintenance ringan, bukan real-time optimizer.

---

### 4️⃣ Tab Actions

- Klik **New**
- Action: **Start a program**
- Program/script:

      powershell.exe

- Add arguments:

      -ExecutionPolicy Bypass -File "C:\Users\ncexs\Downloads\WinRuntimeOptimizer.ps1"

- Start in (optional):

      C:\Users\ncexs\Downloads

> Ganti path sesuai lokasi kamu menyimpan script.

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

---

## 🧠 Prinsip Desain

- Aman > agresif
- Stabilitas jangka panjang
- Tidak mengganggu aplikasi aktif
- Cocok dijalankan rutin sebagai maintenance ringan

---

## 📄 Status

- Internal project tool
- Tidak ada release publik
- Tidak ada versioning eksternal
- Digunakan sesuai kebutuhan project

---

## 🔧 Maintenance

Jika ada perubahan struktur OS atau browser:

- Review ulang path cache
- Pastikan data session tetap aman
- Sesuaikan logic deteksi process bila diperlukan
