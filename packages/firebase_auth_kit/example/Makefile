# Firebase Auth Kit 示例 Makefile
# 提供便捷的环境变量管理命令

.PHONY: help setup run-dev run-prod clean

# 默认目标
help:
	@echo "Firebase Auth Kit 示例 - 可用命令："
	@echo ""
	@echo "  setup      - 设置环境变量文件"
	@echo "  run-dev    - 开发模式运行（显示配置警告）"
	@echo "  run-prod   - Web 平台生产模式运行"
	@echo "  run-android - Android 平台运行"
	@echo "  run-ios    - iOS 平台运行"
	@echo "  run-macos  - macOS 平台运行"
	@echo "  run-windows - Windows 平台运行"
	@echo "  clean      - 清理构建文件"
	@echo "  help       - 显示此帮助信息"

# 设置环境变量文件
setup:
	@echo "📝 设置环境变量文件..."
	@if [ ! -f .env ]; then \
		cp env.example .env; \
		echo "✅ 已创建 .env 文件，请编辑并填入您的配置"; \
	else \
		echo "⚠️  .env 文件已存在"; \
	fi

# 开发模式运行
run-dev:
	@echo "🚀 开发模式运行..."
	flutter run -d chrome --web-port=8080

# 生产模式运行（使用环境变量）
run-prod:
	@echo "🚀 生产模式运行..."
	@if [ ! -f .env ]; then \
		echo "❌ .env 文件不存在，请先运行 'make setup'"; \
		exit 1; \
	fi
	@source .env && flutter run -d chrome --web-port=8080 \
		--dart-define=FIREBASE_WEB_API_KEY="$$FIREBASE_WEB_API_KEY" \
		--dart-define=FIREBASE_WEB_APP_ID="$$FIREBASE_WEB_APP_ID" \
		--dart-define=FIREBASE_PROJECT_ID="$$FIREBASE_PROJECT_ID" \
		--dart-define=FIREBASE_MESSAGING_SENDER_ID="$$FIREBASE_MESSAGING_SENDER_ID" \
		--dart-define=FIREBASE_WEB_AUTH_DOMAIN="$$FIREBASE_WEB_AUTH_DOMAIN" \
		--dart-define=FIREBASE_WEB_STORAGE_BUCKET="$$FIREBASE_WEB_STORAGE_BUCKET" \
		--dart-define=FIREBASE_WEB_MEASUREMENT_ID="$$FIREBASE_WEB_MEASUREMENT_ID" \
		--dart-define=GITHUB_CLIENT_ID="$$GITHUB_CLIENT_ID" \
		--dart-define=GITHUB_CLIENT_SECRET="$$GITHUB_CLIENT_SECRET" \
		--dart-define=GITHUB_CALLBACK_URL="$$GITHUB_CALLBACK_URL" \
		--dart-define=GOOGLE_WEB_CLIENT_ID="$$GOOGLE_WEB_CLIENT_ID" \
		--dart-define=GOOGLE_ANDROID_CLIENT_ID="$$GOOGLE_ANDROID_CLIENT_ID" \
		--dart-define=GOOGLE_IOS_CLIENT_ID="$$GOOGLE_IOS_CLIENT_ID" \
			--dart-define=FACEBOOK_APP_ID="$$FACEBOOK_APP_ID" \
		--dart-define=FACEBOOK_APP_SECRET="$$FACEBOOK_APP_SECRET" \
		--dart-define=FACEBOOK_APP_ID="$$FACEBOOK_APP_ID" \
		--dart-define=FACEBOOK_APP_SECRET="$$FACEBOOK_APP_SECRET"

# Android 平台运行
run-android:
	@echo "🚀 Android 平台运行..."
	@if [ ! -f .env ]; then \
		echo "❌ .env 文件不存在，请先运行 'make setup'"; \
		exit 1; \
	fi
	@source .env && flutter run -d android \
		--dart-define=FIREBASE_ANDROID_API_KEY="$$FIREBASE_ANDROID_API_KEY" \
		--dart-define=FIREBASE_ANDROID_APP_ID="$$FIREBASE_ANDROID_APP_ID" \
		--dart-define=FIREBASE_PROJECT_ID="$$FIREBASE_PROJECT_ID" \
		--dart-define=FIREBASE_MESSAGING_SENDER_ID="$$FIREBASE_MESSAGING_SENDER_ID" \
		--dart-define=FIREBASE_ANDROID_STORAGE_BUCKET="$$FIREBASE_ANDROID_STORAGE_BUCKET" \
		--dart-define=GITHUB_CLIENT_ID="$$GITHUB_CLIENT_ID" \
		--dart-define=GITHUB_CLIENT_SECRET="$$GITHUB_CLIENT_SECRET" \
		--dart-define=GITHUB_CALLBACK_URL="$$GITHUB_CALLBACK_URL" \
		--dart-define=GOOGLE_WEB_CLIENT_ID="$$GOOGLE_WEB_CLIENT_ID" \
		--dart-define=GOOGLE_ANDROID_CLIENT_ID="$$GOOGLE_ANDROID_CLIENT_ID" \
		--dart-define=GOOGLE_IOS_CLIENT_ID="$$GOOGLE_IOS_CLIENT_ID" \
			--dart-define=FACEBOOK_APP_ID="$$FACEBOOK_APP_ID" \
		--dart-define=FACEBOOK_APP_SECRET="$$FACEBOOK_APP_SECRET"

