#!/bin/bash

# Firebase Auth Kit 示例启动脚本
# 请根据您的实际配置修改以下变量

# Firebase 配置
export FIREBASE_API_KEY="your-api-key"
export FIREBASE_APP_ID="your-app-id"
export FIREBASE_PROJECT_ID="your-project-id"
export FIREBASE_MESSAGING_SENDER_ID="your-sender-id"
export FIREBASE_AUTH_DOMAIN="your-project-id.firebaseapp.com"
export FIREBASE_STORAGE_BUCKET="your-project-id.appspot.com"
export FIREBASE_MEASUREMENT_ID="your-measurement-id"

# GitHub OAuth 配置
export GITHUB_CLIENT_ID="your-github-client-id"
export GITHUB_CLIENT_SECRET="your-github-client-secret"

echo "🚀 启动 Firebase Auth Kit 示例..."
echo "📝 请确保已更新上述配置变量"

# 运行应用
flutter run -d chrome --web-port=8080 \
  --dart-define=FIREBASE_API_KEY="$FIREBASE_API_KEY" \
  --dart-define=FIREBASE_APP_ID="$FIREBASE_APP_ID" \
  --dart-define=FIREBASE_PROJECT_ID="$FIREBASE_PROJECT_ID" \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID="$FIREBASE_MESSAGING_SENDER_ID" \
  --dart-define=FIREBASE_AUTH_DOMAIN="$FIREBASE_AUTH_DOMAIN" \
  --dart-define=FIREBASE_STORAGE_BUCKET="$FIREBASE_STORAGE_BUCKET" \
  --dart-define=FIREBASE_MEASUREMENT_ID="$FIREBASE_MEASUREMENT_ID" \
  --dart-define=GITHUB_CLIENT_ID="$GITHUB_CLIENT_ID" \
  --dart-define=GITHUB_CLIENT_SECRET="$GITHUB_CLIENT_SECRET" 