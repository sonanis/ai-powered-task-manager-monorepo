import 'package:firebase_auth/firebase_auth.dart';

/// 用户状态枚举 / User Status Enum
enum UserStatus {
  /// 未认证 / Unauthenticated
  unauthenticated,
  
  /// 认证中 / Authenticating
  authenticating,
  
  /// 已认证 / Authenticated
  authenticated,
  
  /// 认证失败 / Authentication Failed
  authenticationFailed,
}

/// 认证错误类型 / Authentication Error Types
enum AuthErrorType {
  /// 网络错误 / Network Error
  networkError,
  
  /// 无效凭据 / Invalid Credentials
  invalidCredentials,
  
  /// 用户不存在 / User Not Found
  userNotFound,
  
  /// 邮箱已存在 / Email Already In Use
  emailAlreadyInUse,
  
  /// 密码太弱 / Weak Password
  weakPassword,
  
  /// 验证码错误 / Invalid Verification Code
  invalidVerificationCode,
  
  /// 验证码过期 / Code Expired
  codeExpired,
  
  /// 用户被禁用 / User Disabled
  userDisabled,
  
  /// 操作被拒绝 / Operation Not Allowed
  operationNotAllowed,
  
  /// 未知错误 / Unknown Error
  unknown,
}

/// 认证错误模型 / Authentication Error Model
class AuthError {
  /// 错误类型 / Error Type
  final AuthErrorType type;
  
  /// 错误消息 / Error Message
  final String message;
  
  /// 错误代码 / Error Code
  final String? code;
  
  /// 原始错误 / Original Error
  final dynamic originalError;

  const AuthError({
    required this.type,
    required this.message,
    this.code,
    this.originalError,
  });

  /// 从 FirebaseAuthException 创建 / Create from FirebaseAuthException
  factory AuthError.fromFirebaseException(FirebaseAuthException exception) {
    AuthErrorType type;
    String message;

    switch (exception.code) {
      case 'user-not-found':
        type = AuthErrorType.userNotFound;
        message = '用户不存在 / User not found';
        break;
      case 'wrong-password':
      case 'invalid-credential':
        type = AuthErrorType.invalidCredentials;
        message = '邮箱或密码错误 / Invalid email or password';
        break;
      case 'email-already-in-use':
        type = AuthErrorType.emailAlreadyInUse;
        message = '邮箱已被使用 / Email already in use';
        break;
      case 'weak-password':
        type = AuthErrorType.weakPassword;
        message = '密码太弱 / Password too weak';
        break;
      case 'user-disabled':
        type = AuthErrorType.userDisabled;
        message = '账户已被禁用 / Account disabled';
        break;
      case 'operation-not-allowed':
        type = AuthErrorType.operationNotAllowed;
        message = '操作不被允许 / Operation not allowed';
        break;
      default:
        type = AuthErrorType.unknown;
        message = exception.message ?? '未知错误 / Unknown error';
    }

    return AuthError(
      type: type,
      message: message,
      code: exception.code,
      originalError: exception,
    );
  }

  /// 从通用错误创建 / Create from generic exception
  factory AuthError.fromException(dynamic error) {
    return AuthError(
      type: AuthErrorType.unknown,
      message: error.toString(),
      originalError: error,
    );
  }
}

/// 认证状态模型 / Authentication State Model
class AuthState {
  /// 用户状态 / User Status
  final UserStatus status;
  
  /// 当前用户（Firebase User）/ Current User (Firebase User)
  final User? user;
  
  /// 错误信息 / Error Information
  final AuthError? error;
  
  /// 是否正在加载 / Is Loading
  final bool isLoading;
  
  /// 认证提供商 / Authentication Provider
  final String? provider;

  const AuthState({
    this.status = UserStatus.unauthenticated,
    this.user,
    this.error,
    this.isLoading = false,
    this.provider,
  });

  /// 复制并更新 / Copy and update
  AuthState copyWith({
    UserStatus? status,
    User? user,
    AuthError? error,
    bool? isLoading,
    String? provider,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      provider: provider ?? this.provider,
    );
  }

  /// 是否为认证状态 / Is authenticated
  bool get isAuthenticated => status == UserStatus.authenticated && user != null;

  /// 是否为未认证状态 / Is unauthenticated
  bool get isUnauthenticated => status == UserStatus.unauthenticated;

  /// 是否正在认证 / Is authenticating
  bool get isAuthenticating => status == UserStatus.authenticating || isLoading;

  /// 是否有错误 / Has error
  bool get hasError => error != null;

  @override
  String toString() {
    return 'AuthState(status: $status, user: ${user?.uid}, error: $error, isLoading: $isLoading)';
  }
}

/// 用户信息扩展 / User Information Extensions
extension UserExtensions on User {
  /// 获取用户显示名称 / Get user display name
  String get displayNameOrEmail {
    return displayName ?? email ?? '未知用户 / Unknown User';
  }

  /// 获取用户头像URL / Get user avatar URL
  String? get avatarUrl {
    return photoURL;
  }

  /// 检查是否为匿名用户 / Check if user is anonymous
  bool get isAnonymousUser => isAnonymous;

  /// 检查邮箱是否已验证 / Check if email is verified
  bool get isEmailVerified => emailVerified;

  /// 获取用户创建时间 / Get user creation time
  DateTime? get creationTime => metadata.creationTime;

  /// 获取最后登录时间 / Get last sign in time
  DateTime? get lastSignInTime => metadata.lastSignInTime;

  /// 获取认证提供商列表 / Get authentication providers list
  List<String> get providers {
    return providerData.map((p) => p.providerId).toList();
  }

  /// 检查是否通过特定提供商登录 / Check if signed in with specific provider
  bool isSignedInWith(String providerId) {
    return providerData.any((p) => p.providerId == providerId);
  }

  /// 检查是否为Google登录 / Check if Google user
  bool get isGoogleUser => isSignedInWith('google.com');

  /// 检查是否为Facebook登录 / Check if Facebook user
  bool get isFacebookUser => isSignedInWith('facebook.com');

  /// 检查是否为Apple登录 / Check if Apple user
  bool get isAppleUser => isSignedInWith('apple.com');

  /// 检查是否为邮箱密码登录 / Check if email password user
  bool get isEmailPasswordUser => isSignedInWith('password');
} 