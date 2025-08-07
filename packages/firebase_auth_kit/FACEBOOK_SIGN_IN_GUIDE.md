# Facebook 登录集成指南 / Facebook Sign-In Integration Guide

## 📋 概述 / Overview

本指南将帮助你在 Flutter 应用中集成 Facebook 登录功能，使用 Firebase Auth Kit 库。

This guide will help you integrate Facebook sign-in functionality in your Flutter app using the Firebase Auth Kit library.

## 🚀 快速开始 / Quick Start

### 1. 添加依赖 / Add Dependencies

在你的 `pubspec.yaml` 文件中添加以下依赖：

Add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  firebase_auth_kit: ^0.0.1
  flutter_facebook_auth: ^6.1.1
  firebase_auth: ^4.15.3
  firebase_core: ^2.24.2
```

### 2. 配置 Firebase / Configure Firebase

1. 在 Firebase Console 中创建项目
2. 启用 Facebook 登录方式
3. 配置 Facebook App ID 和 App Secret

### 3. 配置 Facebook 应用 / Configure Facebook App

1. 在 [Facebook Developers](https://developers.facebook.com/) 创建应用
2. 获取 App ID 和 App Secret
3. 配置 OAuth 重定向 URI

### 4. 实现 Facebook 登录 / Implement Facebook Sign-In

#### 4.1 创建 Facebook 登录提供者 / Create Facebook Sign-In Provider

```dart
import 'package:firebase_auth_kit/firebase_auth_kit.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class MyFacebookSignInProvider implements FacebookSignInProvider {
  @override
  Future<FacebookSignInAccount?> signIn() async {
    try {
      // 执行 Facebook 登录
      final result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );
      
      if (result.status == LoginStatus.success) {
        // 获取用户信息
        final userData = await FacebookAuth.instance.getUserData(
          fields: 'id,name,email,picture.width(200)',
        );
        
        return FacebookSignInAccount(
          id: userData['id'] as String,
          email: userData['email'] as String?,
          displayName: userData['name'] as String?,
          photoUrl: userData['picture']?['data']?['url'] as String?,
          accessToken: result.accessToken?.token,
          permissions: result.accessToken?.permissions ?? [],
          userData: userData,
        );
      }
      
      return null;
    } catch (e) {
      print('Facebook 登录失败: $e');
      return null;
    }
  }

  @override
  Future<FacebookSignInAccount?> signInSilently() async {
    try {
      if (await isSignedIn()) {
        return await getCurrentUser();
      }
      return null;
    } catch (e) {
      print('Facebook 静默登录失败: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FacebookAuth.instance.logOut();
    } catch (e) {
      print('Facebook 退出登录失败: $e');
    }
  }

  @override
  Future<FacebookSignInAccount?> getCurrentUser() async {
    try {
      if (!await isSignedIn()) {
        return null;
      }
      
      final userData = await FacebookAuth.instance.getUserData(
        fields: 'id,name,email,picture.width(200)',
      );
      
      return FacebookSignInAccount(
        id: userData['id'] as String,
        email: userData['email'] as String?,
        displayName: userData['name'] as String?,
        photoUrl: userData['picture']?['data']?['url'] as String?,
        userData: userData,
      );
    } catch (e) {
      print('获取 Facebook 当前用户失败: $e');
      return null;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      return await FacebookAuth.instance.isLoggedIn;
    } catch (e) {
      print('检查 Facebook 登录状态失败: $e');
      return false;
    }
  }

  @override
  Future<List<String>> getPermissions() async {
    try {
      if (!await isSignedIn()) {
        return [];
      }
      
      final result = await FacebookAuth.instance.getUserData();
      return result['permissions'] as List<String>? ?? [];
    } catch (e) {
      print('获取 Facebook 权限失败: $e');
      return [];
    }
  }

  @override
  Future<bool> requestPermissions(List<String> permissions) async {
    try {
      final result = await FacebookAuth.instance.login(
        permissions: permissions,
      );
      
      return result.status == LoginStatus.success;
    } catch (e) {
      print('请求 Facebook 权限失败: $e');
      return false;
    }
  }
}
```

#### 4.2 初始化 Firebase Auth Kit / Initialize Firebase Auth Kit

```dart
import 'package:firebase_auth_kit/firebase_auth_kit.dart';

Future<void> initializeAuth() async {
  // 配置 Firebase Auth
  await FirebaseAuthService.initialize(
    config: FirebaseAuthConfig(
      facebook: FacebookAuthConfig(
        isEnabled: true,
        appId: 'your_facebook_app_id',
        appSecret: 'your_facebook_app_secret',
        clientToken: 'your_client_token',
      ),
    ),
  );

  // 设置 Facebook 登录提供者
  final authService = FirebaseAuthService.instance;
  authService.setFacebookProvider(
    MyFacebookSignInProvider(),
  );
}
```

#### 4.3 执行 Facebook 登录 / Perform Facebook Sign-In

```dart
Future<void> signInWithFacebook() async {
  try {
    final authService = FirebaseAuthService.instance;
    final userCredential = await authService.signInWithFacebook(
      config: FacebookAuthConfig(
        isEnabled: true,
        appId: 'your_facebook_app_id',
        appSecret: 'your_facebook_app_secret',
        clientToken: 'your_client_token',
      ),
    );

    if (userCredential != null) {
      print('登录成功: ${userCredential.user?.email}');
    } else {
      print('登录取消');
    }
  } catch (e) {
    print('登录失败: $e');
  }
}
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

## 🔧 高级配置 / Advanced Configuration

### 自定义权限 / Custom Permissions

```dart
// 请求额外权限
final provider = MyFacebookSignInProvider();
final success = await provider.requestPermissions([
  'email',
  'public_profile',
  'user_friends',
  'user_posts',
]);
```

### 错误处理 / Error Handling

```dart
try {
  final userCredential = await authService.signInWithFacebook(config: config);
  // 处理成功登录
} on FirebaseAuthException catch (e) {
  switch (e.code) {
    case 'account-exists-with-different-credential':
      // 处理账户冲突
      break;
    case 'invalid-credential':
      // 处理无效凭据
      break;
    case 'operation-not-allowed':
      // 处理操作不允许
      break;
    case 'user-disabled':
      // 处理用户被禁用
      break;
    case 'user-not-found':
      // 处理用户不存在
      break;
    case 'weak-password':
      // 处理弱密码
      break;
    default:
      // 处理其他错误
      break;
  }
}
```

## 🧪 测试 / Testing

### 单元测试 / Unit Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_kit/firebase_auth_kit.dart';

void main() {
  group('Facebook Sign-In Tests', () {
    test('should create Facebook provider', () {
      final provider = MyFacebookSignInProvider();
      expect(provider, isA<FacebookSignInProvider>());
    });

    test('should handle sign-in failure', () async {
      final provider = MockFacebookSignInProvider();
      final result = await provider.signIn();
      expect(result, isNull);
    });
  });
}
```

## 📚 参考资源 / References

- [Facebook Developers Documentation](https://developers.facebook.com/docs/facebook-login/)
- [Flutter Facebook Auth Plugin](https://pub.dev/packages/flutter_facebook_auth)
- [Firebase Auth Documentation](https://firebase.google.com/docs/auth)

## 🤝 贡献 / Contributing

如果你发现任何问题或有改进建议，请提交 Issue 或 Pull Request。

If you find any issues or have suggestions for improvements, please submit an Issue or Pull Request.

## 📄 许可证 / License

本项目采用 MIT 许可证。

This project is licensed under the MIT License. 