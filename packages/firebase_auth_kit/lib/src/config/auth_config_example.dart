import 'auth_platform_config.dart';

/// Firebase Auth 配置示例
class AuthConfigExample {
  /// 获取开发环境配置示例
  static FirebaseAuthConfig get developmentConfig {
    return const FirebaseAuthConfig(
      // Google登录配置
      google: GoogleAuthConfig(
        isEnabled: true,
        webClientId: 'your-google-web-client-id.apps.googleusercontent.com',
        iosClientId: 'your-google-ios-client-id.apps.googleusercontent.com',
        androidClientId: 'your-google-android-client-id.apps.googleusercontent.com',
        serverClientId: 'your-google-server-client-id.apps.googleusercontent.com',
      ),
      
      // Facebook登录配置
      facebook: FacebookAuthConfig(
        isEnabled: true,
        appId: 'your-facebook-app-id',
        appSecret: 'your-facebook-app-secret',
        permissions: ['email', 'public_profile'],
      ),
      
      // Apple登录配置 (仅iOS 13+)
      apple: AppleAuthConfig(
        isEnabled: true,
        serviceId: 'your-apple-service-id',
        teamId: 'your-apple-team-id',
        keyId: 'your-apple-key-id',
        privateKey: 'your-apple-private-key',
        scopes: ['email', 'name'],
      ),
      
      // Twitter登录配置
      twitter: TwitterAuthConfig(
        isEnabled: true,
        apiKey: 'your-twitter-api-key',
        apiSecret: 'your-twitter-api-secret',
      ),
      
      // GitHub登录配置
      github: GitHubAuthConfig(
        isEnabled: true,
        clientId: 'your-github-client-id',
        clientSecret: 'your-github-client-secret',
        scopes: ['user:email', 'read:user'],
      ),
      
      // Microsoft登录配置
      microsoft: MicrosoftAuthConfig(
        isEnabled: true,
        clientId: 'your-microsoft-client-id',
        clientSecret: 'your-microsoft-client-secret',
        tenantId: 'your-microsoft-tenant-id',
        scopes: ['user.read', 'email'],
      ),
      
      // Yahoo登录配置
      yahoo: YahooAuthConfig(
        isEnabled: true,
        clientId: 'your-yahoo-client-id',
        clientSecret: 'your-yahoo-client-secret',
      ),
      
      // LinkedIn登录配置
      linkedin: LinkedInAuthConfig(
        isEnabled: true,
        clientId: 'your-linkedin-client-id',
        clientSecret: 'your-linkedin-client-secret',
        scopes: ['r_emailaddress', 'r_liteprofile'],
      ),
      
      // 邮箱密码登录配置
      emailPassword: EmailPasswordAuthConfig(
        isEnabled: true,
        allowSignUp: true,
        allowPasswordReset: true,
        requireEmailVerification: false,
        passwordMinLength: '6',
      ),
      
      // 手机号登录配置
      phone: PhoneAuthConfig(
        isEnabled: true,
        codeTimeout: 60,
        codeLength: 6,
        defaultCountryCode: '+86',
        allowedCountryCodes: ['+86', '+1', '+44', '+81'],
      ),
      
      // 匿名登录配置
      anonymous: AnonymousAuthConfig(
        isEnabled: true,
      ),
      
      // SAML配置 (企业级)
      saml: SAMLAuthConfig(
        isEnabled: false, // 开发环境通常不启用
        providerId: 'your-saml-provider-id',
        entityId: 'your-saml-entity-id',
        ssoUrl: 'https://your-saml-provider.com/sso',
        x509Certificate: 'your-saml-x509-certificate',
        displayName: 'SAML Provider',
      ),
      
      // OIDC配置 (企业级)
      oidc: OIDCAuthConfig(
        isEnabled: false, // 开发环境通常不启用
        providerId: 'your-oidc-provider-id',
        clientId: 'your-oidc-client-id',
        issuer: 'https://your-oidc-provider.com',
        clientSecret: 'your-oidc-client-secret',
        displayName: 'OIDC Provider',
      ),
    );
  }

