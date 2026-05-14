# 📋 Catetan Parobihan (Changelog)

🌐 [English](../CHANGELOG.md) | [Bahasa Indonesia](CHANGELOG.id.md) | [Basa Jawa](CHANGELOG.jv.md) | **Basa Sunda** | [हिन्दी](CHANGELOG.hi.md) | [Русский](CHANGELOG.ru.md) | [日本語](CHANGELOG.ja.md) | [한국어](CHANGELOG.ko.md) | [简体中文](CHANGELOG.zh.md) | [العربية](CHANGELOG.ar.md)

---

Sadaya parobihan penting dina proyék **ncexs Auto Task** bakal didokuméntasikeun dina berkas ieu.

---

## 🚀 [2.0.0-Auto] - 2026-05-10

### 🛠️ Lereskeun Bug (Bug Fixes)
- **Safe-SetService Fix:** Ngabenerkeun lepat ngetik (typo) kritis dimana `Safe-SetService` disauran tapi fungsi éta didefinisikeun salaku `Set-ServiceStartupSafely` dina v1.0.0, anu sateuacanna ngabalukarkeun sadaya optimisasi startup Windows Services gagal tanpa aya wawaran.

### ✨ Fitur Anyar (New Features)
- **Integrated Self-Updater:** Skrip ayeuna tiasa sacara otomatis mendakan, ngunduh, nerapkeun, sareng memuat ulang vérsi panganyarna langsung tina repositori GitHub (`ncexs/Win-Runtime-Optimizer`) nalika dijalankeun.
- **Pangrojong Aplikasi Tambahan:** Nambihan pangberesih cache anu aman pikeun **Mozilla Firefox**, **Opera GX** (browser gaming), sareng **Discord** (aplikasi komunikasi populér).
- **GPU & Shader Cache Cleanup:** Nambihan pangberesih folder fisik shader cache pikeun prosésor grafis **NVIDIA** (DXCache, GLCache, ComputeCache), **AMD** (DxCache, OglCache), sareng **Intel** (ShaderCache).
- **Parameter Éksékusi Lanjutan:** Ngawanohkeun kontrol parameter anu canggih:
  - `-Silent` (ngajalankeun skrip di latar pengker tanpa output konsol)
  - `-SkipUpdate` (ngalangkungan pamariksaan pembaruan otomatis di awal)
  - `-ForceUpdate` (maksa ngunduh ulang skrip sacara beresih tina GitHub)
  - `-CustomBranch` (nangtukeun branch rilis kustom di GitHub)

### 🔒 Kaamanan & Stabilitas (Security & Stability)
- **Detéksi Otomatis Non-Interaktif (`UserInteractive`):** Upami dijalankeun ku Task Scheduler atanapi layanan latar pengker, skrip sacara otomatis mendakan lingkungan non-interaktif sareng maksa mode silent (`$Silent = $true`). Ieu nyegah skrip janten beku (*freeze*) kusabab ngantosan prompt input pangguna (kawas `Read-Host` nalika pembaruan).
- **Pangberesih Per-Item (Process-Aware):** Pamariksaan browser sareng aplikasi ayeuna langkung taliti. Upami Google Chrome aktif tapi Firefox ditutup, skrip sacara aman ngalangkungan Chrome sareng ngabersihan Firefox (sateuacanna ngalangkungan sadaya browser sacara global upami aya hiji browser anu aktif).
- **Kompatibilitas ASCII Murni:** Ngganti sadaya karakter unicode box-drawing dina banner konsol sareng log janten répréséntasi 100% ASCII standar. Ieu nyegah crash parsing/encoding dina lingkungan Windows PowerShell 5.1 heubeul.

---

## 📦 [1.0.0] - 2026-05-10

### ✨ Rilis Munggaran (Initial Release)
Rilis munggaran skrip pangropéa runtime Windows anu portabel, aman, silent, sareng stabil.

- Nambihan reset berkas log otomatis dina unggal éksékusi skrip.
- Ngamutahirkeun pangberesih cache browser janten process-aware.
- Mupus pangberesih GPUCache sareng ShaderCache tina browser supados henteu aya gangguan visual (glitch) dina aplikasi dumasar Chromium.
- Ngabenerkeun race condition anu ngabalukarkeun korupsi tampilan browser sateuacan dimuat ulang (refresh) sacara manual.
- Ngganti nami fungsi pambantu internal ngagunakeun kecap gawe PowerShell anu disatujuan (`Is-` -> `Test-`) supados nurut kana pedoman PSScriptAnalyzer.
- Nerapkeun detéksi hardware sareng sistem otomatis (Windows 10/11, kapasitas RAM, sareng detéksi drive SSD vs HDD).
- Ngonfigurasi pangberesih Prefetch khusus pikeun drive panyimpenan HDD (nyegah kausan penulisan SSD anu henteu peryogi).
- Nerapkeun panyesuaian startup Windows Services adaptif (SysMain, WSearch, DiagTrack, Xbox, sareng ClipSVC).
- Ngarancang stratégi pangurangan working-set mémori (memory trim) khusus pikeun sistem minim RAM (<= 8 GB) tanpa mangaruhan browser web aktif.
- Nambihan pamupusan berkas instalasi unduhan Windows Update sacara aman sareng tuntas.
- Ngintegrasikeun pancatetan log terstruktur sareng nganggo stempel waktos dina berkas.
- Mastikeun kompatibilitas skrip mutlak pikeun éksékusi latar pengker otomatis ngalangkungan Task Scheduler unggal 6 jam.

**Hasil Rilis 1.0.0:**
- Henteu aya korupsi tampilan browser atanapi glitch visual.
- Stabilitas mutlak pikeun sési WhatsApp Web anu nuju aktif.
- Éksékusi latar pengker terjadwal anu aman sareng lancar.
