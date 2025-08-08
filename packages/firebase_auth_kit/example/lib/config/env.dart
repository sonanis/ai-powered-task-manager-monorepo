/// 环境配置类 / Environment Configuration Class
/// 
/// 用于安全地存储和管理敏感配置信息
/// Used to securely store and manage sensitive configuration information
class Env {
  // 通用 Firebase 配置 / Common Firebase Configuration
  static const String firebaseProjectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
    defaultValue: 'your-project-id',
  );
  
  static const String firebaseMessagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
    defaultValue: 'your-sender-id',
  );
  
  // Web 平台 Firebase 配置 / Web Platform Firebase Configuration
  static const String firebaseWebApiKey = String.fromEnvironment(
    'FIREBASE_WEB_API_KEY',
    defaultValue: 'your-web-api-key',
  );
  
  static const String firebaseWebAppId = String.fromEnvironment(
    'FIREBASE_WEB_APP_ID',
    defaultValue: 'your-web-app-id',
  );
  
  static const String firebaseWebAuthDomain = String.fromEnvironment(
    'FIREBASE_WEB_AUTH_DOMAIN',
    defaultValue: 'your-project-id.firebaseapp.com',
  );
  
  static const String firebaseWebStorageBucket = String.fromEnvironment(
    'FIREBASE_WEB_STORAGE_BUCKET',
    defaultValue: 'your-project-id.appspot.com',
  );
  
  static const String firebaseWebMeasurementId = String.fromEnvironment(
    'FIREBASE_WEB_MEASUREMENT_ID',
    defaultValue: 'your-web-measurement-id',
  );
  
  // Android 平台 Firebase 配置 / Android Platform Firebase Configuration
  static const String firebaseAndroidApiKey = String.fromEnvironment(
    'FIREBASE_ANDROID_API_KEY',
    defaultValue: 'your-android-api-key',
  );
  
  static const String firebaseAndroidAppId = String.fromEnvironment(
    'FIREBASE_ANDROID_APP_ID',
    defaultValue: 'your-android-app-id',
  );
  
  static const String firebaseAndroidStorageBucket = String.fromEnvironment(
    'FIREBASE_ANDROID_STORAGE_BUCKET',
    defaultValue: 'your-project-id.appspot.com',
  );
  
  static const String firebaseAndroidPackageName = String.fromEnvironment(
    'FIREBASE_ANDROID_PACKAGE_NAME',
    defaultValue: 'com.example.firebase_auth_kit_example',
  );
  
  // iOS 平台 Firebase 配置 / iOS Platform Firebase Configuration
  static const String firebaseIosApiKey = String.fromEnvironment(
    'FIREBASE_IOS_API_KEY',
    defaultValue: 'your-ios-api-key',
  );
  
  static const String firebaseIosAppId = String.fromEnvironment(
    'FIREBASE_IOS_APP_ID',
    defaultValue: 'your-ios-app-id',
  );
  
  static const String firebaseIosStorageBucket = String.fromEnvironment(
    'FIREBASE_IOS_STORAGE_BUCKET',
    defaultValue: 'your-project-id.appspot.com',
  );
  
  static const String firebaseIosBundleId = String.fromEnvironment(
    'FIREBASE_IOS_BUNDLE_ID',
    defaultValue: 'com.example.firebaseAuthKitExample',
  );
  
  // macOS 平台 Firebase 配置 / macOS Platform Firebase Configuration
  static const String firebaseMacosApiKey = String.fromEnvironment(
    'FIREBASE_MACOS_API_KEY',
    defaultValue: 'your-macos-api-key',
  );
  
  static const String firebaseMacosAppId = String.fromEnvironment(
    'FIREBASE_MACOS_APP_ID',
    defaultValue: 'your-macos-app-id',
  );
  
  static const String firebaseMacosStorageBucket = String.fromEnvironment(
    'FIREBASE_MACOS_STORAGE_BUCKET',
    defaultValue: 'your-project-id.appspot.com',
  );
  
  static const String firebaseMacosBundleId = String.fromEnvironment(
    'FIREBASE_MACOS_BUNDLE_ID',
    defaultValue: 'com.example.firebaseAuthKitExample',
  );
  
  // Windows 平台 Firebase 配置 / Windows Platform Firebase Configuration
  static const String firebaseWindowsApiKey = String.fromEnvironment(
    'FIREBASE_WINDOWS_API_KEY',
    defaultValue: 'your-windows-api-key',
  );
  
  static const String firebaseWindowsAppId = String.fromEnvironment(
    'FIREBASE_WINDOWS_APP_ID',
    defaultValue: 'your-windows-app-id',
  );
  
  static const String firebaseWindowsStorageBucket = String.fromEnvironment(
    'FIREBASE_WINDOWS_STORAGE_BUCKET',
    defaultValue: 'your-project-id.appspot.com',
  );
  
  // GitHub OAuth 统一配置（所有平台通用）/ GitHub OAuth Unified Configuration (All Platforms)
  static const String githubClientId = String.fromEnvironment(
    'GITHUB_CLIENT_ID',
    defaultValue: 'your-github-client-id',
  );
  
  static const String githubClientSecret = String.fromEnvironment(
    'GITHUB_CLIENT_SECRET',
    defaultValue: 'your-github-client-secret',
  );
  
  // GitHub OAuth 统一回调 URL / GitHub OAuth Unified Callback URL
  static const String githubCallbackUrl = String.fromEnvironment(
    'GITHUB_CALLBACK_URL',
    defaultValue: 'http://localhost:8080/__/auth/handler',
  );
  
  // Google OAuth 配置（所有平台通用）/ Google OAuth Configuration (All Platforms)
  static const String googleWebClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
    defaultValue: 'your-google-web-client-id',
  );
  
  static const String googleAndroidClientId = String.fromEnvironment(
    'GOOGLE_ANDROID_CLIENT_ID',
    defaultValue: 'your-google-android-client-id',
  );
  
  static const String googleIosClientId = String.fromEnvironment(
    'GOOGLE_IOS_CLIENT_ID',
    defaultValue: 'your-google-ios-client-id',
  );
  
  // Facebook OAuth 配置（所有平台通用）/ Facebook OAuth Configuration (All Platforms)
  static const String facebookAppId = String.fromEnvironment(
    'FACEBOOK_APP_ID',
    defaultValue: 'your-facebook-app-id',
  );
  
  static const String facebookAppSecret = String.fromEnvironment(
    'FACEBOOK_APP_SECRET',
    defaultValue: 'your-facebook-app-secret',
  );
  
  /// 检查是否使用默认配置值（开发环境）
  /// Check if using default configuration values (development environment)
  /// 
  /// 注意：这个判断基于配置值是否为默认值，而不是应用是否在调试模式
  /// Note: This check is based on whether configuration values are defaults, not whether the app is in debug mode
  static bool get isDevelopment {
    return firebaseWebApiKey == 'your-web-api-key' || 
           firebaseProjectId == 'your-project-id' ||
           githubClientId == 'your-github-client-id' ||
           googleWebClientId == 'your-google-web-client-id' ||
           facebookAppId == 'your-facebook-app-id';
  }
  
  /// 获取 Firebase 配置警告信息 / Get Firebase configuration warning
  static String get configurationWarning {
    if (isDevelopment) {
      return '''
⚠️  开发环境配置警告 / Development Environment Configuration Warning

请按照以下步骤配置 Firebase、GitHub OAuth、Google OAuth 和 Facebook OAuth：

1. 创建 Firebase 项目并添加 Web 应用
2. 创建 GitHub OAuth 应用
3. 创建 Google OAuth 应用
4. 创建 Facebook OAuth 应用
5. 更新 firebase_options.dart 文件
6. 或使用环境变量运行：

flutter run -d chrome \\
  --dart-define=FIREBASE_WEB_API_KEY=your-api-key \\
  --dart-define=FIREBASE_PROJECT_ID=your-project-id \\
  --dart-define=GITHUB_CLIENT_ID=your-client-id \\
  --dart-define=GITHUB_CLIENT_SECRET=your-client-secret \\
  --dart-define=GOOGLE_WEB_CLIENT_ID=your-google-client-id \\
  --dart-define=FACEBOOK_APP_ID=your-facebook-app-id \\
  --dart-define=FACEBOOK_APP_SECRET=your-facebook-app-secret

详细配置说明请查看 FIREBASE_SETUP_GUIDE.md 文件。
''';
    }
    return '';
  }
} 