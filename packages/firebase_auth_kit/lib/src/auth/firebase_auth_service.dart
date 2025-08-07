import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../config/auth_platform_config.dart';
import '../config/auth_config_manager.dart';
import '../platform/platform_detector.dart';
import '../core/logger.dart';
import 'providers/google_sign_in_provider.dart';
import 'providers/facebook_sign_in_provider.dart';
import 'providers/github_sign_in_provider.dart';

/// Firebase认证服务 / Firebase Authentication Service
class FirebaseAuthService {
  static FirebaseAuthService? _instance;
  static FirebaseAuthService get instance => _instance ??= FirebaseAuthService._();
  
  /// Google 登录提供者 / Google Sign-In Provider
  GoogleSignInProvider? _googleProvider;
  
  /// Facebook 登录提供者 / Facebook Sign-In Provider
  FacebookSignInProvider? _facebookProvider;
  
  /// GitHub 登录提供者 / GitHub Sign-In Provider
  GitHubSignInProvider? _githubProvider;
  
  FirebaseAuthService._();
  
  /// 设置 Google 登录提供者 / Set Google Sign-In Provider
  void setGoogleProvider(GoogleSignInProvider provider) {
    _googleProvider = provider;
  }
  
  /// 设置 Facebook 登录提供者 / Set Facebook Sign-In Provider
  void setFacebookProvider(FacebookSignInProvider provider) {
    _facebookProvider = provider;
  }
  
  /// 设置 GitHub 登录提供者 / Set GitHub Sign-In Provider
  void setGitHubProvider(GitHubSignInProvider provider) {
    _githubProvider = provider;
  }

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

  /// 启用平台认证方式
  static Future<void> _enablePlatformAuthMethods(FirebaseAuthConfig config) async {
    // 这里可以根据配置启用相应的认证方式
    // 目前主要是配置验证，具体的认证逻辑由提供者实现
  }

  /// Google登录
  Future<UserCredential?> signInWithGoogle({
    required GoogleAuthConfig config,
  }) async {
    try {
      if (!PlatformDetector.supportsFeature('google_sign_in')) {
        throw Exception('当前平台不支持Google登录 / Current platform does not support Google sign-in');
      }

      if (_googleProvider == null) {
        throw Exception('Google登录提供者未设置，请先调用 setGoogleProvider() / Google sign-in provider not set, please call setGoogleProvider() first');
      }

      // 执行Google登录 / Perform Google sign-in
      final googleUser = await _googleProvider!.signIn();
      if (googleUser == null) return null;

      // 创建Firebase认证凭据 / Create Firebase authentication credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleUser.accessToken,
        idToken: googleUser.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      Log.e('Google登录失败 / Google sign-in failed', error: e);
      rethrow;
    }
  }

  /// Facebook登录
  Future<UserCredential?> signInWithFacebook({
    required FacebookAuthConfig config,
  }) async {
    try {
      if (!PlatformDetector.supportsFeature('facebook_sign_in')) {
        throw Exception('当前平台不支持Facebook登录 / Current platform does not support Facebook sign-in');
      }

      if (_facebookProvider == null) {
        throw Exception('Facebook登录提供者未设置，请先调用 setFacebookProvider() / Facebook sign-in provider not set, please call setFacebookProvider() first');
      }

      // 执行Facebook登录 / Perform Facebook sign-in
      final facebookUser = await _facebookProvider!.signIn();
      if (facebookUser == null) return null;

      // 创建Firebase认证凭据 / Create Firebase authentication credential
      final credential = FacebookAuthProvider.credential(
        facebookUser.accessToken!,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      Log.e('Facebook登录失败 / Facebook sign-in failed', error: e);
      rethrow;
    }
  }

  /// GitHub登录
  Future<UserCredential?> signInWithGitHub({
    required GitHubAuthConfig config,
  }) async {
    try {
      if (!PlatformDetector.supportsFeature('github_sign_in')) {
        throw Exception('当前平台不支持GitHub登录 / Current platform does not support GitHub sign-in');
      }

      if (_githubProvider == null) {
        throw Exception('GitHub登录提供者未设置，请先调用 setGitHubProvider() / GitHub sign-in provider not set, please call setGitHubProvider() first');
      }

      // 执行GitHub登录 / Perform GitHub sign-in
      final githubUser = await _githubProvider!.signIn();
      if (githubUser == null) return null;

      // 创建Firebase认证凭据 / Create Firebase authentication credential
      final credential = GithubAuthProvider.credential(
        githubUser.accessToken!,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      Log.e('GitHub登录失败 / GitHub sign-in failed', error: e);
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
      Log.e('Apple登录失败 / Apple sign-in failed', error: e);
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
      Log.e('邮箱密码登录失败 / Email password sign-in failed', error: e);
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
      Log.e('邮箱密码注册失败 / Email password sign-up failed', error: e);
      rethrow;
    }
  }

  /// 匿名登录
  Future<UserCredential> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e) {
      Log.e('匿名登录失败 / Anonymous sign-in failed', error: e);
      rethrow;
    }
  }

  /// 退出登录
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      
      // 同时退出第三方登录
      await _googleProvider?.signOut();
      await _facebookProvider?.signOut();
      await _githubProvider?.signOut();
    } catch (e) {
      Log.e('退出登录失败 / Sign out failed', error: e);
      rethrow;
    }
  }

  /// 删除账户
  Future<void> deleteUser() async {
    try {
      await _auth.currentUser?.delete();
    } catch (e) {
      Log.e('删除账户失败 / Delete user failed', error: e);
      rethrow;
    }
  }

  /// 更新用户资料
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      await _auth.currentUser?.updateDisplayName(displayName);
      await _auth.currentUser?.updatePhotoURL(photoURL);
    } catch (e) {
      Log.e('更新用户资料失败 / Update user profile failed', error: e);
      rethrow;
    }
  }

  /// 更新邮箱
  Future<void> updateEmail(String email) async {
    try {
      await _auth.currentUser?.updateEmail(email);
    } catch (e) {
      Log.e('更新邮箱失败 / Update email failed', error: e);
      rethrow;
    }
  }

  /// 更新密码
  Future<void> updatePassword(String password) async {
    try {
      await _auth.currentUser?.updatePassword(password);
    } catch (e) {
      Log.e('更新密码失败 / Update password failed', error: e);
      rethrow;
    }
  }

  /// 发送密码重置邮件
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Log.e('发送密码重置邮件失败 / Send password reset email failed', error: e);
      rethrow;
    }
  }

  /// 验证密码重置代码
  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    try {
      await _auth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
    } catch (e) {
      Log.e('验证密码重置代码失败 / Confirm password reset failed', error: e);
      rethrow;
    }
  }
} 