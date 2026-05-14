# 📋 変更履歴 (Changelog)

🌐 [English](../CHANGELOG.md) | [Bahasa Indonesia](CHANGELOG.id.md) | [Basa Jawa](CHANGELOG.jv.md) | [Basa Sunda](CHANGELOG.su.md) | [हिन्दी](CHANGELOG.hi.md) | [Русский](CHANGELOG.ru.md) | **日本語** | [한국어](CHANGELOG.ko.md) | [简体中文](CHANGELOG.zh.md) | [العربية](CHANGELOG.ar.md)

---

**ncexs Auto Task** プロジェクトのすべての重要な変更は、このファイルに記録されます。

---

## 🚀 [2.0.0-Auto] - 2026-05-10

### 🛠️ バグ修正 (Bug Fixes)
- **Safe-SetService Fix:** v1.0.0 において `Safe-SetService` を呼び出していたにもかかわらず、関数定義が `Set-ServiceStartupSafely` となっていた重大なタイポを修正しました。これにより、以前は Windows サービスのスタートアップ最適化がすべて静かに失敗していました。

### ✨ 新機能 (New Features)
- **Integrated Self-Updater:** スクリプトの起動時に、GitHub リポジトリ (`ncexs/Win-Runtime-Optimizer`) から最新バージョンを自動的に検知、ダウンロード、適用、再読み込みできるようになりました。
- **対応アプリケーションの拡大:** **Mozilla Firefox**、**Opera GX**（ゲーミングブラウザ）、および **Discord**（人気通信アプリ）の安全なキャッシュクリーンアップを追加しました。
- **GPU & Shader Cache Cleanup:** **NVIDIA**（DXCache, GLCache, ComputeCache）、**AMD**（DxCache, OglCache）、**Intel**（ShaderCache）グラフィックスプロセッサの物理的なシェーダーキャッシュフォルダのクリーンアップを追加しました。
- **高度な実行パラメータ:** 強力なパラメータ制御を導入しました：
  - `-Silent`（コンソール出力を一切行わず、完全なバックグラウンドで実行）
  - `-SkipUpdate`（起動時の自動アップデート確認をスキップ）
  - `-ForceUpdate`（ローカルバージョンが同一であっても GitHub からの再ダウンロードを強制）
  - `-CustomBranch`（GitHub のカスタムリリースブランチを指定）

### 🔒 セキュリティと安定性 (Security & Stability)
- **非インタラクティブ自動検知 (`UserInteractive`):** タスクスケジューラやバックグラウンドサービスによって実行された場合、スクリプトは非インタラクティブ環境を自動検知し、サイレントモード (`$Silent = $true`) を強制適用します。これにより、アップデート中のユーザー入力待ち（`Read-Host` など）によるスクリプトのフリーズを防ぎます。
- **プロセス認識型個別クリーンアップ:** ブラウザとアプリの稼働チェックがより正確になりました。Google Chrome が起動中で Firefox が閉じている場合、スクリプトは安全に Chrome をスキップし、Firefox のみをクリーンアップします（以前は、いずれか1つのブラウザが起動しているとすべてのブラウザをスキップしていました）。
- **完全な ASCII 互換性:** コンソールバナーおよびログ内のすべての Unicode 罫線文字を、100% 標準的な ASCII 表現に置き換えました。これにより、レガシーな Windows PowerShell 5.1 環境でのパースおよびエンコーディングによるクラッシュを防ぎます。

---

## 📦 [1.0.0] - 2026-05-10

### ✨ 初回リリース (Initial Release)
ポータブルで安全、サイレントかつ安定した Windows ランタイムメンテナンススクリプトの初回リリース。

- スクリプト実行ごとの自動ログファイルリセット機能を追加。
- プロセスを認識するようブラウザキャッシュクリーンアップをアップグレード。
- Chromium ベースのアプリケーションにおける表示不具合（glitch）を防ぐため、ブラウザからの GPUCache および ShaderCache の削除を廃止。
- 手動ページ更新前にブラウザの表示域が破損する競合状態（race condition）を解消。
- PSScriptAnalyzer のガイドラインに完全準拠するため、承認された PowerShell 動詞を使用して内部ヘルパー関数の名前を変更（`Is-` -> `Test-`）。
- ハードウェアおよびシステムの自動検知（Windows 10/11、RAM 容量、SSD/HDD の判別）を実装。
- SSD の不必要な書き込み摩耗を防ぐため、Prefetch のクリーンアップを HDD ストレージドライブのみで実行するよう設定。
- 状況に応じた Windows サービスのスタートアップ調整（SysMain, WSearch, DiagTrack, Xbox, ClipSVC）を実装。
- 稼働中のウェブブラウザに影響を与えることなく、低 RAM システム（8 GB 以下）に特化したメモリワーキングセット削減戦略（メモリトリム）を設計。
- Windows Update によってダウンロードされたインストールファイルの安全かつ完全な削除を追加。
- 構造化され、タイムスタンプが付与されたファイルへのロギングを統合。
- 6時間ごとのタスクスケジューラによる無人バックグラウンド実行において、絶対的なスクリプト互換性を確保。

**リリース 1.0.0 の成果:**
- ブラウザの画面破損や視覚的な不具合は一切なし。
- 稼働中の WhatsApp Web セッションの完全な安定性。
- 安全でシームレスなスケジュールバックグラウンド実行。
