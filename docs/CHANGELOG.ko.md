# 📋 변경 사항 (Changelog)

🌐 [English](../CHANGELOG.md) | [Bahasa Indonesia](CHANGELOG.id.md) | [Basa Jawa](CHANGELOG.jv.md) | [Basa Sunda](CHANGELOG.su.md) | [हिन्दी](CHANGELOG.hi.md) | [Русский](CHANGELOG.ru.md) | [日本語](CHANGELOG.ja.md) | **한국어** | [简体中文](CHANGELOG.zh.md) | [العربية](CHANGELOG.ar.md)

---

**ncexs Auto Task** 프로젝트의 모든 주요 변경 사항이 이 파일에 기록됩니다.

---

## 🚀 [2.0.0-Auto] - 2026-05-10

### 🛠️ 버그 수정 (Bug Fixes)
- **Safe-SetService Fix:** v1.0.0에서 `Safe-SetService`를 호출했지만 함수 정의가 `Set-ServiceStartupSafely`로 되어 있던 치명적인 오타를 수정했습니다. 이로 인해 이전에는 모든 Windows 서비스 시작 최적화가 알림 없이 실패했습니다.

### ✨ 새로운 기능 (New Features)
- **Integrated Self-Updater:** 이제 스크립트 실행 시 GitHub 저장소(`ncexs/Win-Runtime-Optimizer`)에서 최신 버전을 자동으로 감지, 다운로드, 적용 및 다시 로드할 수 있습니다.
- **지원 애플리케이션 확장:** **Mozilla Firefox**, **Opera GX**(게이밍 브라우저) 및 **Discord**(인기 통신 애플리케이션)에 대한 안전한 캐시 정리가 추가되었습니다.
- **GPU & Shader Cache Cleanup:** **NVIDIA**(DXCache, GLCache, ComputeCache), **AMD**(DxCache, OglCache), **Intel**(ShaderCache) 그래픽 프로세서에 대한 물리적 셰이더 캐시 폴더 정리가 추가되었습니다.
- **고급 실행 매개변수:** 강력한 매개변수 제어가 도입되었습니다.
  - `-Silent` (콘솔 출력 없이 백그라운드에서 완전히 실행)
  - `-SkipUpdate` (시작 시 초기 자동 업데이트 확인 건너뛰기)
  - `-ForceUpdate` (로컬 버전이 동일하더라도 GitHub에서 스크립트 강제 다시 다운로드)
  - `-CustomBranch` (GitHub에서 사용자 지정 릴리스 브랜치 설정)

### 🔒 보안 및 안정성 (Security & Stability)
- **비대화형 자동 감지(`UserInteractive`):** Task Scheduler 또는 백그라운드 서비스에서 실행되는 경우 스크립트가 비대화형 환경을 자동으로 감지하고 자동 모드(`$Silent = $true`)를 강제 적용합니다. 이렇게 하면 업데이트 중에 사용자 입력 프롬프트(`Read-Host` 등) 대기로 인해 스크립트가 정지되는 것을 방지할 수 있습니다.
- **프로세스 인식 개별 정리:** 브라우저 및 앱 실행 확인이 더욱 정확해졌습니다. Google Chrome이 실행 중이지만 Firefox가 닫혀 있는 경우 스크립트는 Chrome을 안전하게 건너뛰고 Firefox만 정리합니다(이전에는 단일 브라우저가 실행 중이면 모든 브라우저를 건너뛰었습니다).
- **완벽한 ASCII 호환성:** 콘솔 배너 및 로그의 모든 유니코드 테두리 기호를 100% 표준 ASCII 기호로 대체했습니다. 이렇게 하면 레거시 Windows PowerShell 5.1 환경에서 구문 분석 및 인코딩 충돌을 방지할 수 있습니다.

---

## 📦 [1.0.0] - 2026-05-10

### ✨ 첫 릴리스 (Initial Release)
포터블하고 안전하며 조용하고 안정적인 Windows 런타임 유지 관리 스크립트의 첫 릴리스입니다.

- 스크립트 실행 시 자동으로 로그 파일을 초기화하는 기능 추가.
- 프로세스를 인식하도록 브라우저 캐시 정리를 업그레이드.
- Chromium 기반 애플리케이션에서 화면 깨짐(glitch)을 방지하기 위해 브라우저에서 GPUCache 및 ShaderCache 삭제 기능 제거.
- 수동 페이지 새로 고침 전에 브라우저 화면이 손상되는 경쟁 상태(race condition) 해결.
- PSScriptAnalyzer 지침을 완벽하게 준수하기 위해 승인된 PowerShell 동사를 사용하여 내부 도우미 함수 이름 변경(`Is-` -> `Test-`).
- 자동 하드웨어 및 시스템 감지(Windows 10/11, RAM 용량, SSD 및 HDD 감지) 구현.
- SSD의 불필요한 쓰기 마모를 방지하기 위해 Prefetch 정리를 HDD 스토리지 드라이브에서만 실행하도록 설정.
- 상황에 맞는 Windows 서비스 시작 튜닝(SysMain, WSearch, DiagTrack, Xbox, ClipSVC) 구현.
- 활성 웹 브라우저에 영향을 주지 않으면서 저사양 RAM 시스템(8GB 이하)을 위한 전용 메모리 작업 세트 축소 전략(메모리 트림) 설계.
- Windows Update에서 다운로드한 설치 파일의 안전하고 완벽한 삭제 추가.
- 구조화되고 타임스탬프가 기록되는 파일 로깅 통합.
- 6시간마다 Task Scheduler를 통한 무인 백그라운드 실행을 위한 완벽한 스크립트 호환성 보장.

**릴리스 1.0.0 결과:**
- 브라우저 화면 손상이나 시각적 결함 없음.
- 활성 WhatsApp Web 세션의 완벽한 안정성.
- 안전하고 원활하게 예약된 백그라운드 실행.
