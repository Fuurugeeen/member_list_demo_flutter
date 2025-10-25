# Member List Demo Flutter

Flutter Webで構築された名簿管理デモアプリケーションです。URLクエリパラメータによるモード切り替えとパスワード認証機能を備えています。

## 🚀 ライブデモ

### GitHub Pages デプロイ
- **ベースURL**: https://fuurugeeen.github.io/member_list_demo_flutter/

### アクセス方法

#### 📖 閲覧モード (読み取り専用)
- **URL**: https://fuurugeeen.github.io/member_list_demo_flutter/?mode=view
- **パスワード**: `view123`
- **機能**: 名簿の閲覧のみ

#### ✏️ 編集モード (CRUD操作)
- **URL**: https://fuurugeeen.github.io/member_list_demo_flutter/?mode=edit
- **パスワード**: `edit456`
- **機能**: 名簿の追加・編集・削除

#### 🔄 デフォルトモード
- **URL**: https://fuurugeeen.github.io/member_list_demo_flutter/
- **動作**: 閲覧モードと同じ

## ✨ 機能

### 🔐 認証システム
- **モード別パスワード**: 閲覧用と編集用で異なるパスワード
- **セッション管理**: ブラウザセッション中は認証状態を保持
- **自動ログイン**: 開発時のテスト用機能

### 📋 名簿管理
- **メンバー情報**: 名前、会社名、部署、メール、電話番号
- **CRUD操作**: 新規追加、編集、削除（編集モードのみ）
- **データ永続化**: ローカルストレージで情報保存
- **バリデーション**: 入力フィールドの必須チェック

### 🎨 UI/UX
- **レスポンシブ対応**: デスクトップ・モバイル両対応
- **Material Design 3**: モダンなデザインシステム
- **文字アバター**: 名前の最初の文字を表示
- **直感的操作**: 分かりやすいアイコンとレイアウト

## 🛠️ 技術スタック

- **フロントエンド**: Flutter Web
- **ルーティング**: go_router
- **状態管理**: Flutter内蔵のStatefulWidget
- **データ永続化**: shared_preferences (ローカルストレージ)
- **UI**: Material Design 3
- **デプロイ**: GitHub Pages

## 📱 サポートプラットフォーム

- **Web専用**: Chrome、Firefox、Safari、Edge
- **レスポンシブ**: デスクトップ、タブレット、モバイル

## 🏗️ 開発者向け情報

### 前提条件
- Flutter SDK 3.27.2以上
- Dart SDK
- Web対応ブラウザ

### ローカル開発

```bash
# リポジトリをクローン
git clone https://github.com/Fuurugeeen/member_list_demo_flutter.git
cd member_list_demo_flutter

# 依存関係をインストール
flutter pub get

# 開発サーバー起動（デフォルト）
make dev

# モード別での起動
make dev-view    # 閲覧モード
make dev-edit    # 編集モード

# ビルド
make build

# リリース
make release
```

### 利用可能なコマンド

```bash
make help        # 全コマンドの説明表示
make dev         # 開発サーバー起動 (http://localhost:3000/)
make dev-view    # 閲覧モード用サーバー起動
make dev-edit    # 編集モード用サーバー起動
make build       # プロダクションビルド
make release     # リリースコミット作成と自動デプロイ
make clean       # ビルド成果物削除
```

### デバッグ用URL（ローカル開発時）

- **デフォルト**: http://localhost:3000/
- **閲覧モード**: http://localhost:3000/?mode=view
- **編集モード**: http://localhost:3000/?mode=edit

### プロジェクト構造

```
lib/
├── main.dart              # エントリーポイント
├── models/
│   └── member.dart        # メンバーデータモデル
├── services/
│   ├── auth_service.dart  # 認証サービス
│   └── storage_service.dart # データ永続化
├── screens/
│   ├── auth_screen.dart   # ログイン画面
│   ├── member_list_screen.dart # 名簿一覧
│   └── member_edit_screen.dart # 編集画面
└── widgets/               # 再利用可能ウィジェット

docs/
└── wireframes.md          # 画面設計書

.github/workflows/
└── deploy.yml             # 自動デプロイ設定
```

## 🚀 デプロイ

このプロジェクトはGitHub Actionsによる自動デプロイを使用しています。

### 自動デプロイ条件
- `main`ブランチへのプッシュ
- コミットメッセージに「release」が含まれる場合のみ

### 手動デプロイ
```bash
make release  # バージョン入力→空コミット→自動デプロイ
```

## 📄 ライセンス

このプロジェクトはデモ用途です。

## 🤝 コントリビューション

1. フォークしてください
2. フィーチャーブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add amazing feature'`)
4. ブランチをプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 📞 お問い合わせ

プロジェクトに関する質問や提案は、GitHubのIssuesをご利用ください。

---

**🤖 Generated with [Claude Code](https://claude.ai/code)**