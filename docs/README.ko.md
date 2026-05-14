# ⚡ ncexs Auto Task (NAT)

🌐 [English](../README.md) | [Bahasa Indonesia](README.id.md) | [Basa Jawa](README.jv.md) | [Basa Sunda](README.su.md) | [हिन्दी](README.hi.md) | [Русский](README.ru.md) | [日本語](README.ja.md) | **한국어** | [简体中文](README.zh.md) | [العربية](README.ar.md)

📄 **[변경 사항](CHANGELOG.ko.md)** | 🛠️ **v2.0.0-Auto**

**ncexs Auto Task**는 활성 애플리케이션이나 브라우저 세션을 중단하지 않고 안전하고 조용하며 안정적인 Windows 런타임 유지 관리 및 최적화를 위해 설계된 가볍고 포터블한 PowerShell 스크립트입니다.

---

## 🎯 목적 및 설계 원칙

<table width="100%">
  <tr>
    <th width="50%" align="left">🎯 목적</th>
    <th width="50%" align="left">🧠 설계 원칙</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li>일관된 시스템 성능 및 안정성 유지.</li>
        <li>누적된 임시 파일 및 캐시를 삭제하여 시스템 지연 및 래그 감소.</li>
        <li>불필요한 런타임 파일의 안전한 정리.</li>
        <li>사용자 방해 없이 완벽하게 자동화된 백그라운드 실행.</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li><b>안전성 > 공격성</b></li>
        <li>장기적인 안정성 및 신뢰성.</li>
        <li>활성 사용자 애플리케이션과의 간섭 제로.</li>
        <li>가벼운 정기 유지 관리 작업으로 최적.</li>
      </ul>
    </td>
  </tr>
</table>

---

## ⚡ 스크립트 범위 및 기능

<table width="100%">
  <tr>
    <th width="50%" align="left">✅ 스크립트가 수행하는 작업</th>
    <th width="50%" align="left">❌ 스크립트가 수행하지 않는 작업</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li><b>안전하고 가벼운 시스템 캐시 정리:</b>
          <ul>
            <li>사용자 임시 파일(<code>%TEMP%</code>)</li>
            <li>시스템 임시 파일(<code>C:\Windows\Temp</code>)</li>
            <li>Prefetch 캐시(폴더 내 파일만 해당, SSD 마모를 방지하기 위해 HDD에만 한정)</li>
            <li><b>GPU & Shader Cache</b> (AMD, NVIDIA, Intel - DXCache, GLCache, ComputeCache, ShaderCache)</li>
          </ul>
        </li>
        <li><b>프로세스 인식 웹 브라우저 및 앱 캐시 정리:</b>
          <ul>
            <li>비중요 캐시(Cache, Code Cache, GPUCache, DawnWebGPUCache, ShaderCache)를 안전하게 삭제합니다.</li>
            <li><b>애플리케이션별 프로세스 확인:</b> Google Chrome이 실행 중이지만 Firefox나 Edge가 닫혀 있는 경우 스크립트는 Chrome을 안전하게 건너뛰고 Firefox/Edge를 정리합니다.</li>
          </ul>
        </li>
        <li><b>지원 애플리케이션:</b> Google Chrome, Microsoft Edge, Brave Browser, Opera Stable, Opera GX, Mozilla Firefox, Discord.</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li>실행 중인 웹 브라우저를 닫거나 활성 프로세스를 강제 종료하지 <b>않습니다</b>.</li>
        <li>웹 앱이나 웹사이트에서 로그아웃시키지 <b>않습니다</b>.</li>
        <li>브라우저 쿠키를 삭제하지 <b>않습니다</b>.</li>
        <li>Local Storage, Session Storage 또는 IndexedDB를 지우지 <b>않습니다</b>.</li>
        <li>Windows 레지스트리 설정이나 시스템 정책을 수정하지 <b>않습니다</b>.</li>
        <li>시스템을 파괴하는 공격적인 최적화를 피하고 순수하게 안전한 <b>런타임 유지 관리</b>에만 집중합니다.</li>
      </ul>
    </td>
  </tr>
