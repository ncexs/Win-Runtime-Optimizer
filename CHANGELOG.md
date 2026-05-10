# 📋 Changelog

Semua perubahan penting pada proyek **Win Runtime Optimizer** akan didokumentasikan di berkas ini.

---

## 🚀 [2.0.0-Auto] - 2026-05-10

### 🛠️ Perbaikan Bug (Bug Fixes)
- **Safe-SetService Fix:** Memperbaiki kesalahan nama pemanggilan fungsi `Safe-SetService` (sebelumnya `Set-ServiceStartupSafely` pada v1.0.0) yang menyebabkan fungsi optimasi startup Windows Services tidak berjalan secara diam-diam.

### ✨ Fitur Baru (Features)
- **Self-Updater (Auto-Update) Otomatis:** Skrip sekarang dapat mendeteksi, mengunduh, memasang, dan memuat ulang dirinya sendiri secara langsung dari repositori GitHub (`ncexs/Win-Runtime-Optimizer`) saat pertama kali dijalankan.
- **Dukungan Aplikasi Lebih Luas:** Menambahkan pembersihan cache aman untuk **Mozilla Firefox**, **Opera GX** (gaming browser), dan **Discord** (aplikasi chat terpopuler).
- **GPU & Shader Cache Cleanup:** Menambahkan pembersihan shader cache fisik yang aman untuk kartu grafis **NVIDIA** (DXCache, GLCache, ComputeCache), **AMD** (DxCache, OglCache), dan **Intel** (ShaderCache).
- **Parameter Eksekusi Tambahan:** Menambahkan kontrol parameter canggih:
  - `-Silent` (Menjalankan latar belakang secara penuh)
  - `-SkipUpdate` (Melewati proses update check)
  - `-ForceUpdate` (Memaksa instalasi ulang dari GitHub)
  - `-CustomBranch` (Mengubah target branch rilis)

### 🔒 Keamanan & Stabilitas (Security & Stability)
- **Auto-Detect Non-Interactive (`UserInteractive`):** Jika dijalankan oleh Task Scheduler (bahkan tanpa parameter `-Silent`), skrip otomatis mendeteksi lingkungan latar belakang dan memaksa mode silent (`$Silent = $true`) untuk mencegah pembekuan (*freeze*) akibat menunggu masukan pengguna.
- **Process-Aware Per-Item:** Skrip kini memilah proses secara cerdas. Jika Google Chrome aktif tetapi Firefox tertutup, skrip hanya melewati Chrome dan tetap membersihkan Firefox dengan aman (sebelumnya skip global untuk semua browser jika salah satu aktif).
- **ASCII Compatibility:** Mengganti karakter Unicode box-drawing dengan karakter ASCII standar penuh untuk menjamin skrip bebas dari kegagalan parsing/encoding pada Windows PowerShell 5.1 bawaan OS.

---

## 📦 [1.0.0] - 2026-05-10

### ✨ Rilis Awal (Initial Release)
Rilis awal berupa skrip pemeliharaan runtime Windows secara portable, aman, silent, dan stabil.

- Menambahkan reset log otomatis setiap kali skrip dijalankan.
- Mengubah pembersihan cache browser menjadi process-aware.
- Menghapus pembersihan GPUCache dan ShaderCache dari logika browser untuk mencegah glitch tampilan Chromium.
- Memperbaiki race condition yang menyebabkan tampilan browser rusak sebelum di-refresh.
- Mengganti fungsi internal dengan kata kerja standar PowerShell (Is- -> Test-) agar sesuai dengan rekomendasi PSScriptAnalyzer.
- Menambahkan deteksi sistem otomatis (Windows 10/11, ukuran RAM, dan tipe disk SSD/HDD).
- Mengatur pembersihan Prefetch hanya dilakukan pada sistem berjenis drive HDD (untuk mencegah keausan SSD).
- Menambahkan tuning servis adaptif (SysMain, WSearch, DiagTrack, Xbox, ClipSVC).
- Menambahkan strategi pemotongan memory working set (memory trim) khusus untuk perangkat RAM rendah (<= 8 GB) tanpa menyentuh browser aktif.
- Menambahkan pembersihan aman pada sisa file download Windows Update.
- Menambahkan penulisan log terstruktur dengan stempel waktu (timestamp).
- Memastikan kelayakan skrip saat dijalankan terjadwal via Task Scheduler setiap 6 jam.

**Hasil Rilis 1.0.0:**
- Tidak ada lagi tampilan browser rusak atau glitch visual.
- Stabil dan sangat aman untuk sesi WA Web aktif.
- Sangat aman untuk eksekusi terjadwal.
