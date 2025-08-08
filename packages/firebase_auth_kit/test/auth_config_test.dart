import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_kit/firebase_auth_kit.dart';
import 'fixtures/auth_config_fixtures.dart';

void main() {
  group('AuthConfig Tests', () {
    test('should create valid FirebaseAuthConfig', () {
      final config = AuthConfigFixtures.testConfig;

      expect(config.google?.isEnabled, true);
      expect(config.google?.webClientId, 'test-web-client-id');
      expect(config.emailPassword?.isEnabled, true);
      expect(config.emailPassword?.allowSignUp, true);
    });

    test('should validate config correctly', () {
      final validConfig = AuthConfigFixtures.developmentConfig;

      final configManager = AuthConfigManager(validConfig);
      expect(configManager.validateConfig(), true);
    });

    test('should detect invalid config', () {
      final invalidConfig = AuthConfigFixtures.invalidConfig;

      final configManager = AuthConfigManager(invalidConfig);
      // 由于验证失败会打印错误信息，我们期望返回false
      expect(configManager.validateConfig(), false);
    });

    test('should get enabled platforms', () {
      final config = AuthConfigFixtures.developmentConfig;

      final configManager = AuthConfigManager(config);
      final enabledPlatforms = configManager.enabledPlatforms;

      expect(enabledPlatforms.contains('google'), true);
      expect(enabledPlatforms.contains('facebook'), true);
      expect(enabledPlatforms.contains('email_password'), true);
      expect(enabledPlatforms.length, greaterThan(5));
    });

    test('should check platform enabled status', () {
      final config = AuthConfigFixtures.developmentConfig;

      final configManager = AuthConfigManager(config);
      
      expect(configManager.isPlatformEnabled('google'), true);
      expect(configManager.isPlatformEnabled('facebook'), true);
      expect(configManager.isPlatformEnabled('saml'), false); // SAML在开发配置中禁用
      expect(configManager.isPlatformEnabled('nonexistent'), false);
    });

    test('should get platform config by type', () {
      final config = AuthConfigFixtures.developmentConfig;
      final configManager = AuthConfigManager(config);

      final retrievedConfig = configManager.getPlatformConfig<GoogleAuthConfig>();
      expect(retrievedConfig, isNotNull);
      expect(retrievedConfig?.webClientId, 'your-google-web-client-id.apps.googleusercontent.com');
    });

    test('should get config summary', () {
      final config = AuthConfigFixtures.developmentConfig;

      final configManager = AuthConfigManager(config);
      final summary = configManager.getConfigSummary();

      expect(summary['enabled_platforms'], contains('google'));
      expect(summary['enabled_platforms'], contains('email_password'));
      expect(summary['enabled_platforms'], contains('facebook'));
      expect(summary['total_platforms'], greaterThan(5));
      expect(summary['config_valid'], true);
    });

    test('should work with fixture configs', () {
      final devConfig = AuthConfigFixtures.developmentConfig;
      final prodConfig = AuthConfigFixtures.productionConfig;
      final minimalConfig = AuthConfigFixtures.minimalConfig;

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