  /// 获取生产环境配置示例
  static FirebaseAuthConfig get productionConfig {
    return const FirebaseAuthConfig(
      // 生产环境通常只启用必要的平台
      google: GoogleAuthConfig(
        isEnabled: true,
        webClientId: 'your-production-google-web-client-id.apps.googleusercontent.com',
        iosClientId: 'your-production-google-ios-client-id.apps.googleusercontent.com',
        androidClientId: 'your-production-google-android-client-id.apps.googleusercontent.com',
      ),
      
      facebook: FacebookAuthConfig(
        isEnabled: true,
        appId: 'your-production-facebook-app-id',
        appSecret: 'your-production-facebook-app-secret',
      ),
      
      apple: AppleAuthConfig(
        isEnabled: true,
        serviceId: 'your-production-apple-service-id',
        teamId: 'your-production-apple-team-id',
        keyId: 'your-production-apple-key-id',
      ),
      
      emailPassword: EmailPasswordAuthConfig(
        isEnabled: true,
        allowSignUp: true,
        allowPasswordReset: true,
        requireEmailVerification: true, // 生产环境建议启用邮箱验证
        passwordMinLength: '8',
      ),
      
      phone: PhoneAuthConfig(
        isEnabled: true,
        codeTimeout: 300, // 生产环境延长超时时间
        codeLength: 6,
        defaultCountryCode: '+86',
      ),
      
      anonymous: AnonymousAuthConfig(
        isEnabled: false, // 生产环境通常禁用匿名登录
      ),
    );
  }

  /// 获取最小配置示例 (仅启用基本功能)
  static FirebaseAuthConfig get minimalConfig {
    return const FirebaseAuthConfig(
      google: GoogleAuthConfig(
        isEnabled: true,
        webClientId: 'your-google-web-client-id.apps.googleusercontent.com',
      ),
      
      emailPassword: EmailPasswordAuthConfig(
        isEnabled: true,
        allowSignUp: true,
        allowPasswordReset: true,
      ),
    );
  }
}

/// 配置使用说明
class AuthConfigUsage {
  /// 如何获取各平台的配置参数
  
  /// Google登录配置获取步骤：
  /// 1. 访问 Google Cloud Console (https://console.cloud.google.com/)
  /// 2. 创建或选择项目
  /// 3. 启用 Google+ API
  /// 4. 在"凭据"页面创建OAuth 2.0客户端ID
  /// 5. 为不同平台创建客户端ID：
  ///    - Web应用：webClientId
  ///    - iOS应用：iosClientId  
  ///    - Android应用：androidClientId
  static String getGoogleConfigSteps() {
    return '''
Google登录配置步骤：
1. 访问 Google Cloud Console
2. 创建项目并启用 Google+ API
3. 在"凭据"页面创建OAuth 2.0客户端ID
4. 为不同平台创建客户端ID
5. 在Firebase控制台配置Google登录提供商
''';
  }

  /// Facebook登录配置获取步骤：
  /// 1. 访问 Facebook Developers (https://developers.facebook.com/)
  /// 2. 创建应用
  /// 3. 获取App ID和App Secret
  /// 4. 配置OAuth重定向URI
  /// 5. 在Firebase控制台配置Facebook登录提供商
  static String getFacebookConfigSteps() {
    return '''
Facebook登录配置步骤：
1. 访问 Facebook Developers
2. 创建应用并获取App ID和App Secret
3. 配置OAuth重定向URI
4. 在Firebase控制台配置Facebook登录提供商
5. 添加必要的权限（email, public_profile）
''';
  }

  /// Apple登录配置获取步骤：
  /// 1. 访问 Apple Developer (https://developer.apple.com/)
  /// 2. 创建App ID并启用Sign In with Apple
  /// 3. 创建Service ID
  /// 4. 生成私钥并获取Key ID
  /// 5. 在Firebase控制台配置Apple登录提供商
  static String getAppleConfigSteps() {
    return '''
Apple登录配置步骤：
1. 访问 Apple Developer
2. 创建App ID并启用Sign In with Apple
3. 创建Service ID
4. 生成私钥并获取Key ID和Team ID
5. 在Firebase控制台配置Apple登录提供商
注意：仅支持iOS 13+和macOS 10.15+
''';
  }

  /// 安全注意事项
  static String getSecurityNotes() {
    return '''
安全注意事项：
1. 不要在代码中硬编码敏感信息（如clientSecret）
2. 使用环境变量或安全的配置管理系统
3. 定期轮换密钥和令牌
4. 在生产环境中启用HTTPS
5. 实施适当的错误处理和日志记录
6. 遵循各平台的安全最佳实践
''';
  }
} 