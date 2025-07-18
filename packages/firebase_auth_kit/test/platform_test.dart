import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_kit/firebase_auth_kit.dart';

void main() {
  group('Platform Detection Tests', () {
    test('should detect platform correctly', () {
      final platform = PlatformDetector.currentPlatform;
      expect(platform, isNotNull);
      
      final platformName = PlatformDetector.platformName;
      expect(platformName, isNotEmpty);
      expect(platformName, isNot('Unknown'));
    });

    test('should check platform capabilities', () {
      // 测试移动平台功能
      final isMobile = PlatformDetector.isMobile;
      final isWeb = PlatformDetector.isWeb;
      final isDesktop = PlatformDetector.isDesktop;
      
      expect(isMobile || isWeb || isDesktop, true);
      
      // 测试功能支持
      final supportsGoogle = PlatformDetector.supportsFeature('google_sign_in');
      final supportsFacebook = PlatformDetector.supportsFeature('facebook_sign_in');
      final supportsPhone = PlatformDetector.supportsFeature('phone_auth');
      
      expect(supportsGoogle, true); // 所有平台都支持Google
      expect(supportsFacebook, true); // 所有平台都支持Facebook
      expect(supportsPhone, isMobile); // 只有移动平台支持手机号登录
    });

    test('should get platform config keys', () {
      final androidKey = PlatformDetector.getPlatformConfigKey('client_id');
      final iosKey = PlatformDetector.getPlatformConfigKey('client_id');
      final webKey = PlatformDetector.getPlatformConfigKey('client_id');
      
      expect(androidKey, isNotEmpty);
      expect(iosKey, isNotEmpty);
      expect(webKey, isNotEmpty);
    });
  });

  group('Firebase Auth Service Tests', () {
    test('should create singleton instance', () {
      final service1 = FirebaseAuthService.instance;
      final service2 = FirebaseAuthService.instance;
      
      expect(service1, same(service2));
    });

    test('should get platform info', () {
      final service = FirebaseAuthService.instance;
      final platformInfo = service.getPlatformInfo();
      
      expect(platformInfo, isA<Map<String, dynamic>>());
      expect(platformInfo['platform'], isNotEmpty);
      expect(platformInfo['isMobile'], isA<bool>());
      expect(platformInfo['isWeb'], isA<bool>());
      expect(platformInfo['isDesktop'], isA<bool>());
      expect(platformInfo['supportsAppleSignIn'], isA<bool>());
      expect(platformInfo['supportsPhoneAuth'], isA<bool>());
    });

    test('should handle email verification status', () {
      // 在测试环境中，Firebase可能未初始化，所以我们需要处理这种情况
      try {
        final service = FirebaseAuthService.instance;
        final isVerified = service.isEmailVerified;
        expect(isVerified, isA<bool>());
      } catch (e) {
        // 在测试环境中，Firebase未初始化是正常的
        expect(e.toString(), contains('No Firebase App'));
      }
    });
  });

  group('Cross-Platform Configuration Tests', () {
    test('should create platform-aware config', () {
      final config = FirebaseAuthConfig(
        google: GoogleAuthConfig(
          isEnabled: true,
          webClientId: 'web-client-id',
          iosClientId: 'ios-client-id',
          androidClientId: 'android-client-id',
        ),
        facebook: FacebookAuthConfig(
          isEnabled: true,
          appId: 'facebook-app-id',
          appSecret: 'facebook-app-secret',
        ),
        apple: AppleAuthConfig(
          isEnabled: PlatformDetector.supportsFeature('apple_sign_in'),
          serviceId: 'apple-service-id',
          teamId: 'apple-team-id',
          keyId: 'apple-key-id',
        ),
        emailPassword: EmailPasswordAuthConfig(
          isEnabled: true,
          allowSignUp: true,
          allowPasswordReset: true,
        ),
        phone: PhoneAuthConfig(
          isEnabled: PlatformDetector.supportsFeature('phone_auth'),
          codeTimeout: 60,
          codeLength: 6,
        ),
      );

      final configManager = AuthConfigManager(config);
      final enabledPlatforms = configManager.enabledPlatforms;
      
      expect(enabledPlatforms.contains('google'), true);
      expect(enabledPlatforms.contains('facebook'), true);
      expect(enabledPlatforms.contains('email_password'), true);
      
      // Apple登录只在支持的平台上启用
      if (PlatformDetector.supportsFeature('apple_sign_in')) {
        expect(enabledPlatforms.contains('apple'), true);
      } else {
        expect(enabledPlatforms.contains('apple'), false);
      }
      
      // 手机号登录只在移动平台上启用
      if (PlatformDetector.supportsFeature('phone_auth')) {
        expect(enabledPlatforms.contains('phone'), true);
      } else {
        expect(enabledPlatforms.contains('phone'), false);
      }
    });
  });
} 