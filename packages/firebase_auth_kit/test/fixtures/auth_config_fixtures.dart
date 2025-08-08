import 'package:firebase_auth_kit/firebase_auth_kit.dart';

/// Firebase Auth 配置测试数据 / Firebase Auth Configuration Test Fixtures
/// 
/// 提供用于测试的配置数据，包含不同环境的配置示例
/// Provides configuration data for testing, including examples for different environments
class AuthConfigFixtures {
  /// 获取开发环境配置示例 / Get development environment configuration example
  static FirebaseAuthConfig get developmentConfig {
    return const FirebaseAuthConfig(
      // Google登录配置 / Google Sign-In Configuration
      google: GoogleAuthConfig(
        isEnabled: true,
        webClientId: 'your-google-web-client-id.apps.googleusercontent.com',
        iosClientId: 'your-google-ios-client-id.apps.googleusercontent.com',
        androidClientId: 'your-google-android-client-id.apps.googleusercontent.com',
        serverClientId: 'your-google-server-client-id.apps.googleusercontent.com',
      ),
      
      // Facebook登录配置 / Facebook Sign-In Configuration
      facebook: FacebookAuthConfig(
        isEnabled: true,
        appId: 'your-facebook-app-id',
        appSecret: 'your-facebook-app-secret',
        permissions: ['email', 'public_profile'],
      ),
      
      // Apple登录配置 (仅iOS 13+) / Apple Sign-In Configuration (iOS 13+ only)
      apple: AppleAuthConfig(
        isEnabled: true,
        serviceId: 'your-apple-service-id',
        teamId: 'your-apple-team-id',
        keyId: 'your-apple-key-id',
        privateKey: 'your-apple-private-key',
        scopes: ['email', 'name'],
      ),
      
      // Twitter登录配置 / Twitter Sign-In Configuration
      twitter: TwitterAuthConfig(
        isEnabled: true,
        apiKey: 'your-twitter-api-key',
        apiSecret: 'your-twitter-api-secret',
      ),
      
      // GitHub登录配置 / GitHub Sign-In Configuration
      github: GitHubAuthConfig(
        isEnabled: true,
        clientId: 'your-github-client-id',
        clientSecret: 'your-github-client-secret',
        scopes: ['user:email', 'read:user'],
      ),
      
      // Microsoft登录配置 / Microsoft Sign-In Configuration
      microsoft: MicrosoftAuthConfig(
        isEnabled: true,
        clientId: 'your-microsoft-client-id',
        clientSecret: 'your-microsoft-client-secret',
        tenantId: 'your-microsoft-tenant-id',
        scopes: ['user.read', 'email'],
      ),
      
      // Yahoo登录配置 / Yahoo Sign-In Configuration
      yahoo: YahooAuthConfig(
        isEnabled: true,
        clientId: 'your-yahoo-client-id',
        clientSecret: 'your-yahoo-client-secret',
      ),
      
      // LinkedIn登录配置 / LinkedIn Sign-In Configuration
      linkedin: LinkedInAuthConfig(
        isEnabled: true,
        clientId: 'your-linkedin-client-id',
        clientSecret: 'your-linkedin-client-secret',
        scopes: ['r_emailaddress', 'r_liteprofile'],
      ),
      
      // 邮箱密码登录配置 / Email Password Sign-In Configuration
      emailPassword: EmailPasswordAuthConfig(
        isEnabled: true,
        allowSignUp: true,
        allowPasswordReset: true,
        requireEmailVerification: false,
        passwordMinLength: '6',
      ),
      
      // 手机号登录配置 / Phone Number Sign-In Configuration
      phone: PhoneAuthConfig(
        isEnabled: true,
        codeTimeout: 60,
        codeLength: 6,
        defaultCountryCode: '+86',
        allowedCountryCodes: ['+86', '+1', '+44', '+81'],
      ),
      
      // 匿名登录配置 / Anonymous Sign-In Configuration
      anonymous: AnonymousAuthConfig(
        isEnabled: true,
      ),
      
      // SAML配置 (企业级) / SAML Configuration (Enterprise)
      saml: SAMLAuthConfig(
        isEnabled: false, // 开发环境通常不启用 / Usually disabled in development
        providerId: 'your-saml-provider-id',
        entityId: 'your-saml-entity-id',
        ssoUrl: 'https://your-saml-provider.com/sso',
        x509Certificate: 'your-saml-x509-certificate',
        displayName: 'SAML Provider',
      ),
      
      // OIDC配置 (企业级) / OIDC Configuration (Enterprise)
      oidc: OIDCAuthConfig(
        isEnabled: false, // 开发环境通常不启用 / Usually disabled in development
        providerId: 'your-oidc-provider-id',
        clientId: 'your-oidc-client-id',
        issuer: 'https://your-oidc-provider.com',
        clientSecret: 'your-oidc-client-secret',
        displayName: 'OIDC Provider',
      ),
    );
  }

  /// 获取生产环境配置示例 / Get production environment configuration example
  static FirebaseAuthConfig get productionConfig {
    return const FirebaseAuthConfig(
      // 生产环境通常只启用必要的平台 / Production usually only enables necessary platforms
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
        requireEmailVerification: true, // 生产环境建议启用邮箱验证 / Recommended in production
        passwordMinLength: '8',
      ),
      
      phone: PhoneAuthConfig(
        isEnabled: true,
        codeTimeout: 300, // 生产环境延长超时时间 / Extended timeout in production
        codeLength: 6,
        defaultCountryCode: '+86',
      ),
      
      anonymous: AnonymousAuthConfig(
        isEnabled: false, // 生产环境通常禁用匿名登录 / Usually disabled in production
      ),
    );
  }

  /// 获取最小配置示例 (仅启用基本功能) / Get minimal configuration example (basic features only)
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

  /// 获取无效配置示例 (用于测试验证) / Get invalid configuration example (for validation testing)
  static FirebaseAuthConfig get invalidConfig {
    return const FirebaseAuthConfig(
      google: GoogleAuthConfig(
        isEnabled: true,
        webClientId: '', // 空字符串，无效 / Empty string, invalid
      ),
      facebook: FacebookAuthConfig(
        isEnabled: true,
        appId: '', // 空字符串，无效 / Empty string, invalid
        appSecret: 'valid-app-secret',
      ),
    );
  }

  /// 获取测试配置示例 / Get test configuration example
  static FirebaseAuthConfig get testConfig {
    return const FirebaseAuthConfig(
      google: GoogleAuthConfig(
        isEnabled: true,
        webClientId: 'test-web-client-id',
      ),
      emailPassword: EmailPasswordAuthConfig(
        isEnabled: true,
        allowSignUp: true,
      ),
    );
  }
}