</table>

---

## ▶️ 실행 방법

### 수동 실행

PowerShell을 실행하고(대화형 모드에서 실행 시 자동으로 관리자 권한을 요청함) 다음 명령을 실행합니다.

```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1
```

#### ⚙️ 선택적 매개변수(고급)

다음 매개변수를 사용하여 실행을 사용자 지정할 수 있습니다.

* **`-Silent`**: 콘솔 출력 없이 백그라운드에서 완전히 실행합니다. Task Scheduler에서 사용하는 것이 권장됩니다.
* **`-SkipUpdate`**: 시작 시 자동 업데이트 확인(자체 업데이트 프로그램)을 건너뜁니다.
* **`-ForceUpdate`**: 로컬 버전이 동일하더라도 GitHub 저장소에서 스크립트를 강제로 다시 다운로드합니다.
* **`-CustomBranch "브랜치_이름"`**: 업데이트를 확인할 사용자 지정 브랜치를 설정합니다(기본값 `"main"`).

사용 예시:
```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1 -Silent -SkipUpdate
```

---

## ⚙️ 고급 가이드 및 설정

<details>
<summary><b>⏱️ 클릭하여 자동 설정(Task Scheduler) 가이드 보기</b></summary>

### 1️⃣ Task Scheduler 열기
**Win + R** 키를 누르고 다음을 입력합니다.
```
taskschd.msc
```
**Enter** 키를 누릅니다.

---

### 2️⃣ 새 작업 만들기
**작업 만들기(Create Task)**를 클릭합니다(*기본 작업 만들기*를 선택하지 마십시오).

**일반(General) 탭**
- 이름: `ncexs Auto Task`
- 체크:
  - 사용자의 로그온 여부에 관계없이 실행
  - 가장 높은 수준의 권한으로 실행

---

### 3️⃣ 트리거(Triggers) 탭
- **새로 만들기(New)** 클릭
- 작업 시작: **예약 상태(On a schedule)**
- **매일(Daily)** 선택

**고급 설정(선택 사항):**
- 작업 반복 간격: **6시간(6 hours)**  
  *(매일 한 번만 실행하려면 체크 해제)*
- 지속 시간: **무기한(Indefinitely)**
- **사용(Enabled)** 체크
- **확인(OK)** 클릭

> ⚠️ 드롭다운 메뉴의 최대 시간은 1시간이지만 수동으로 **6시간** 또는 **06:00:00**을 입력할 수 있습니다. 이 스크립트는 실시간 감시 도구가 아니라 가벼운 유지 관리 도구이므로 1시간마다 실행하는 것은 **권장하지 않습니다**.

---

### 4️⃣ 동작(Actions) 탭
- **새로 만들기(New)** 클릭
- 동작: **프로그램 시작(Start a program)**
- 프로그램/스크립트: `powershell.exe`
- 인수 추가:
  ```
  -ExecutionPolicy Bypass -File "C:\Path\To\ncexs-AutoTask.ps1" -Silent
  ```
- 시작 위치(선택 사항): `C:\Path\To`

> ⚠️ `C:\Path\To`를 스크립트를 저장한 정확한 폴더 경로로 바꾸십시오.

---

### 5️⃣ 조건(Conditions) 탭
- 체크 해제: `컴퓨터가 AC 전원에 연결되어 있는 경우에만 작업 시작`

---

### 6️⃣ 설정(Settings) 탭
- 체크:
  - 요청 시 작업 실행 허용
  - 예약된 시작 시간을 놓친 경우 가능한 한 빨리 작업 실행
- 체크 해제: `작업이 다음 시간 이상 실행되면 중지`

**확인(OK)**을 클릭하고 메시지가 표시되면 Windows 암호를 입력합니다.
> ⚠️ 암호 입력 없이 작업을 실행하려면 사용자를 **SYSTEM**으로 설정하십시오(*사용자 또는 그룹 변경...*을 클릭하고 **SYSTEM**을 입력한 다음 확인을 클릭).

