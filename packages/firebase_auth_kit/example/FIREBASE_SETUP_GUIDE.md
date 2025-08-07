# Firebase Auth Kit 示例配置指南

## 1. Firebase 项目设置

### 1.1 创建 Firebase 项目
1. 访问 [Firebase Console](https://console.firebase.google.com/)
2. 点击 "创建项目" 或 "Add project"
3. 输入项目名称（例如：`firebase-auth-kit-demo`）
4. 选择是否启用 Google Analytics（可选）
5. 完成项目创建

### 1.2 添加 Web 应用
1. 在项目概览页面，点击 "Web" 图标 (`</>`)
2. 输入应用昵称（例如：`firebase-auth-kit-web`）
3. 选择是否启用 Firebase Hosting（可选）
4. 点击 "注册应用"
5. 复制配置信息（apiKey, authDomain, projectId 等）

### 1.3 启用 GitHub 认证
1. 在 Firebase Console 中，进入 "Authentication" > "Sign-in method"
2. 找到 "GitHub" 并点击启用
3. 输入 GitHub OAuth 应用的 Client ID 和 Client Secret
4. 保存设置

## 2. GitHub OAuth 应用设置

### 2.1 创建 GitHub OAuth 应用
1. 访问 [GitHub Developer Settings](https://github.com/settings/developers)
2. 点击 "OAuth Apps" > "New OAuth App"
3. 填写应用信息：
   - **Application name**: `Firebase Auth Kit Demo`
   - **Homepage URL**: `http://localhost:8080` (开发环境)
   - **Authorization callback URL**: `http://localhost:8080/__/auth/handler` (开发环境)
4. 点击 "Register application"
5. 复制 Client ID 和 Client Secret

### 2.2 生产环境配置
对于生产环境，需要更新以下 URL：
- **Homepage URL**: `https://your-domain.com`
- **Authorization callback URL**: `https://your-domain.com/__/auth/handler`

## 3. 配置文件更新

### 3.1 更新 Firebase 配置
编辑 `lib/firebase_options.dart` 文件，替换为您的实际配置：

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'your-actual-api-key',
  appId: 'your-actual-app-id',
  messagingSenderId: 'your-actual-sender-id',
  projectId: 'your-actual-project-id',
  authDomain: 'your-actual-project-id.firebaseapp.com',
  storageBucket: 'your-actual-project-id.appspot.com',
  measurementId: 'your-actual-measurement-id',
);
```

### 3.2 更新 GitHub OAuth 配置
编辑 `lib/firebase_github_sign_in_provider.dart` 文件，在 `initialize()` 方法中添加：

```dart
// 设置 GitHub OAuth 配置
_githubProvider.setCustomParameters({
  'client_id': 'your-github-client-id',
  'client_secret': 'your-github-client-secret',
});
```

## 4. 环境变量配置（推荐）

为了安全起见，建议使用环境变量存储敏感信息。我们提供了多种方式来设置环境变量：

### 4.1 方法一：使用 .env 文件（最推荐）

#### 4.1.1 设置环境变量文件
```bash
# 复制环境变量模板
cp env.example .env

# 编辑 .env 文件，填入您的实际配置
nano .env  # 或使用您喜欢的编辑器
```

#### 4.1.2 使用 Makefile 运行
```bash
# 设置环境变量文件
make setup

# 生产模式运行（使用 .env 文件）
make run-prod

# 开发模式运行（显示配置警告）
make run-dev
```

#### 4.1.3 使用启动脚本运行
```bash
# 确保 .env 文件存在并已配置
./run_with_env.sh
```

### 4.2 方法二：使用 --dart-define 参数

```bash
flutter run -d chrome --web-port=8080 \
  --dart-define=FIREBASE_API_KEY=your-api-key \
  --dart-define=FIREBASE_PROJECT_ID=your-project-id \
  --dart-define=GITHUB_CLIENT_ID=your-client-id \
  --dart-define=GITHUB_CLIENT_SECRET=your-client-secret
```

### 4.3 方法三：使用 VS Code 启动配置

1. 在 VS Code 中打开项目
2. 按 `F5` 或点击 "运行和调试"
3. 选择 "Firebase Auth Kit - Chrome (生产模式)"
4. 在 `launch.json` 中更新配置值

### 4.4 方法四：设置系统环境变量

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

## 5. 测试步骤

1. 确保所有配置正确
2. 运行 `flutter pub get`
3. 启动应用：`flutter run -d chrome`
4. 点击 "Firebase GitHub 认证示例"
5. 测试 GitHub 登录功能

## 6. 常见问题

### 6.1 API Key 无效
- 检查 Firebase 项目配置是否正确
- 确保 Web 应用已正确注册

### 6.2 GitHub 登录失败
- 检查 GitHub OAuth 应用的回调 URL 是否正确
- 确保 Client ID 和 Client Secret 正确
- 检查 Firebase Console 中的 GitHub 认证是否已启用

### 6.3 跨域问题
- 确保 GitHub OAuth 应用的 Homepage URL 和 Authorization callback URL 正确
- 检查 Firebase Hosting 配置（如果使用）

## 7. 安全注意事项

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