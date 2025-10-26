# CLAUDE.md

このファイルは、このリポジトリでコード作業を行う際のClaude Code (claude.ai/code)への指針を提供します。

## プロジェクト概要

「member_list_demo_flutter」はFlutter Webで構築されたメンバー名簿管理アプリケーションです。URLクエリパラメータによるモード切り替え（閲覧/編集）、パスワード認証、検索機能を備えたモダンなWebアプリです。Web配信専用に設定されており、GitHub Pagesでホスティングされます。

## 開発コマンド

すべての開発タスクにはMakefileを使用してください：

- `make dev` - 開発サーバー起動（`flutter run -d web-server`を実行）
- `make build` - リリース用Webアプリケーションビルド
- `make release` - リリースコミット作成と自動デプロイトリガー
- `make clean` - ビルド成果物削除

追加のFlutterコマンド：
- `flutter test` - ウィジェットテスト実行
- `flutter analyze` - 静的解析とlintチェック実行
- `flutter pub get` - 依存関係インストール

テスト用の特別なコマンド：
- `make dev-view` - 閲覧モードで開発サーバー起動
- `make dev-edit` - 編集モードで開発サーバー起動

## アーキテクチャ

- **対象プラットフォーム**: Web専用（非Webプラットフォームサポートは削除済み）
- **エントリーポイント**: `lib/main.dart`にgo_routerベースのルーティングとモード切り替え機能が実装されています
- **認証システム**: URLクエリによるモード切り替え（?mode=view/edit）とパスワード認証
- **データ管理**: SharedPreferencesによるローカルストレージとCRUD操作
- **検索機能**: 全フィールド対応の高速検索とフィルタリング
- **UIデザイン**: Material Design 3とレスポンシブデザイン
- **デプロイ**: コミットメッセージに「release」が含まれた際のGitHub Actions自動化

## 主要機能

### 認証・モード切り替え
- **URLクエリベース**: `?mode=view`（閲覧）/ `?mode=edit`（編集）
- **パスワード認証**: 閲覧モード `view123` / 編集モード `edit456`
- **セッション管理**: SharedPreferencesによる認証状態保持

### メンバー管理機能
- **CRUD操作**: 新規登録、編集、削除（編集モードのみ）
- **データフィールド**: 名前、会社名、部署、メール、電話番号
- **検索機能**: 全フィールド対象のリアルタイム検索
- **初期データ**: 10名の多様な企業・部署のサンプルメンバー

### UI・UX
- **シンプルデザイン**: アバター・ログアウトボタンなしのクリーンUI
- **レスポンシブ**: モバイルファーストのカード型レイアウト
- **Material Design 3**: ビジネス向けテーマカラー
- **アクセシビリティ**: 適切なコントラスト比とタッチターゲット

## 技術設定

- **Flutter SDK**: 3.27.2（stableチャンネル）
- **Dart SDK**: ^3.6.1
- **主要依存関係**: `go_router`, `shared_preferences`, `cupertino_icons`
- **ビルドターゲット**: GitHub Pages用base href `/member_list_demo_flutter/`でのWeb
- **リンティング**: 厳格なlintルール適用（型チェック、スタイル統一、セキュリティ）

## デプロイワークフロー

プロジェクトは自動デプロイにGitHub Actionsを使用：
1. メッセージに「release」を含むコミットをプッシュしてデプロイをトリガー
2. または`make release`を使用して空のリリースコミットを作成
3. GitHub Actionsが自動的にビルドしてGitHub Pagesにデプロイ
4. デプロイは「release」を含むコミットまたは手動ワークフロー実行時のみ発生

## Lint設定

プロジェクトには厳格なlintルールが設定されています：

### 有効化されたルール
- **スタイルルール**: `prefer_single_quotes`, `prefer_const_constructors`, `prefer_final_fields`など
- **設計ルール**: `avoid_unnecessary_containers`, `avoid_print`, `use_key_in_widget_constructors`など
- **エラー防止ルール**: `avoid_dynamic_calls`, `cancel_subscriptions`, `close_sinks`など
- **パフォーマンスルール**: `prefer_interpolation_to_compose_strings`, `use_string_buffers`など
- **セキュリティルール**: `avoid_catching_errors`など

### Analyzer設定
- **厳格な型チェック**: すべての型推論を厳密に行います
- **除外ファイル**: 生成されたファイル（`*.g.dart`, `*.freezed.dart`など）は解析対象外

## テスト・デバッグ機能

### 開発用パスワード
- **閲覧モード**: `view123`
- **編集モード**: `edit456`

### ローカル開発アクセス
- デフォルト: `http://localhost:3000/`
- 閲覧モード: `http://localhost:3000/?mode=view`
- 編集モード: `http://localhost:3000/?mode=edit`

### 本番環境アクセス
- デフォルト: `https://furugen.github.io/member_list_demo_flutter/`
- 閲覧モード: `https://furugen.github.io/member_list_demo_flutter/?mode=view`
- 編集モード: `https://furugen.github.io/member_list_demo_flutter/?mode=edit`

## ドキュメント管理

- **ドキュメント配置**: すべてのドキュメントは`doc/`フォルダに配置してください
- **ドキュメント作成**: 新しいドキュメントを作成する際は、必ず`doc/`フォルダ内に保存してください
- このルールにより、プロジェクトのドキュメントが整理され、見つけやすくなります

## UI・デザインガイドライン

- **デザインシステム**: `lib/theme/business_theme.dart` に統一されたテーマとスタイルを定義
- **デザインガイドライン**: `doc/design_guidelines.md` に包括的なデザイン仕様を記載
- **必須ルール**: 
  - UIコンポーネントの作成・変更時は必ず `doc/design_guidelines.md` を参照
  - カラー・フォント・スペーシングはハードコード禁止、必ず `BusinessTheme` から参照
  - モバイルファーストの原則に従い、最小タッチターゲット44pt以上を維持
  - アクセシビリティ基準（コントラスト比4.5:1以上）を遵守
- **更新時**: UIの変更を行った場合は、対応するデザインガイドラインドキュメントも更新すること