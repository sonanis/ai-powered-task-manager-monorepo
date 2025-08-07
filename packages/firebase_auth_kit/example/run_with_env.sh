#!/bin/bash

# Firebase Auth Kit 示例启动脚本 - 支持 .env 文件
# 使用方法：
# 1. 复制 .env.example 为 .env
# 2. 在 .env 文件中填入您的实际配置
# 3. 运行此脚本

# 检查 .env 文件是否存在
if [ ! -f .env ]; then
    echo "❌ .env 文件不存在"
    echo "📝 请复制 .env.example 为 .env 并填入您的配置"
    exit 1
fi

# 加载 .env 文件
echo "📖 加载环境变量..."
source .env

# 检查必要的环境变量
required_vars=(
    "FIREBASE_WEB_API_KEY"
    "FIREBASE_PROJECT_ID"
    "GITHUB_CLIENT_ID"
)

for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ] || [ "${!var}" = "your-$var" ]; then
        echo "❌ 环境变量 $var 未设置或使用默认值"
        echo "📝 请在 .env 文件中设置正确的 $var 值"
        exit 1
    fi
done

echo "✅ 环境变量检查通过"
echo "🚀 启动 Firebase Auth Kit 示例..."

# 运行应用
flutter run -d chrome --web-port=8080 \
  --dart-define=FIREBASE_WEB_API_KEY="$FIREBASE_WEB_API_KEY" \
  --dart-define=FIREBASE_WEB_APP_ID="$FIREBASE_WEB_APP_ID" \
  --dart-define=FIREBASE_PROJECT_ID="$FIREBASE_PROJECT_ID" \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID="$FIREBASE_MESSAGING_SENDER_ID" \
  --dart-define=FIREBASE_WEB_AUTH_DOMAIN="$FIREBASE_WEB_AUTH_DOMAIN" \
  --dart-define=FIREBASE_WEB_STORAGE_BUCKET="$FIREBASE_WEB_STORAGE_BUCKET" \
  --dart-define=FIREBASE_WEB_MEASUREMENT_ID="$FIREBASE_WEB_MEASUREMENT_ID" \
  --dart-define=GITHUB_CLIENT_ID="$GITHUB_CLIENT_ID" \
  --dart-define=GITHUB_CLIENT_SECRET="$GITHUB_CLIENT_SECRET" \
  --dart-define=GITHUB_CALLBACK_URL="$GITHUB_CALLBACK_URL" \
  --dart-define=GOOGLE_WEB_CLIENT_ID="$GOOGLE_WEB_CLIENT_ID" \
  --dart-define=GOOGLE_ANDROID_CLIENT_ID="$GOOGLE_ANDROID_CLIENT_ID" \
  --dart-define=GOOGLE_IOS_CLIENT_ID="$GOOGLE_IOS_CLIENT_ID" \
  --dart-define=FACEBOOK_APP_ID="$FACEBOOK_APP_ID" \
  --dart-define=FACEBOOK_APP_SECRET="$FACEBOOK_APP_SECRET" 