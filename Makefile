.PHONY: help dev dev-view dev-edit build release clean

# デフォルトターゲット
help:
	@echo "Available commands:"
	@echo "  make dev       - Start development server (default mode)"
	@echo "  make dev-view  - Start development server in view mode"
	@echo "  make dev-edit  - Start development server in edit mode"
	@echo "  make build     - Build web application"
	@echo "  make release   - Create release commit and deploy"
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
	@echo "Starting development server in VIEW mode"
	@echo "Access: http://localhost:3000/?mode=view"
	@echo "Password: view123"
	flutter run -d web-server --web-port=3000

# 開発サーバー起動（編集モード）
dev-edit:
	@echo "Starting development server in EDIT mode"
	@echo "Access: http://localhost:3000/?mode=edit"
	@echo "Password: edit456"
	flutter run -d web-server --web-port=3000

# Webアプリケーションビルド
build:
	flutter pub get
	flutter build web --release

# リリース実行（空コミット + プッシュ）
release:
	@echo "Creating release commit..."
	@read -p "Enter release version (e.g., v1.0.0): " version; \
	git commit --allow-empty -m "release: $$version"; \
	git push origin main
	@echo "Release commit pushed. GitHub Actions will deploy automatically."

# ビルド成果物削除
clean:
	flutter clean