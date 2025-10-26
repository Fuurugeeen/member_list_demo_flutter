.PHONY: help dev dev-view dev-edit build release clean

# デフォルトターゲット
help:
	@echo "Available commands:"
	@echo "  make dev       - Start development server (default mode)"
	@echo "  make dev-view  - Start development server in view mode"
	@echo "  make dev-edit  - Start development server in edit mode"
	@echo "  make build     - Build web application"
	@echo "  make release   - Update version, build, commit and deploy"
	@echo "  make clean     - Clean build artifacts"
	@echo ""
	@echo "Debug access URLs:"
	@echo "  Default: http://localhost:3000/"
	@echo "  View:    http://localhost:3000/?mode=view"
	@echo "  Edit:    http://localhost:3000/?mode=edit"
	@echo ""
	@echo "Debug passwords:"
	@echo "  View mode: view123"
	@echo "  Edit mode: edit456"
	@echo ""
	@echo "Documentation update rules:"
	@echo "  - Screen layout changes: Update docs/wireframes.md"
	@echo "  - New features: Add new sections to wireframes"
	@echo "  - Flow changes: Update user flow diagrams"
	@echo "  - Always record change reason and date in update history"

# 開発サーバー起動
dev:
	@echo "Starting development server on http://localhost:3000/"
	flutter run -d web-server --web-port=3000

# 開発サーバー起動（閲覧モード）
dev-view:
	@echo "Building web application..."
	flutter pub get
	flutter build web --release
	@echo "Starting development server in VIEW mode"
	@echo "Access: http://localhost:3000/?mode=view"
	@echo "Password: view123"
	flutter run -d web-server --web-port=3000

# 開発サーバー起動（編集モード）
dev-edit:
	@echo "Building web application..."
	flutter pub get
	flutter build web --release
	@echo "Starting development server in EDIT mode"
	@echo "Access: http://localhost:3000/?mode=edit"
	@echo "Password: edit456"
	flutter run -d web-server --web-port=3000

# Webアプリケーションビルド
build:
	flutter pub get
	flutter build web --release

# リリース実行（バージョン更新 + ビルド + コミット + プッシュ）
release:
	@echo "Current version in pubspec.yaml:"
	@grep "^version:" pubspec.yaml
	@echo ""
	@read -p "Enter new version (e.g., 1.0.1): " version; \
	echo "Updating pubspec.yaml to version $$version..."; \
	sed -i.bak "s/^version: .*/version: $$version/" pubspec.yaml; \
	rm pubspec.yaml.bak; \
	echo "Building web application..."; \
	flutter pub get; \
	flutter build web --release; \
	echo "Creating release commit..."; \
	git add pubspec.yaml; \
	git commit -m "release: v$$version"; \
	git push origin main; \
	echo "Release v$$version pushed. GitHub Actions will deploy automatically."

# ビルド成果物削除
clean:
	flutter clean