# iOS 平台运行
run-ios:
	@echo "🚀 iOS 平台运行..."
	@if [ ! -f .env ]; then \
		echo "❌ .env 文件不存在，请先运行 'make setup'"; \
		exit 1; \
	fi
	@source .env && flutter run -d ios \
		--dart-define=FIREBASE_IOS_API_KEY="$$FIREBASE_IOS_API_KEY" \
		--dart-define=FIREBASE_IOS_APP_ID="$$FIREBASE_IOS_APP_ID" \
		--dart-define=FIREBASE_PROJECT_ID="$$FIREBASE_PROJECT_ID" \
		--dart-define=FIREBASE_MESSAGING_SENDER_ID="$$FIREBASE_MESSAGING_SENDER_ID" \
		--dart-define=FIREBASE_IOS_STORAGE_BUCKET="$$FIREBASE_IOS_STORAGE_BUCKET" \
		--dart-define=GITHUB_CLIENT_ID="$$GITHUB_CLIENT_ID" \
		--dart-define=GITHUB_CLIENT_SECRET="$$GITHUB_CLIENT_SECRET" \
		--dart-define=GITHUB_CALLBACK_URL="$$GITHUB_CALLBACK_URL" \
		--dart-define=GOOGLE_WEB_CLIENT_ID="$$GOOGLE_WEB_CLIENT_ID" \
		--dart-define=GOOGLE_ANDROID_CLIENT_ID="$$GOOGLE_ANDROID_CLIENT_ID" \
		--dart-define=GOOGLE_IOS_CLIENT_ID="$$GOOGLE_IOS_CLIENT_ID" \
			--dart-define=FACEBOOK_APP_ID="$$FACEBOOK_APP_ID" \
		--dart-define=FACEBOOK_APP_SECRET="$$FACEBOOK_APP_SECRET"

# macOS 平台运行
run-macos:
	@echo "🚀 macOS 平台运行..."
	@if [ ! -f .env ]; then \
		echo "❌ .env 文件不存在，请先运行 'make setup'"; \
		exit 1; \
	fi
	@source .env && flutter run -d macos \
		--dart-define=FIREBASE_MACOS_API_KEY="$$FIREBASE_MACOS_API_KEY" \
		--dart-define=FIREBASE_MACOS_APP_ID="$$FIREBASE_MACOS_APP_ID" \
		--dart-define=FIREBASE_PROJECT_ID="$$FIREBASE_PROJECT_ID" \
		--dart-define=FIREBASE_MESSAGING_SENDER_ID="$$FIREBASE_MESSAGING_SENDER_ID" \
		--dart-define=FIREBASE_MACOS_STORAGE_BUCKET="$$FIREBASE_MACOS_STORAGE_BUCKET" \
		--dart-define=GITHUB_CLIENT_ID="$$GITHUB_CLIENT_ID" \
		--dart-define=GITHUB_CLIENT_SECRET="$$GITHUB_CLIENT_SECRET" \
		--dart-define=GITHUB_CALLBACK_URL="$$GITHUB_CALLBACK_URL" \
		--dart-define=GOOGLE_WEB_CLIENT_ID="$$GOOGLE_WEB_CLIENT_ID" \
		--dart-define=GOOGLE_ANDROID_CLIENT_ID="$$GOOGLE_ANDROID_CLIENT_ID" \
		--dart-define=GOOGLE_IOS_CLIENT_ID="$$GOOGLE_IOS_CLIENT_ID" \
			--dart-define=FACEBOOK_APP_ID="$$FACEBOOK_APP_ID" \
		--dart-define=FACEBOOK_APP_SECRET="$$FACEBOOK_APP_SECRET"

# Windows 平台运行
run-windows:
	@echo "🚀 Windows 平台运行..."
	@if [ ! -f .env ]; then \
		echo "❌ .env 文件不存在，请先运行 'make setup'"; \
		exit 1; \
	fi
	@source .env && flutter run -d windows \
		--dart-define=FIREBASE_WINDOWS_API_KEY="$$FIREBASE_WINDOWS_API_KEY" \
		--dart-define=FIREBASE_WINDOWS_APP_ID="$$FIREBASE_WINDOWS_APP_ID" \
		--dart-define=FIREBASE_PROJECT_ID="$$FIREBASE_PROJECT_ID" \
		--dart-define=FIREBASE_MESSAGING_SENDER_ID="$$FIREBASE_MESSAGING_SENDER_ID" \
		--dart-define=FIREBASE_WINDOWS_STORAGE_BUCKET="$$FIREBASE_WINDOWS_STORAGE_BUCKET" \
		--dart-define=GITHUB_CLIENT_ID="$$GITHUB_CLIENT_ID" \
		--dart-define=GITHUB_CLIENT_SECRET="$$GITHUB_CLIENT_SECRET" \
		--dart-define=GITHUB_CALLBACK_URL="$$GITHUB_CALLBACK_URL" \
		--dart-define=GOOGLE_WEB_CLIENT_ID="$$GOOGLE_WEB_CLIENT_ID" \
		--dart-define=GOOGLE_ANDROID_CLIENT_ID="$$GOOGLE_ANDROID_CLIENT_ID" \
		--dart-define=GOOGLE_IOS_CLIENT_ID="$$GOOGLE_IOS_CLIENT_ID" \
			--dart-define=FACEBOOK_APP_ID="$$FACEBOOK_APP_ID" \
		--dart-define=FACEBOOK_APP_SECRET="$$FACEBOOK_APP_SECRET"

# 清理构建文件
clean:
	@echo "🧹 清理构建文件..."
	flutter clean
	flutter pub get 