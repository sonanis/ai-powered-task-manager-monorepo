# Firebase Auth Kit

一个功能强大的Flutter Firebase认证库，支持多种登录平台和配置管理。

## 🚀 特性

- ✅ **多平台支持**：Google、Facebook、Apple、Twitter、GitHub、Microsoft、Yahoo、LinkedIn
- ✅ **传统登录**：邮箱密码、手机号验证码、匿名登录
- ✅ **企业级认证**：SAML、OIDC
- ✅ **类型安全**：使用Freezed实现不可变数据类
- ✅ **配置管理**：统一的配置管理和验证
- ✅ **跨平台**：支持Android、iOS、Web

## 📦 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  firebase_auth_kit:
    path: ../firebase_auth_kit
  firebase_core: ^2.27.1
  firebase_auth: ^4.17.9
```

## 🔧 配置

### 1. 基础配置

```dart
import 'package:firebase_auth_kit/firebase_auth_kit.dart';

// 创建配置
final config = FirebaseAuthConfig(
  google: GoogleAuthConfig(
    isEnabled: true,
    webClientId: 'your-google-web-client-id.apps.googleusercontent.com',
    iosClientId: 'your-google-ios-client-id.apps.googleusercontent.com',
    androidClientId: 'your-google-android-client-id.apps.googleusercontent.com',
  ),
  
  facebook: FacebookAuthConfig(
    isEnabled: true,
    appId: 'your-facebook-app-id',
    appSecret: 'your-facebook-app-secret',
    permissions: ['email', 'public_profile'],
  ),
  
  github: GitHubAuthConfig(
    isEnabled: true,
    clientId: 'your-github-client-id',
    clientSecret: 'your-github-client-secret',
    redirectUri: 'your-github-callback-url',
    scopes: ['read:user', 'user:email'],
  ),
  
  emailPassword: EmailPasswordAuthConfig(
    isEnabled: true,
    allowSignUp: true,
    allowPasswordReset: true,
    requireEmailVerification: false,
  ),
);

// 初始化 Firebase Auth Kit
await FirebaseAuthKit.initialize(config: config);
```

### 2. 使用配置管理器

```dart
// 创建配置管理器
final configManager = AuthConfigManager(config);

// 验证配置
if (configManager.validateConfig()) {
  print('配置验证通过');
} else {
  print('配置验证失败');
}

// 获取启用的平台
final enabledPlatforms = configManager.enabledPlatforms;
print('启用的平台: $enabledPlatforms');

// 检查特定平台是否启用
if (configManager.isPlatformEnabled('google')) {
  print('Google登录已启用');
}

// 获取特定平台配置
final googleConfig = configManager.getPlatformConfig<GoogleAuthConfig>();
```

### 3. 在应用中使用

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化 Firebase Core
  await Firebase.initializeApp();
  
  // 创建认证配置
  final authConfig = FirebaseAuthConfig(
    google: GoogleAuthConfig(
      isEnabled: true,
      webClientId: 'your-web-client-id',
    ),
    emailPassword: EmailPasswordAuthConfig(
      isEnabled: true,
      allowSignUp: true,
    ),
  );
  
  // 初始化 Firebase Auth Kit
  await FirebaseAuthKit.initialize(config: authConfig);
  
  runApp(MyApp());
}
```

## 🔐 支持的平台

### 社交登录平台

| 平台 | 配置类 | 必需参数 | 可选参数 |
|------|--------|----------|----------|
| Google | `GoogleAuthConfig` | `webClientId` | `iosClientId`, `androidClientId`, `serverClientId` |
| Facebook | `FacebookAuthConfig` | `appId`, `appSecret` | `permissions`, `redirectUri` |
| Apple | `AppleAuthConfig` | `serviceId`, `teamId`, `keyId` | `privateKey`, `scopes` |
| Twitter | `TwitterAuthConfig` | `apiKey`, `apiSecret` | `redirectUri` |
| GitHub | `GitHubAuthConfig` | `clientId`, `clientSecret` | `scopes`, `redirectUri` |
| Microsoft | `MicrosoftAuthConfig` | `clientId`, `clientSecret` | `tenantId`, `scopes` |
| Yahoo | `YahooAuthConfig` | `clientId`, `clientSecret` | `redirectUri` |
| LinkedIn | `LinkedInAuthConfig` | `clientId`, `clientSecret` | `scopes`, `redirectUri` |

### 传统登录方式

| 方式 | 配置类 | 配置选项 |
|------|--------|----------|
| 邮箱密码 | `EmailPasswordAuthConfig` | 注册、密码重置、邮箱验证 |
| 手机号 | `PhoneAuthConfig` | 验证码超时、长度、国家代码 |
| 匿名登录 | `AnonymousAuthConfig` | 启用/禁用 |

### 企业级认证

| 方式 | 配置类 | 必需参数 |
|------|--------|----------|
| SAML | `SAMLAuthConfig` | `providerId`, `entityId`, `ssoUrl`, `x509Certificate` |
| OIDC | `OIDCAuthConfig` | `providerId`, `clientId`, `issuer` |

## 📋 配置示例

### 开发环境配置

```dart
final devConfig = AuthConfigExample.developmentConfig;
```

### 生产环境配置

```dart
final prodConfig = AuthConfigExample.productionConfig;
```

### 最小配置

```dart
final minimalConfig = AuthConfigExample.minimalConfig;
```

## 🔑 获取平台配置参数

### Google登录

1. 访问 [Google Cloud Console](https://console.cloud.google.com/)
2. 创建或选择项目
3. 启用 Google+ API
4. 在"凭据"页面创建OAuth 2.0客户端ID
5. 为不同平台创建客户端ID

### Facebook登录

1. 访问 [Facebook Developers](https://developers.facebook.com/)
2. 创建应用
3. 获取App ID和App Secret
4. 配置OAuth重定向URI
5. 在Firebase控制台配置Facebook登录提供商

### Apple登录

1. 访问 [Apple Developer](https://developer.apple.com/)
2. 创建App ID并启用Sign In with Apple
3. 创建Service ID
4. 生成私钥并获取Key ID
5. 在Firebase控制台配置Apple登录提供商

## ⚠️ 安全注意事项

1. **不要在代码中硬编码敏感信息**（如clientSecret）
2. **使用环境变量或安全的配置管理系统**
3. **定期轮换密钥和令牌**
4. **在生产环境中启用HTTPS**
5. **实施适当的错误处理和日志记录**
6. **遵循各平台的安全最佳实践**

## 🛠️ 开发

### 运行代码生成

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 运行测试

```bash
flutter test
```

## 📄 许可证

MIT License

## 🤝 贡献

欢迎提交Issue和Pull Request！

---

**作者**: Er.Lin - Flutter工程师，9年Android开发经验，4年Flutter经验
