# Facebook 登录示例 / Facebook Sign-In Example

本示例展示了如何在 Flutter 应用中使用 `firebase_auth_kit` 实现 Facebook 登录功能。

This example demonstrates how to implement Facebook sign-in functionality in a Flutter app using `firebase_auth_kit`.

## 🚀 快速开始 / Quick Start

### 1. 运行示例 / Run the Example

```bash
cd example
flutter pub get
flutter run -t facebook_main.dart
```

### 2. 配置 Facebook 应用 / Configure Facebook App

在运行示例之前，你需要配置 Facebook 应用：

Before running the example, you need to configure your Facebook app:

#### 2.1 创建 Facebook 应用 / Create Facebook App

1. 访问 [Facebook Developers](https://developers.facebook.com/)
2. 创建新应用或选择现有应用
3. 获取 App ID 和 App Secret

#### 2.2 配置 Firebase / Configure Firebase

1. 在 Firebase Console 中启用 Facebook 登录
2. 添加 Facebook App ID 和 App Secret
3. 配置 OAuth 重定向 URI

#### 2.3 更新示例代码 / Update Example Code

在 `facebook_main.dart` 中替换配置：

Replace the configuration in `facebook_main.dart`:

```dart
final FirebaseAuthConfig _config = FirebaseAuthConfig(
  facebook: FacebookAuthConfig(
    isEnabled: true,
    appId: 'your_facebook_app_id', // 替换为你的 Facebook App ID
    appSecret: 'your_facebook_app_secret', // 替换为你的 Facebook App Secret
    permissions: ['email', 'public_profile'],
  ),
  anonymous: AnonymousAuthConfig(isEnabled: true),
);
```

## 📱 平台配置 / Platform Configuration

### Android 配置 / Android Configuration

在 `android/app/src/main/res/values/strings.xml` 中添加：

Add to `android/app/src/main/res/values/strings.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="facebook_app_id">your_facebook_app_id</string>
    <string name="fb_login_protocol_scheme">fbYourAppId</string>
    <string name="facebook_client_token">your_client_token</string>
</resources>
```

在 `android/app/src/main/AndroidManifest.xml` 中添加：

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<application>
    <!-- Facebook 配置 -->
    <meta-data
        android:name="com.facebook.sdk.ApplicationId"
        android:value="@string/facebook_app_id"/>
    <meta-data
        android:name="com.facebook.sdk.ClientToken"
        android:value="@string/facebook_client_token"/>
</application>
```

### iOS 配置 / iOS Configuration

在 `ios/Runner/Info.plist` 中添加：

Add to `ios/Runner/Info.plist`:

```xml
<key>FacebookAppID</key>
<string>your_facebook_app_id</string>
<key>FacebookClientToken</key>
<string>your_client_token</string>
<key>FacebookDisplayName</key>
<string>Your App Name</string>
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>facebook</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>fbYourAppId</string>
        </array>
    </dict>
</array>
```

### Web 配置 / Web Configuration

在 `web/index.html` 中添加 Facebook SDK：

Add Facebook SDK to `web/index.html`:

```html
<head>
  <!-- Facebook SDK -->
  <script async defer crossorigin="anonymous" 
    src="https://connect.facebook.net/en_US/sdk.js">
  </script>
</head>
```

## 🔧 功能特性 / Features

### 已实现功能 / Implemented Features

- ✅ **Facebook 登录**：使用 Facebook 账户登录
- ✅ **静默登录**：检查并恢复之前的登录状态
- ✅ **匿名登录**：使用匿名账户登录
- ✅ **权限管理**：获取和请求用户权限
- ✅ **用户信息显示**：显示登录用户的详细信息
- ✅ **退出登录**：完全退出 Facebook 和 Firebase 登录

### UI 特性 / UI Features

- 🎨 **Material Design 3**：现代化的 UI 设计
- 📱 **响应式布局**：适配不同屏幕尺寸
- 🌈 **主题支持**：支持亮色和暗色主题
- 🔄 **状态反馈**：实时显示操作状态
- 📊 **用户信息卡片**：美观的用户信息展示

## 🛠️ 技术实现 / Technical Implementation

### 架构设计 / Architecture

1. **依赖注入模式**：使用 `FacebookSignInProvider` 接口
2. **配置管理**：统一的 Facebook 配置管理
3. **错误处理**：完善的错误处理和用户反馈
4. **状态管理**：使用 `setState` 管理 UI 状态

### 核心组件 / Core Components

- `MyFacebookSignInProvider`：Facebook 登录提供者实现
- `FacebookSignInDemoPage`：主演示页面
- `FirebaseAuthConfig`：Firebase 认证配置

## 🧪 测试 / Testing

### 运行测试 / Run Tests

```bash
flutter test
```

### 测试覆盖 / Test Coverage

- ✅ 单元测试：Facebook 登录提供者测试
- ✅ 集成测试：Firebase 认证集成测试
- ✅ Widget 测试：UI 组件测试

## 📚 相关文档 / Related Documentation

- [Firebase Auth Kit 文档](../README.md)
- [Facebook 登录集成指南](../FACEBOOK_SIGN_IN_GUIDE.md)
- [Flutter Facebook Auth 插件](https://pub.dev/packages/flutter_facebook_auth)

## 🤝 贡献 / Contributing

欢迎提交 Issue 和 Pull Request！

Feel free to submit issues and pull requests!

## 📄 许可证 / License

MIT License

---

**作者**: Er.Lin - Flutter工程师，9年Android开发经验，4年Flutter经验 