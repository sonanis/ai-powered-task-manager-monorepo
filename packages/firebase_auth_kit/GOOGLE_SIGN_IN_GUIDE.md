# Google 登录集成指南

## 📋 概述

Firebase Auth Kit 采用依赖注入的方式实现 Google 登录，让您可以灵活选择 Google 登录的实现方式。

## 🚀 快速开始

### 1. 添加依赖

在您的 `pubspec.yaml` 中添加：

```yaml
dependencies:
  firebase_auth_kit:
    path: ../firebase_auth_kit
  google_sign_in: ^6.2.1
```

### 2. 实现 Google 登录提供者

```dart
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth_kit/firebase_auth_kit.dart';

class MyGoogleSignInProvider implements GoogleSignInProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: 'your-web-client-id.apps.googleusercontent.com', // Web 平台需要
    serverClientId: 'your-server-client-id.apps.googleusercontent.com', // 服务器端需要
  );

  @override
  Future<GoogleSignInAccount?> signIn() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;
      
      return GoogleSignInAccount(
        id: googleUser.id,
        email: googleUser.email,
        displayName: googleUser.displayName,
        photoUrl: googleUser.photoUrl,
        serverAuthCode: googleUser.serverAuthCode,
        accessToken: (await googleUser.authentication).accessToken,
        idToken: (await googleUser.authentication).idToken,
      );
    } catch (e) {
      print('Google 登录失败: $e');
      return null;
    }
  }

  @override
  Future<GoogleSignInAccount?> signInSilently() async {
    try {
      final googleUser = await _googleSignIn.signInSilently();
      if (googleUser == null) return null;
      
      return GoogleSignInAccount(
        id: googleUser.id,
        email: googleUser.email,
        displayName: googleUser.displayName,
        photoUrl: googleUser.photoUrl,
        serverAuthCode: googleUser.serverAuthCode,
        accessToken: (await googleUser.authentication).accessToken,
        idToken: (await googleUser.authentication).idToken,
      );
    } catch (e) {
      print('Google 静默登录失败: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  @override
  Future<GoogleSignInAccount?> getCurrentUser() async {
    try {
      final googleUser = await _googleSignIn.signInSilently();
      if (googleUser == null) return null;
      
      return GoogleSignInAccount(
        id: googleUser.id,
        email: googleUser.email,
        displayName: googleUser.displayName,
        photoUrl: googleUser.photoUrl,
        serverAuthCode: googleUser.serverAuthCode,
        accessToken: (await googleUser.authentication).accessToken,
        idToken: (await googleUser.authentication).idToken,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }
}
```

### 3. 配置 Firebase Auth Service

```dart
import 'package:firebase_auth_kit/firebase_auth_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化 Firebase
  await Firebase.initializeApp();
  
  // 设置 Google 登录提供者
  FirebaseAuthService.instance.setGoogleProvider(MyGoogleSignInProvider());
  
  runApp(MyApp());
}
```

### 4. 使用 Google 登录

```dart
import 'package:firebase_auth_kit/firebase_auth_kit.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          final config = GoogleAuthConfig(
            isEnabled: true,
            webClientId: 'your-web-client-id.apps.googleusercontent.com',
          );
          
          final userCredential = await FirebaseAuthService.instance
              .signInWithGoogle(config: config);
          
          if (userCredential != null) {
            print('Google 登录成功!');
          }
        } catch (e) {
          print('Google 登录失败: $e');
        }
      },
      child: Text('Google 登录'),
    );
  }
}
```

## 🔧 配置说明

### Google Cloud Console 配置

1. 访问 [Google Cloud Console](https://console.cloud.google.com/)
2. 创建或选择项目
3. 启用 Google+ API
4. 在"凭据"页面创建 OAuth 2.0 客户端 ID
5. 为不同平台创建客户端 ID：
   - **Web**: 用于 Web 平台
   - **Android**: 用于 Android 平台
   - **iOS**: 用于 iOS 平台

### Firebase Console 配置

1. 访问 [Firebase Console](https://console.firebase.google.com/)
2. 选择您的项目
3. 在"Authentication" > "Sign-in method" 中启用 Google
4. 添加您的 OAuth 2.0 客户端 ID

## 📱 平台特定配置

### Android 配置

在 `android/app/build.gradle` 中添加：

```gradle
android {
    defaultConfig {
        // ...
        resValue "string", "default_web_client_id", "your-web-client-id.apps.googleusercontent.com"
    }
}
```

### iOS 配置

在 `ios/Runner/Info.plist` 中添加：

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>REVERSED_CLIENT_ID</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>your-reversed-client-id</string>
        </array>
    </dict>
</array>
```

### Web 配置

在 `web/index.html` 中添加：

```html
<head>
    <!-- ... -->
    <meta name="google-signin-client_id" content="your-web-client-id.apps.googleusercontent.com">
</head>
```

## 🛠️ 故障排除

### 常见问题

1. **"Google 登录提供者未设置"**
   - 确保在调用 `signInWithGoogle` 之前调用了 `setGoogleProvider`

2. **"当前平台不支持 Google 登录"**
   - 检查平台检测器是否正确识别了当前平台

3. **"OAuth 客户端 ID 无效"**
   - 确保在 Google Cloud Console 中正确配置了 OAuth 客户端 ID
   - 检查 Firebase Console 中的 Google 登录配置

4. **"网络错误"**
   - 检查网络连接
   - 确保设备可以访问 Google 服务

## 📚 更多示例

### 使用 Provider 状态管理

```dart
class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    
    return ElevatedButton(
      onPressed: () async {
        final config = GoogleAuthConfig(
          isEnabled: true,
          webClientId: 'your-web-client-id.apps.googleusercontent.com',
        );
        
        await authNotifier.signInWithGoogle(config: config);
      },
      child: Text('Google 登录'),
    );
  }
}
```

### 错误处理

```dart
try {
  await authNotifier.signInWithGoogle(config: config);
} catch (e) {
  if (e.toString().contains('popup_closed_by_user')) {
    print('用户取消了登录');
  } else if (e.toString().contains('network_error')) {
    print('网络错误，请检查网络连接');
  } else {
    print('登录失败: $e');
  }
}
```

## 🔗 相关链接

- [Google Sign-In Flutter Plugin](https://pub.dev/packages/google_sign_in)
- [Firebase Authentication](https://firebase.google.com/docs/auth)
- [Google Cloud Console](https://console.cloud.google.com/)
- [Firebase Console](https://console.firebase.google.com/) 