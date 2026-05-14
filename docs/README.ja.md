# ⚡ ncexs Auto Task (NAT)

🌐 [English](../README.md) | [Bahasa Indonesia](README.id.md) | [Basa Jawa](README.jv.md) | [Basa Sunda](README.su.md) | [हिन्दी](README.hi.md) | [Русский](README.ru.md) | **日本語** | [한국어](README.ko.md) | [简体中文](README.zh.md) | [العربية](README.ar.md)

📄 **[変更履歴](CHANGELOG.ja.md)** | 🛠️ **v2.0.0-Auto**

**ncexs Auto Task** は、稼働中のアプリケーションやブラウザセッションを中断することなく、安全、サイレント、かつ安定した Windows ランタイムのメンテナンスおよび最適化を行うために設計された、軽量でポータブルな PowerShell スクリプトです。

---

## 🎯 目的と設計思想

<table width="100%">
  <tr>
    <th width="50%" align="left">🎯 目的</th>
    <th width="50%" align="left">🧠 設計思想</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li>一貫したシステムパフォーマンスと安定性の維持。</li>
        <li>蓄積された一時ファイルやキャッシュの削除による、システム遅延やラグの軽減。</li>
        <li>不要なランタイムファイルの安全なクリーンアップ。</li>
        <li>ユーザーの作業を妨げない、完全自動のバックグラウンド実行の実現。</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li><b>安全性 > 積極性</b></li>
        <li>長期的な安定性と信頼性。</li>
        <li>稼働中のユーザーアプリケーションとの干渉ゼロ。</li>
        <li>軽量な定期メンテナンス処理として最適。</li>
      </ul>
    </td>
  </tr>
</table>

---

## ⚡ スクリプトの適用範囲と機能

<table width="100%">
  <tr>
    <th width="50%" align="left">✅ スクリプトが実行すること</th>
    <th width="50%" align="left">❌ スクリプトが実行しないこと</th>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li><b>安全で軽量なシステムキャッシュクリーンアップ:</b>
          <ul>
            <li>ユーザー一時ファイル (<code>%TEMP%</code>)</li>
            <li>システム一時ファイル (<code>C:\Windows\Temp</code>)</li>
            <li>Prefetch キャッシュ（フォルダ内のファイルのみ。SSD の摩耗を防ぐため HDD に限定）</li>
            <li><b>GPU & Shader Cache</b> (AMD, NVIDIA, Intel - DXCache, GLCache, ComputeCache, ShaderCache)</li>
          </ul>
        </li>
        <li><b>プロセス認識型ブラウザ＆アプリキャッシュクリーンアップ:</b>
          <ul>
            <li>非必須キャッシュ (Cache, Code Cache, GPUCache, DawnWebGPUCache, ShaderCache) を安全に削除します。</li>
            <li><b>アプリケーションごとの稼働チェック:</b> Google Chrome が起動中で Firefox や Edge が閉じている場合、スクリプトは安全に Chrome をスキップし、Firefox と Edge をクリーンアップします。</li>
          </ul>
        </li>
        <li><b>対応アプリケーション:</b> Google Chrome, Microsoft Edge, Brave Browser, Opera Stable, Opera GX, Mozilla Firefox, Discord.</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li>開いているウェブブラウザを閉じたり、稼働中のプロセスを終了したりすることは<b>ありません</b>。</li>
        <li>ウェブアプリやウェブサイトからログアウトさせることは<b>ありません</b>。</li>
        <li>ブラウザの Cookie を削除することは<b>ありません</b>。</li>
        <li>Local Storage、Session Storage、または IndexedDB を削除することは<b>ありません</b>。</li>
        <li>Windows レジストリ設定やシステムポリシーを変更することは<b>ありません</b>。</li>
        <li>システムを破壊するような過度な最適化を避け、純粋に安全な<b>ランタイムメンテナンス</b>に特化しています。</li>
      </ul>
    </td>
  </tr>
</table>

---

## ▶️ 実行方法

### 手動実行

PowerShell を起動し（対話型モードで実行した場合は、自動的に管理者権限への昇格プロンプトが表示されます）、以下のコマンドを実行します：

```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1
```

#### ⚙️ オプションパラメータ (高度な設定)

以下のパラメータを使用して実行方法をカスタマイズできます：

* **`-Silent`**: コンソール出力を一切行わず、スクリプトを完全なバックグラウンドで実行します。タスクスケジューラでの使用に推奨されます。
* **`-SkipUpdate`**: 起動時の自動アップデート確認（セルフアップデーター）をスキップします。
* **`-ForceUpdate`**: ローカルバージョンが同一であっても、GitHub リポジトリからスクリプトの再ダウンロードを強制します。
* **`-CustomBranch "ブランチ名"`**: アップデートを確認するカスタムブランチを指定します（デフォルトは `"main"`）。

実行例：
```powershell
powershell -ExecutionPolicy Bypass -File ncexs-AutoTask.ps1 -Silent -SkipUpdate
```

---

## ⚙️ 高度な設定とガイド

<details>
<summary><b>⏱️ クリックして自動設定（タスクスケジューラ）ガイドを表示</b></summary>

### 1️⃣ タスクスケジューラを開く
**Win + R** キーを押して以下を入力します：
```
taskschd.msc
```
**Enter** キーを押します。

---

### 2️⃣ 新しいタスクの作成
**「タスクの作成」**をクリックします（※「基本タスクの作成」は選択しないでください）。

**「全般」タブ**
- 名前：`ncexs Auto Task`
- 以下の項目にチェックを入れます：
  - ユーザーがログオンしているかどうかにかかわらず実行する
  - 最上位の特権で実行する

---

