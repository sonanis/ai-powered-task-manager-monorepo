import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../config/auth_platform_config.dart';
import '../config/auth_config_manager.dart';
import '../platform/platform_detector.dart';

/// Firebase认证服务
class FirebaseAuthService {
  static FirebaseAuthService? _instance;
  static FirebaseAuthService get instance => _instance ??= FirebaseAuthService._();
  
  FirebaseAuthService._();

  FirebaseAuth get _auth => FirebaseAuth.instance;
  
  /// 当前用户
  User? get currentUser => _auth.currentUser;
  
  /// 用户状态流
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  /// 用户变化流
  Stream<User?> get userChanges => _auth.userChanges();

  /// 初始化Firebase认证
  static Future<void> initialize({
    required FirebaseAuthConfig config,
  }) async {
    // 确保Firebase已初始化
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    
    // 验证配置
    final configManager = AuthConfigManager(config);
    if (!configManager.validateConfig()) {
      throw Exception('Firebase Auth配置验证失败');
    }
    
    // 根据平台启用相应的认证方式
    await _enablePlatformAuthMethods(config);
  }

  /// 根据平台启用认证方式
  static Future<void> _enablePlatformAuthMethods(FirebaseAuthConfig config) async {
    final platform = PlatformDetector.currentPlatform;
    
    // 根据平台启用相应的认证方式
    switch (platform) {
      case PlatformType.android:
      case PlatformType.ios:
        // 移动平台支持所有认证方式
        break;
      case PlatformType.web:
        // Web平台不支持Apple登录
        if (config.apple?.isEnabled == true) {
          print('警告: Web平台不支持Apple登录');
        }
        break;
      case PlatformType.windows:
      case PlatformType.macos:
      case PlatformType.linux:
        // 桌面平台限制某些认证方式
        if (config.apple?.isEnabled == true && platform != PlatformType.macos) {
          print('警告: 非macOS桌面平台不支持Apple登录');
        }
        break;
      default:
        break;
    }
  }

  /// Google登录
  Future<UserCredential?> signInWithGoogle({
    required GoogleAuthConfig config,
  }) async {
    try {
      if (!PlatformDetector.supportsFeature('google_sign_in')) {
        throw Exception('当前平台不支持Google登录');
      }

      // 创建Google认证凭据
      final googleUser = await _getGoogleUser();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Google登录失败: $e');
      rethrow;
    }
  }

  /// 获取Google用户（平台特定实现）
  Future<dynamic> _getGoogleUser() async {
    // 这里需要根据平台实现具体的Google登录
    // 在实际应用中，您需要集成 google_sign_in 插件
    throw UnimplementedError('需要集成 google_sign_in 插件');
  }

  /// Facebook登录
  Future<UserCredential?> signInWithFacebook({
    required FacebookAuthConfig config,
  }) async {
    try {
      if (!PlatformDetector.supportsFeature('facebook_sign_in')) {
        throw Exception('当前平台不支持Facebook登录');
      }

      // 这里需要根据平台实现具体的Facebook登录
      // 在实际应用中，您需要集成 flutter_facebook_auth 插件
      throw UnimplementedError('需要集成 flutter_facebook_auth 插件');
    } catch (e) {
      print('Facebook登录失败: $e');
      rethrow;
    }
  }

  /// Apple登录
  Future<UserCredential?> signInWithApple({
    required AppleAuthConfig config,
  }) async {
    try {
      if (!PlatformDetector.supportsFeature('apple_sign_in')) {
        throw Exception('当前平台不支持Apple登录');
      }

      // 这里需要根据平台实现具体的Apple登录
      // 在实际应用中，您需要集成 sign_in_with_apple 插件
      throw UnimplementedError('需要集成 sign_in_with_apple 插件');
    } catch (e) {
      print('Apple登录失败: $e');
      rethrow;
    }
  }

  /// 邮箱密码登录
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('邮箱密码登录失败: $e');
      rethrow;
    }
  }

  /// 邮箱密码注册
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('邮箱密码注册失败: $e');
      rethrow;
    }
  }

  /// 手机号登录
  Future<UserCredential?> signInWithPhoneNumber({
    required String phoneNumber,
    required PhoneAuthConfig config,
  }) async {
    try {
      if (!PlatformDetector.supportsFeature('phone_auth')) {
        throw Exception('当前平台不支持手机号登录');
      }

      // 发送验证码
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('验证码发送失败: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          // 这里需要处理验证码发送成功的情况
          // 在实际应用中，您需要显示验证码输入界面
          print('验证码已发送到: $phoneNumber');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('验证码自动检索超时');
        },
        timeout: Duration(seconds: config.codeTimeout),
      );

      return null; // 需要等待用户输入验证码
    } catch (e) {
      print('手机号登录失败: $e');
      rethrow;
    }
  }

  /// 验证手机号验证码
  Future<UserCredential> verifyPhoneNumber({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('验证码验证失败: $e');
      rethrow;
    }
  }

  /// 匿名登录
  Future<UserCredential> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e) {
      print('匿名登录失败: $e');
      rethrow;
    }
  }

  /// 退出登录
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('退出登录失败: $e');
      rethrow;
    }
  }

  /// 删除账户
  Future<void> deleteAccount() async {
    try {
      await currentUser?.delete();
    } catch (e) {
      print('删除账户失败: $e');
      rethrow;
    }
  }

  /// 发送密码重置邮件
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('发送密码重置邮件失败: $e');
      rethrow;
    }
  }

  /// 更新用户资料
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      await currentUser?.updateDisplayName(displayName);
      await currentUser?.updatePhotoURL(photoURL);
    } catch (e) {
      print('更新用户资料失败: $e');
      rethrow;
    }
  }

  /// 更新邮箱
  Future<void> updateEmail(String newEmail) async {
    try {
      await currentUser?.updateEmail(newEmail);
    } catch (e) {
      print('更新邮箱失败: $e');
      rethrow;
    }
  }

  /// 更新密码
  Future<void> updatePassword(String newPassword) async {
    try {
      await currentUser?.updatePassword(newPassword);
    } catch (e) {
      print('更新密码失败: $e');
      rethrow;
    }
  }

  /// 重新发送邮箱验证邮件
  Future<void> sendEmailVerification() async {
    try {
      await currentUser?.sendEmailVerification();
    } catch (e) {
      print('发送邮箱验证邮件失败: $e');
      rethrow;
    }
  }

  /// 检查邮箱是否已验证
  bool get isEmailVerified => currentUser?.emailVerified ?? false;

  /// 获取当前平台信息
  Map<String, dynamic> getPlatformInfo() {
    return {
      'platform': PlatformDetector.platformName,
      'isMobile': PlatformDetector.isMobile,
      'isWeb': PlatformDetector.isWeb,
      'isDesktop': PlatformDetector.isDesktop,
      'supportsAppleSignIn': PlatformDetector.supportsFeature('apple_sign_in'),
      'supportsPhoneAuth': PlatformDetector.supportsFeature('phone_auth'),
    };
  }
} 