</details>

<details>
<summary><b>🔒 클릭하여 Task Scheduler의 보안 및 안정성 기능 보기</b></summary>

이 스크립트는 백그라운드에서 **Task Scheduler**를 통해 100% 안전하고 무인으로 실행되도록 설계되었습니다.

1. **비대화형 자동 감지(`UserInteractive`):** Task Scheduler를 통해 실행되는 경우(`-Silent` 매개변수를 생략하더라도) 스크립트가 백그라운드 실행 환경을 자동으로 감지하고 자동 모드(`$Silent = $true`)를 강제 적용합니다. 이렇게 하면 업데이트 중에 입력 프롬프트(`Read-Host` 등)로 인해 스크립트가 정지되는 것을 방지할 수 있습니다.
2. **프로세스 인식 보호:** 브라우저나 앱 캐시를 정리하기 전에 해당 애플리케이션이 실행 중인지 확인합니다. 실행 중인 경우 해당 프로그램의 정리를 건너뛰어 활성 세션을 보호하고 데이터베이스 손상을 방지합니다.
3. **안전한 권한 확인:** 작업이 "가장 높은 수준의 권한" 없이 잘못 구성된 경우 스크립트가 차단되거나 세션 0에서 숨겨진 UAC 팝업을 트리거하지 않습니다. 로그 파일에 경고를 기록하고 정상적으로 종료됩니다.
4. **스마트 Windows Update 정리:** Windows Update 서비스(`wuauserv`)는 스크립트 실행 시 실행 중이었던 경우에만 임시로 중지되며 정리 직후에 다시 시작됩니다. 원래 사용 안 함 또는 중지 상태였던 경우 스크립트는 시스템 설정을 유지합니다.

</details>

<details>
<summary><b>📂 클릭하여 정리 대상 폴더 보기</b></summary>

다음 특정 폴더만 정리 대상이 됩니다.
- `%TEMP%` (사용자 임시 파일)
- `C:\Windows\Temp` (시스템 임시 파일)
- `C:\Windows\Prefetch` (폴더 내 파일만 해당, HDD에만 한정)
- **Windows Update 다운로드 캐시** (`C:\Windows\SoftwareDistribution\Download`)
- **GPU & Shader Cache** (NVIDIA, AMD, Intel - DXCache, GLCache, ComputeCache, ShaderCache)
- **비중요 브라우저 및 앱 캐시** (Chrome, Edge, Brave, Opera Stable, Opera GX, Firefox, Discord):
  - Cache & cache2
  - Code Cache & startupCache
  - GPUCache & DawnWebGPUCache
  - ShaderCache, jumpListCache, & thumbnail

인증 폴더, 활성 사용자 세션 및 쿠키는 **전혀 손상되지 않습니다**.

</details>

<details>
<summary><b>🔧 클릭하여 유지 관리 및 검토 가이드 보기</b></summary>

향후 업데이트에서 시스템 파일, OS 구조 또는 브라우저 디렉터리 경로가 변경되는 경우:
- 브라우저 프로필 및 캐시의 디렉터리 경로를 검토합니다.
- 사용자 데이터 및 세션 스토리지가 완벽하게 보호되는지 확인합니다.
- 필요한 경우 실행 프로세스 확인 로직을 조정합니다.

</details>

---

## 📄 상태 및 정보

- 완벽하게 통합된 자체 업데이트 메커니즘을 갖춘 **자동화된 프로젝트 도구**.
- **자동 버전 관리** (안정화 릴리스 기준인 `v1.0.0`부터 시작).
- **자체 업데이트**: 스크립트 실행 시 GitHub 저장소(`ncexs/ncexs-AutoTask`)에서 최신 릴리스를 자동으로 조회하고 다운로드합니다.
- Windows Task Scheduler 예약에 최적화됨.

---

## 📜 라이선스

MIT 라이선스 - 자세한 내용은 [LICENSE](../LICENSE) 파일을 참조하십시오.  
사용에 따른 위험은 사용자 본인에게 있습니다 ⚠️.
