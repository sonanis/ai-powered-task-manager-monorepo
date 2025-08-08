# Firebase Auth Kit 示例配置指南

## 3. 环境变量配置（推荐）

为了安全起见，建议使用环境变量存储敏感信息。我们提供了多种方式来设置环境变量：



### 3.1 方法一：使用 .env 文件（最推荐）

#### 3.1.1 设置环境变量文件
```bash
# 复制环境变量模板
cp env.example .env

# 编辑 .env 文件，填入您的实际配置
nano .env  # 或使用您喜欢的编辑器
```

#### 3.1.2 使用 Makefile 运行
```bash
# 设置环境变量文件
make setup

# 生产模式运行（使用 .env 文件）
make run-prod

# 开发模式运行（显示配置警告）
make run-dev
```

#### 3.1.3 使用启动脚本运行
```bash
# 确保 .env 文件存在并已配置
./run_with_env.sh
```

### 3.2 方法二：使用 --dart-define 参数

```bash
flutter run -d chrome --web-port=8080 \
  --dart-define=FIREBASE_API_KEY=your-api-key \
  --dart-define=FIREBASE_PROJECT_ID=your-project-id \
  --dart-define=GITHUB_CLIENT_ID=your-client-id \
  --dart-define=GITHUB_CLIENT_SECRET=your-client-secret
```

### 3.3 方法三：使用 VS Code 启动配置

1. 在 VS Code 中打开项目
2. 按 `F5` 或点击 "运行和调试"
3. 选择 "Firebase Auth Kit - Chrome (生产模式)"
4. 在 `launch.json` 中更新配置值

### 3.4 方法四：设置系统环境变量

#### macOS/Linux:
```bash
export FIREBASE_API_KEY="your-api-key"
export FIREBASE_PROJECT_ID="your-project-id"
export GITHUB_CLIENT_ID="your-client-id"
export GITHUB_CLIENT_SECRET="your-client-secret"

flutter run -d chrome --web-port=8080 \
  --dart-define=FIREBASE_API_KEY="$FIREBASE_API_KEY" \
  --dart-define=FIREBASE_PROJECT_ID="$FIREBASE_PROJECT_ID" \
  --dart-define=GITHUB_CLIENT_ID="$GITHUB_CLIENT_ID" \
  --dart-define=GITHUB_CLIENT_SECRET="$GITHUB_CLIENT_SECRET"
```

#### Windows (PowerShell):
```powershell
$env:FIREBASE_API_KEY="your-api-key"
$env:FIREBASE_PROJECT_ID="your-project-id"
$env:GITHUB_CLIENT_ID="your-client-id"
$env:GITHUB_CLIENT_SECRET="your-client-secret"

flutter run -d chrome --web-port=8080 `
  --dart-define=FIREBASE_API_KEY="$env:FIREBASE_API_KEY" `
  --dart-define=FIREBASE_PROJECT_ID="$env:FIREBASE_PROJECT_ID" `
  --dart-define=GITHUB_CLIENT_ID="$env:GITHUB_CLIENT_ID" `
  --dart-define=GITHUB_CLIENT_SECRET="$env:GITHUB_CLIENT_SECRET"
```

## 4. 测试步骤

1. 确保所有配置正确
2. 运行 `flutter pub get`
3. 启动应用：`flutter run -d chrome`
4. 点击 "Firebase GitHub 认证示例"
5. 测试 GitHub 登录功能

## 5. 常见问题

### 5.1 API Key 无效
- 检查 Firebase 项目配置是否正确
- 确保 Web 应用已正确注册

### 5.2 GitHub 登录失败
- 检查 GitHub OAuth 应用的回调 URL 是否正确
- 确保 Client ID 和 Client Secret 正确
- 检查 Firebase Console 中的 GitHub 认证是否已启用

### 5.3 跨域问题
- 确保 GitHub OAuth 应用的 Homepage URL 和 Authorization callback URL 正确
- 检查 Firebase Hosting 配置（如果使用）

## 6. 安全注意事项

1. **不要提交敏感信息到版本控制**
   - 使用环境变量或配置文件
   - 将包含敏感信息的文件添加到 `.gitignore`

2. **生产环境配置**
   - 使用 HTTPS
   - 配置正确的域名
   - 设置适当的 CORS 策略

3. **定期轮换密钥**
   - 定期更新 GitHub Client Secret
   - 监控应用使用情况 