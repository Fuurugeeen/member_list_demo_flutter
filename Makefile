.PHONY: help dev build release clean

# デフォルトターゲット
help:
	@echo "Available commands:"
	@echo "  make dev     - Start development server"
	@echo "  make build   - Build web application"
	@echo "  make release - Create release commit and deploy"
	@echo "  make clean   - Clean build artifacts"
	@echo ""
	@echo "Documentation update rules:"
	@echo "  - Screen layout changes: Update docs/wireframes.md"
	@echo "  - New features: Add new sections to wireframes"
	@echo "  - Flow changes: Update user flow diagrams"
	@echo "  - Always record change reason and date in update history"

# 開発サーバー起動
dev:
	flutter run -d web-server

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