import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_kit/firebase_auth_kit.dart';

void main() {
  group('AuthConfig Tests', () {
    test('should create valid FirebaseAuthConfig', () {
      final config = FirebaseAuthConfig(
        google: GoogleAuthConfig(
          isEnabled: true,
          webClientId: 'test-web-client-id',
        ),
        emailPassword: EmailPasswordAuthConfig(
          isEnabled: true,
          allowSignUp: true,
        ),
      );

      expect(config.google?.isEnabled, true);
      expect(config.google?.webClientId, 'test-web-client-id');
      expect(config.emailPassword?.isEnabled, true);
      expect(config.emailPassword?.allowSignUp, true);
    });

    test('should validate config correctly', () {
      final validConfig = FirebaseAuthConfig(
        google: GoogleAuthConfig(
          isEnabled: true,
          webClientId: 'valid-web-client-id',
        ),
        facebook: FacebookAuthConfig(
          isEnabled: true,
          appId: 'valid-app-id',
          appSecret: 'valid-app-secret',
        ),
      );

      final configManager = AuthConfigManager(validConfig);
      expect(configManager.validateConfig(), true);
    });

    test('should detect invalid config', () {
      final invalidConfig = FirebaseAuthConfig(
        google: GoogleAuthConfig(
          isEnabled: true,
          webClientId: '', // 空字符串，无效
        ),
        facebook: FacebookAuthConfig(
          isEnabled: true,
          appId: '', // 空字符串，无效
          appSecret: 'valid-app-secret',
        ),
      );

      final configManager = AuthConfigManager(invalidConfig);
      // 由于验证失败会打印错误信息，我们期望返回false
      expect(configManager.validateConfig(), false);
    });

    test('should get enabled platforms', () {
      final config = FirebaseAuthConfig(
        google: GoogleAuthConfig(isEnabled: true, webClientId: 'test'),
        facebook: FacebookAuthConfig(
          isEnabled: true,
          appId: 'test',
          appSecret: 'test',
        ),
        emailPassword: EmailPasswordAuthConfig(isEnabled: false),
      );

      final configManager = AuthConfigManager(config);
      final enabledPlatforms = configManager.enabledPlatforms;

      expect(enabledPlatforms.contains('google'), true);
      expect(enabledPlatforms.contains('facebook'), true);
      expect(enabledPlatforms.contains('email_password'), false);
      expect(enabledPlatforms.length, 2);
    });

    test('should check platform enabled status', () {
      final config = FirebaseAuthConfig(
        google: GoogleAuthConfig(isEnabled: true, webClientId: 'test'),
        facebook: FacebookAuthConfig(
          isEnabled: false,
          appId: 'test',
          appSecret: 'test',
        ),
      );

      final configManager = AuthConfigManager(config);
      
      expect(configManager.isPlatformEnabled('google'), true);
      expect(configManager.isPlatformEnabled('facebook'), false);
      expect(configManager.isPlatformEnabled('nonexistent'), false);
    });

    test('should get platform config by type', () {
      final googleConfig = GoogleAuthConfig(
        isEnabled: true,
        webClientId: 'test-web-client-id',
      );

      final config = FirebaseAuthConfig(google: googleConfig);
      final configManager = AuthConfigManager(config);

      final retrievedConfig = configManager.getPlatformConfig<GoogleAuthConfig>();
      expect(retrievedConfig, isNotNull);
      expect(retrievedConfig?.webClientId, 'test-web-client-id');
    });

    test('should get config summary', () {
      final config = FirebaseAuthConfig(
        google: GoogleAuthConfig(isEnabled: true, webClientId: 'test'),
        emailPassword: EmailPasswordAuthConfig(isEnabled: true),
      );

      final configManager = AuthConfigManager(config);
      final summary = configManager.getConfigSummary();

      expect(summary['enabled_platforms'], contains('google'));
      expect(summary['enabled_platforms'], contains('email_password'));
      expect(summary['total_platforms'], 2);
      expect(summary['config_valid'], true);
    });

    test('should work with example configs', () {
      final devConfig = AuthConfigExample.developmentConfig;
      final prodConfig = AuthConfigExample.productionConfig;
      final minimalConfig = AuthConfigExample.minimalConfig;

      expect(devConfig, isNotNull);
      expect(prodConfig, isNotNull);
      expect(minimalConfig, isNotNull);

      // 验证开发环境配置包含多个平台
      final devConfigManager = AuthConfigManager(devConfig);
      expect(devConfigManager.enabledPlatforms.length, greaterThan(5));

      // 验证最小配置只包含基本平台
      final minimalConfigManager = AuthConfigManager(minimalConfig);
      expect(minimalConfigManager.enabledPlatforms.length, 2);
    });
  });
} 