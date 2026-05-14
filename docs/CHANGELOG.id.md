# 📋 Catatan Perubahan (Changelog)

🌐 [English](../CHANGELOG.md) | **Bahasa Indonesia** | [Basa Jawa](CHANGELOG.jv.md) | [Basa Sunda](CHANGELOG.su.md) | [हिन्दी](CHANGELOG.hi.md) | [Русский](CHANGELOG.ru.md) | [日本語](CHANGELOG.ja.md) | [한국어](CHANGELOG.ko.md) | [简体中文](CHANGELOG.zh.md) | [العربية](CHANGELOG.ar.md)

---

Semua perubahan penting pada proyek **ncexs Auto Task** akan didokumentasikan dalam file ini.

---

## 🚀 [2.0.0-Auto] - 2026-05-10

### 🛠️ Perbaikan Bug (Bug Fixes)
- **Safe-SetService Fix:** Memperbaiki kesalahan ketik (typo) kritis di mana `Safe-SetService` dipanggil tetapi fungsi tersebut didefinisikan sebagai `Set-ServiceStartupSafely` pada v1.0.0, yang sebelumnya menyebabkan semua optimisasi startup Windows Services gagal secara diam-diam.

### ✨ Fitur Baru (New Features)
- **Integrated Self-Updater:** Skrip kini dapat secara otomatis mendeteksi, mengunduh, menerapkan, dan memuat ulang versi terbaru langsung dari repositori GitHub (`ncexs/Win-Runtime-Optimizer`) saat dijalankan.
- **Dukungan Aplikasi Tambahan:** Menambahkan pembersihan cache yang aman untuk **Mozilla Firefox**, **Opera GX** (browser gaming), dan **Discord** (aplikasi komunikasi populer).
- **GPU & Shader Cache Cleanup:** Menambahkan pembersihan folder fisik shader cache untuk prosesor grafis **NVIDIA** (DXCache, GLCache, ComputeCache), **AMD** (DxCache, OglCache), dan **Intel** (ShaderCache).
- **Parameter Eksekusi Lanjutan:** Memperkenalkan kontrol parameter yang andal:
  - `-Silent` (menjalankan skrip sepenuhnya di latar belakang tanpa output konsol)
  - `-SkipUpdate` (melewati pemeriksaan pembaruan otomatis di awal)
  - `-ForceUpdate` (memaksa pengunduhan ulang skrip secara bersih dari GitHub)
  - `-CustomBranch` (menargetkan branch rilis kustom di GitHub)

### 🔒 Keamanan & Stabilitas (Security & Stability)
- **Deteksi Otomatis Non-Interaktif (`UserInteractive`):** Jika dijalankan oleh Task Scheduler atau layanan latar belakang, skrip secara otomatis mendeteksi lingkungan non-interaktif dan memaksa mode silent (`$Silent = $true`). Ini mencegah skrip membeku (*freeze*) akibat menunggu prompt input pengguna (seperti `Read-Host` selama pembaruan).
- **Pembersihan Per-Item (Process-Aware):** Pengecekan browser dan aplikasi kini sangat presisi. Jika Google Chrome aktif tetapi Firefox ditutup, skrip dengan aman melewati Chrome dan membersihkan Firefox (sebelumnya melewati semua browser secara global jika ada satu browser yang aktif).
- **Kompatibilitas ASCII Murni:** Mengganti semua karakter unicode box-drawing pada banner konsol dan log dengan representasi 100% ASCII standar. Ini mencegah crash parsing/encoding pada lingkungan Windows PowerShell 5.1 lama.

---

## 📦 [1.0.0] - 2026-05-10

### ✨ Rilis Perdana (Initial Release)
Rilis perdana skrip pemeliharaan runtime Windows yang portabel, aman, silent, dan stabil.

- Menambahkan reset file log otomatis pada setiap eksekusi skrip.
- Meningkatkan pembersihan cache browser menjadi process-aware.
- Menghapus pembersihan GPUCache dan ShaderCache dari browser untuk mencegah gangguan visual (glitch) pada aplikasi berbasis Chromium.
- Menyelesaikan race condition yang menyebabkan korupsi tampilan browser sebelum dimuat ulang (refresh) secara manual.
- Mengganti nama fungsi pembantu internal menggunakan kata kerja PowerShell yang disetujui (`Is-` -> `Test-`) agar sepenuhnya mematuhi pedoman PSScriptAnalyzer.
- Menerapkan deteksi perangkat keras dan sistem otomatis (Windows 10/11, kapasitas RAM, dan deteksi drive SSD vs HDD).
- Mengonfigurasi pembersihan Prefetch agar hanya berjalan pada drive penyimpanan HDD (mencegah keausan penulisan SSD yang tidak perlu).
- Menerapkan penyesuaian startup Windows Services adaptif (SysMain, WSearch, DiagTrack, Xbox, dan ClipSVC).
- Merancang strategi pengurangan working-set memori (memory trim) khusus untuk sistem minim RAM (<= 8 GB) tanpa memengaruhi browser web aktif.
- Menambahkan penghapusan file instalasi unduhan Windows Update secara aman dan menyeluruh.
- Mengintegrasikan pencatatan log terstruktur dan berstempel waktu ke dalam file.
- Memastikan kompatibilitas skrip mutlak untuk eksekusi latar belakang otomatis melalui Task Scheduler setiap 6 jam.

**Hasil Rilis 1.0.0:**
- Tidak ada korupsi tampilan browser atau glitch visual.
- Stabilitas mutlak untuk sesi WhatsApp Web yang sedang aktif.
- Eksekusi latar belakang terjadwal yang aman dan lancar.