### 3️⃣「トリガー」タブ
- **「新規」**をクリックします。
- タスクの開始：**「スケジュールに従う」**
- **「毎日」**を選択します。

**詳細設定 (任意):**
- タスクの繰り返し間隔：**「6 時間」**  
  *(※ 1日1回のみ実行したい場合はチェックを外してください)*
- 継続時間：**「無期限」**
- **「有効」**にチェックを入れます。
- **「OK」**をクリックします。

> ⚠️ ドロップダウンメニューの最大値は「1 時間」ですが、手動で **6 時間** または **06:00:00** と入力できます。このスクリプトはリアルタイム監視ツールではなく軽量なメンテナンスツールであるため、1時間ごとの実行は**推奨されません**。

---

### 4️⃣「操作」タブ
- **「新規」**をクリックします。
- 操作：**「プログラムの開始」**
- プログラム/スクリプト：`powershell.exe`
- 引数の追加：
  ```
  -ExecutionPolicy Bypass -File "C:\Path\To\ncexs-AutoTask.ps1" -Silent
  ```
- 開始オプション (任意)：`C:\Path\To`

> ⚠️ `C:\Path\To` の部分は、スクリプトを保存した実際のフォルダパスに置き換えてください。

---

### 5️⃣「条件」タブ
- 以下のチェックを外します：`コンピュータを AC 電源で使用している場合のみタスクを開始する`

---

### 6️⃣「設定」タブ
- 以下の項目にチェックを入れます：
  - タスクを要求時に実行する
  - スケジュールされた開始時刻に実行できなかった場合、すぐにタスクを実行する
- 以下のチェックを外します：`タスクが指定の時間を超えて実行される場合は停止する`

**「OK」**をクリックし、要求された場合は Windows のパスワードを入力します。
> ⚠️ パスワードの入力を省略してタスクを実行したい場合は、ユーザーを **SYSTEM** に設定してください（「ユーザーまたはグループの変更...」をクリックし、**SYSTEM** と入力して「OK」をクリック）。

</details>

<details>
<summary><b>🔒 クリックしてタスクスケジューラにおけるセキュリティと安定性の機能を表示</b></summary>

このスクリプトは、バックグラウンドの **タスクスケジューラ** 経由で 100% 安全かつ無人で実行されるように設計されています：

1. **非インタラクティブ自動検知 (`UserInteractive`):** タスクスケジューラ経由で実行された場合（`-Silent` パラメータを付け忘れた場合でも）、スクリプトはバックグラウンド実行環境を自動検知し、サイレントモード (`$Silent = $true`) を強制します。これにより、アップデート中の入力プロンプト（`Read-Host` など）によってスクリプトがフリーズするのを防ぎます。
2. **プロセス認識型保護:** ブラウザやアプリのキャッシュを削除する前に、そのアプリケーションが起動中であるかを検証します。起動中の場合は、そのプログラムのクリーンアップをスキップすることで、アクティブなセッションを保護し、データベースの破損を防ぎます。
3. **安全な権限チェック:** タスクの設定で「最上位の特権」が付与されていない場合でも、スクリプトは停止したりセッション 0 で非表示の UAC ポップアップを出したりしません。ログファイルに警告を記録し、正常に終了します。
4. **スマートな Windows Update クリーンアップ:** Windows Update サービス (`wuauserv`) は、スクリプト実行時に起動していた場合のみ一時的に停止され、クリーンアップ直後に再起動されます。もともと無効または停止していた場合、スクリプトはシステムの設定を維持します。

</details>

<details>
<summary><b>📂 クリックしてクリーンアップ対象ディレクトリを表示</b></summary>

以下の特定のフォルダのみがクリーンアップの対象となります：
- `%TEMP%` (ユーザー一時フォルダ)
- `C:\Windows\Temp` (システム一時フォルダ)
- `C:\Windows\Prefetch` (フォルダ内のファイルのみ。HDD 限定)
- **Windows Update ダウンロードキャッシュ** (`C:\Windows\SoftwareDistribution\Download`)
- **GPU & Shader Cache** (NVIDIA, AMD, Intel - DXCache, GLCache, ComputeCache, ShaderCache)
- **非必須ブラウザ＆アプリキャッシュ** (Chrome, Edge, Brave, Opera Stable, Opera GX, Firefox, Discord):
  - Cache & cache2
  - Code Cache & startupCache
  - GPUCache & DawnWebGPUCache
  - ShaderCache, jumpListCache, & thumbnail

認証フォルダ、アクティブなユーザーセッション、および Cookie は、**一切変更されません**。

</details>

<details>
<summary><b>🔧 クリックしてメンテナンス＆レビューガイドを表示</b></summary>

今後のアップデートでシステムファイル、OS の構造、またはブラウザのディレクトリパスが変更された場合：
- ブラウザプロファイルおよびキャッシュのディレクトリパスを確認してください。
- ユーザーデータおよびセッションストレージが完全に保護されていることを確認してください。
- 必要に応じて、稼働プロセスチェックのロジックを調整してください。

</details>

---

## 📄 ステータスと情報

- 完全統合型の自己更新メカニズムを備えた**自動化プロジェクトツール**。
- **自動バージョニング**（安定版リリースの基準として `v1.0.0` から開始）。
- **自動アップデート**: 起動時に GitHub リポジトリ (`ncexs/ncexs-AutoTask`) から最新のリリースを自動的に照会・取得します。
- Windows タスクスケジューラによるスケジュール実行に最適化。

---

## 📜 ライセンス

MIT ライセンス - 詳細は [LICENSE](../LICENSE) ファイルをご覧ください。  
自己責任においてご使用ください ⚠️。
