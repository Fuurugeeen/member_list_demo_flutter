# CLAUDE.md

このファイルは、このリポジトリでコード作業を行う際のClaude Code (claude.ai/code)への指針を提供します。

## プロジェクト概要

「member_list_demo_flutter」というFlutter Webアプリケーションで、メンバーリストインターフェースのデモプロジェクトです。Web配信専用に設定されており、GitHub Pagesでホスティングされます。

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
- **エントリーポイント**: `lib/main.dart`に標準的なFlutterカウンターデモアプリが含まれています
- **テスト**: `test/widget_test.dart`に基本的なウィジェットテスト
- **デプロイ**: コミットメッセージに「release」が含まれた際のGitHub Actions自動化

## 主要設定

- **Flutter SDK**: 3.27.2（stableチャンネル）
- **Dart SDK**: ^3.6.1
- **リンティング**: `flutter_lints`をベースに厳格なlintルールを適用
  - 厳格な型チェック（strict-casts, strict-inference, strict-raw-types）
  - コードスタイル統一（single quotes, const constructors, final declarations）
  - パフォーマンス最適化ルール
  - セキュリティルール
- **依存関係**: `cupertino_icons`, `go_router`, `shared_preferences`
- **ビルドターゲット**: GitHub Pages用base href `/member_list_demo_flutter/`でのWeb

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

### 自動ログイン機能（開発用）
- **動作**: アプリ起動時に自動でログインが実行されます
- **パスワード事前入力**: モードに応じて適切なパスワードが自動設定されます
  - 閲覧モード: `view123`
  - 編集モード: `edit456`
- **目的**: 開発・テスト時の手間を削減

### アクセス方法
- デフォルト: `http://localhost:3000/`
- 閲覧モード: `http://localhost:3000/?mode=view`
- 編集モード: `http://localhost:3000/?mode=edit`

## ドキュメント管理

- **ドキュメント配置**: すべてのドキュメントは`doc/`フォルダに配置してください
- **ドキュメント作成**: 新しいドキュメントを作成する際は、必ず`doc/`フォルダ内に保存してください
- このルールにより、プロジェクトのドキュメントが整理され、見つけやすくなります