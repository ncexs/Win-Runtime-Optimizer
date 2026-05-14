# 📋 Cathetan Owah-owahan (Changelog)

🌐 [English](../CHANGELOG.md) | [Bahasa Indonesia](CHANGELOG.id.md) | **Basa Jawa** | [Basa Sunda](CHANGELOG.su.md) | [हिन्दी](CHANGELOG.hi.md) | [Русский](CHANGELOG.ru.md) | [日本語](CHANGELOG.ja.md) | [한국어](CHANGELOG.ko.md) | [简体中文](CHANGELOG.zh.md) | [العربية](CHANGELOG.ar.md)

---

Kabeh owah-owahan wigati ing proyek **ncexs Auto Task** bakal dicathet ing berkas iki.

---

## 🚀 [2.0.0-Auto] - 2026-05-10

### 🛠️ Ndandani Bug (Bug Fixes)
- **Safe-SetService Fix:** Ndandani salah ketik (typo) kritis ing ngendi `Safe-SetService` diceluk nanging fungsi kasebut didefinisikake minangka `Set-ServiceStartupSafely` ing v1.0.0, sing sadurunge nyebabake kabeh optimisasi startup Windows Services gagal tanpa ana pesen eror.

### ✨ Fitur Anyar (New Features)
- **Integrated Self-Updater:** Skrip saiki bisa kanthi otomatis ndeteksi, ngundhuh, ngetrapake, lan mbukak maneh versi paling anyar langsung saka repositori GitHub (`ncexs/Win-Runtime-Optimizer`) nalika dilakokake.
- **Dukungan Aplikasi Tambahan:** Nambahake reresik cache sing aman kanggo **Mozilla Firefox**, **Opera GX** (browser gaming), lan **Discord** (aplikasi komunikasi populer).
- **GPU & Shader Cache Cleanup:** Nambahake reresik folder fisik shader cache kanggo prosesor grafis **NVIDIA** (DXCache, GLCache, ComputeCache), **AMD** (DxCache, OglCache), lan **Intel** (ShaderCache).
- **Parameter Eksekusi Lanjutan:** Ngenalake kontrol parameter sing canggih:
  - `-Silent` (nglakokake skrip ing latar mburi tanpa output konsol)
  - `-SkipUpdate` (ngliwati pamriksa pembaruan otomatis ing wiwitan)
  - `-ForceUpdate` (meksa ngundhuh ulang skrip kanthi resik saka GitHub)
  - `-CustomBranch` (nemtokake branch rilis kustom ing GitHub)

### 🔒 Keamanan & Stabilitas (Security & Stability)
- **Deteksi Otomatis Non-Interaktif (`UserInteractive`):** Yen dilakokake dening Task Scheduler utawa layanan latar mburi, skrip kanthi otomatis ndeteksi lingkungan non-interaktif lan meksa mode silent (`$Silent = $true`). Iki nyegah skrip dadi mandheg (*freeze*) amarga ngenteni prompt input pangguna (kaya `Read-Host` nalika pembaruan).
- **Reresik Per-Item (Process-Aware):** Pengecekan browser lan aplikasi saiki luwih tliti. Yen Google Chrome aktif nanging Firefox ditutup, skrip kanthi aman ngliwati Chrome lan ngresiki Firefox (sadurunge ngliwati kabeh browser kanthi global yen ana siji browser sing aktif).
- **Kompatibilitas ASCII Murni:** Ngganti kabeh karakter unicode box-drawing ing banner konsol lan log dadi representasi 100% ASCII standar. Iki nyegah crash parsing/encoding ing lingkungan Windows PowerShell 5.1 lawas.

---

## 📦 [1.0.0] - 2026-05-10

### ✨ Rilis Wiwitan (Initial Release)
Rilis wiwitan skrip pangopènan runtime Windows sing portabel, aman, silent, lan stabil.

- Nambahake reset berkas log otomatis ing saben eksekusi skrip.
- Nganyari reresik cache browser dadi process-aware.
- Mbusak reresik GPUCache lan ShaderCache saka browser supaya ora ana gangguan visual (glitch) ing aplikasi adhedhasar Chromium.
- Ndandani race condition sing nyebabake korupsi tampilan browser sadurunge dimuat ulang (refresh) kanthi manual.
- Ngganti jeneng fungsi pambiyantu internal nggunakake kata kerja PowerShell sing disetujui (`Is-` -> `Test-`) supaya manut pedoman PSScriptAnalyzer.
- Ngetrapake deteksi piranti keras lan sistem otomatis (Windows 10/11, kapasitas RAM, lan deteksi drive SSD vs HDD).
- Ngonfigurasi reresik Prefetch mung kanggo drive panyimpenan HDD (nyegah kausan panulisan SSD sing ora perlu).
- Ngetrapake panyesuaian startup Windows Services adaptif (SysMain, WSearch, DiagTrack, Xbox, lan ClipSVC).
- Ngrancang strategi pangurangan working-set memori (memory trim) khusus kanggo sistem kanthi RAM sithik (<= 8 GB) tanpa mengaruhi browser web aktif.
- Nambahake pambusakan berkas instalasi undhuhan Windows Update kanthi aman lan tuntas.
- Ngintegrasikake pancathetan log terstruktur lan mawa stempel wektu ing berkas.
- Mesthekake kompatibilitas skrip mutlak kanggo eksekusi latar mburi otomatis liwat Task Scheduler saben 6 jam.

**Hasil Rilis 1.0.0:**
- Ora ana korupsi tampilan browser utawa glitch visual.
- Stabilitas mutlak kanggo sesi WhatsApp Web sing lagi aktif.
- Eksekusi latar mburi terjadwal sing aman lan lancar.
