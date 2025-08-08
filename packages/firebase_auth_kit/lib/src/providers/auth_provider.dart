import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/firebase_auth_service.dart';
import '../config/auth_platform_config.dart';
import '../models/auth_models.dart';

/// 认证状态提供者 / Authentication State Provider
/// 
/// 使用 Provider 模式管理认证状态
/// Uses Provider pattern to manage authentication state
class AuthProvider extends ChangeNotifier {
  /// 当前认证状态 / Current authentication state
  AuthState _state = const AuthState();
  
  /// 获取当前状态 / Get current state
  AuthState get state => _state;
  
  /// 获取当前用户 / Get current user
  User? get currentUser => _state.user;
  
  /// 获取认证状态 / Get authentication status
  UserStatus get status => _state.status;
  
  /// 获取是否正在加载 / Get loading state
  bool get isLoading => _state.isLoading;
  
  /// 获取错误信息 / Get error message
  AuthError? get error => _state.error;
  
  /// 获取当前登录提供者 / Get current provider
  String? get provider => _state.provider;

  AuthProvider() {
    // 监听 Firebase Auth 状态变化
    FirebaseAuthService.instance.authStateChanges.listen(_onAuthStateChanged);
  }

  /// 处理认证状态变化 / Handle authentication state changes
  void _onAuthStateChanged(User? user) {
    if (user != null) {
      _updateState(_state.copyWith(
        user: user,
        status: UserStatus.authenticated,
        isLoading: false,
        error: null,
      ));
    } else {
      _updateState(_state.copyWith(
        user: null,
        status: UserStatus.unauthenticated,
        isLoading: false,
        error: null,
      ));
    }
  }

  /// 更新状态 / Update state
  void _updateState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  /// 处理认证错误 / Handle authentication errors
  AuthError _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      return AuthError.fromFirebaseException(error);
    }
    return AuthError.fromException(error);
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
  Future<void> signInWithGoogle() async {
    try {
      _updateState(_state.copyWith(
        status: UserStatus.authenticating,
        isLoading: true,
        error: null,
        provider: 'google',
      ));

      await FirebaseAuthService.instance.signInWithGoogle();

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

  /// GitHub登录 / Sign in with GitHub
  Future<void> signInWithGitHub({
    required GitHubAuthConfig config,
  }) async {
    try {
      _updateState(_state.copyWith(
        status: UserStatus.authenticating,
        isLoading: true,
        error: null,
        provider: 'github',
      ));

      await FirebaseAuthService.instance.signInWithGitHub(config: config);

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
      _updateState(_state.copyWith(
        isLoading: true,
        error: null,
      ));

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
      _updateState(_state.copyWith(
        isLoading: true,
        error: null,
      ));

      await FirebaseAuthService.instance.deleteUser();

      // 状态更新由监听器处理 / State update handled by listener
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        error: error,
        isLoading: false,
      ));
    }
  }

  /// 更新用户资料 / Update user profile
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      _updateState(_state.copyWith(
        isLoading: true,
        error: null,
      ));

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

  /// 更新邮箱 / Update email
  Future<void> updateEmail(String email) async {
    try {
      _updateState(_state.copyWith(
        isLoading: true,
        error: null,
      ));

      await FirebaseAuthService.instance.updateEmail(email);

      // 状态更新由监听器处理 / State update handled by listener
    } catch (e) {
      final error = _handleAuthError(e);
      _updateState(_state.copyWith(
        error: error,
        isLoading: false,
      ));
    }
  }

  /// 更新密码 / Update password
  Future<void> updatePassword(String password) async {
    try {
      _updateState(_state.copyWith(
        isLoading: true,
        error: null,
      ));

      await FirebaseAuthService.instance.updatePassword(password);

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
      _updateState(_state.copyWith(
        isLoading: true,
        error: null,
      ));

      await FirebaseAuthService.instance.sendPasswordResetEmail(email);

      _updateState(_state.copyWith(
        isLoading: false,
      ));
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

  /// 重置状态 / Reset state
  void reset() {
    _updateState(const AuthState());
  }
}

/// 创建认证Provider / Create authentication provider
/// 
/// 便利函数，用于快速创建 AuthProvider 的 ChangeNotifierProvider
/// Convenience function for quickly creating a ChangeNotifierProvider for AuthProvider
ChangeNotifierProvider<AuthProvider> createAuthProvider() {
  return ChangeNotifierProvider<AuthProvider>(
    create: (context) => AuthProvider(),
  );
} 