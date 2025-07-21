import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/firebase_auth_service.dart';
import '../config/auth_platform_config.dart';
import '../models/auth_models.dart';

/// 创建认证Provider / Create authentication provider
ChangeNotifierProvider<AuthNotifier> createAuthProvider() {
  return ChangeNotifierProvider<AuthNotifier>(
    create: (context) => AuthNotifier(),
  );
}

/// 认证状态管理器 / Authentication State Manager
class AuthNotifier extends ChangeNotifier {
  AuthState _state = const AuthState();
  AuthState get state => _state;

  AuthNotifier() {
    // 监听Firebase认证状态变化 / Listen to Firebase auth state changes
    _listenToAuthChanges();
  }

  /// 监听认证状态变化 / Listen to authentication state changes
  void _listenToAuthChanges() {
    FirebaseAuthService.instance.authStateChanges.listen((firebaseUser) {
      if (firebaseUser != null) {
        // 用户已登录 / User is logged in
        _updateState(_state.copyWith(
          status: UserStatus.authenticated,
          user: firebaseUser,
          error: null,
          isLoading: false,
        ));
      } else {
        // 用户未登录 / User is not logged in
        _updateState(_state.copyWith(
          status: UserStatus.unauthenticated,
          user: null,
          error: null,
          isLoading: false,
        ));
      }
    });
  }

  /// 更新状态并通知监听器 / Update state and notify listeners
  void _updateState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  /// 邮箱密码登录 / Sign in with email and password
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      _updateState(_state.copyWith(
        status: UserStatus.authenticating,
        isLoading: true,
        error: null,
      ));

      await FirebaseAuthService.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 状态更新由监听器处理 / State update handled by listener
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        status: UserStatus.authenticationFailed,
        error: error,
        isLoading: false,
      ));
    }
  }

  /// 邮箱密码注册 / Sign up with email and password
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      _updateState(_state.copyWith(
        status: UserStatus.authenticating,
        isLoading: true,
        error: null,
      ));

      await FirebaseAuthService.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 状态更新由监听器处理 / State update handled by listener
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        status: UserStatus.authenticationFailed,
        error: error,
        isLoading: false,
      ));
    }
  }

  /// Google登录 / Sign in with Google
  Future<void> signInWithGoogle({
    required GoogleAuthConfig config,
  }) async {
    try {
      _updateState(_state.copyWith(
        status: UserStatus.authenticating,
        isLoading: true,
        error: null,
        provider: 'google',
      ));

      await FirebaseAuthService.instance.signInWithGoogle(config: config);

      // 状态更新由监听器处理 / State update handled by listener
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        status: UserStatus.authenticationFailed,
        error: error,
        isLoading: false,
      ));
    }
  }

  /// Facebook登录 / Sign in with Facebook
  Future<void> signInWithFacebook({
    required FacebookAuthConfig config,
  }) async {
    try {
      _updateState(_state.copyWith(
        status: UserStatus.authenticating,
        isLoading: true,
        error: null,
        provider: 'facebook',
      ));

      await FirebaseAuthService.instance.signInWithFacebook(config: config);

      // 状态更新由监听器处理 / State update handled by listener
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        status: UserStatus.authenticationFailed,
        error: error,
        isLoading: false,
      ));
    }
  }

  /// 手机号登录 / Sign in with phone number
  Future<void> signInWithPhone({
    required String phoneNumber,
    required PhoneAuthConfig config,
  }) async {
    try {
      _updateState(_state.copyWith(
        status: UserStatus.authenticating,
        isLoading: true,
        error: null,
        provider: 'phone',
      ));

      await FirebaseAuthService.instance.signInWithPhoneNumber(
        phoneNumber: phoneNumber,
        config: config,
      );

      // 状态更新由监听器处理 / State update handled by listener
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        status: UserStatus.authenticationFailed,
        error: error,
        isLoading: false,
      ));
    }
  }

  /// 匿名登录 / Sign in anonymously
  Future<void> signInAnonymously() async {
    try {
      _updateState(_state.copyWith(
        status: UserStatus.authenticating,
        isLoading: true,
        error: null,
        provider: 'anonymous',
      ));

      await FirebaseAuthService.instance.signInAnonymously();

      // 状态更新由监听器处理 / State update handled by listener
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        status: UserStatus.authenticationFailed,
        error: error,
        isLoading: false,
      ));
    }
  }

  /// 退出登录 / Sign out
  Future<void> signOut() async {
    try {
      _updateState(_state.copyWith(isLoading: true));
      await FirebaseAuthService.instance.signOut();
      // 状态更新由监听器处理 / State update handled by listener
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        error: error,
        isLoading: false,
      ));
    }
  }

  /// 删除账户 / Delete account
  Future<void> deleteAccount() async {
    try {
      _updateState(_state.copyWith(isLoading: true));
      await FirebaseAuthService.instance.deleteAccount();
      // 状态更新由监听器处理 / State update handled by listener
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        error: error,
        isLoading: false,
      ));
    }
  }

  /// 发送密码重置邮件 / Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      _updateState(_state.copyWith(isLoading: true));
      await FirebaseAuthService.instance.sendPasswordResetEmail(email);
      _updateState(_state.copyWith(isLoading: false));
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        error: error,
        isLoading: false,
      ));
    }
  }

  /// 更新用户资料 / Update user profile
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      _updateState(_state.copyWith(isLoading: true));
      await FirebaseAuthService.instance.updateUserProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
      // 状态更新由监听器处理 / State update handled by listener
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        error: error,
        isLoading: false,
      ));
    }
  }

  /// 清除错误 / Clear error
  void clearError() {
    _updateState(_state.copyWith(error: null));
  }

  /// 处理认证错误 / Handle authentication error
  AuthError _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      return AuthError.fromFirebaseException(error);
    } else {
      return AuthError.fromException(error);
    }
  }
} 