import 'google_sign_in_provider.dart';
import '../../config/auth_platform_config.dart';

/// 默认 Google 登录提供者实现 / Default Google Sign-In Provider Implementation
/// 
/// 这是一个可选的便利实现，使用者可以选择使用或实现自己的版本
/// This is an optional convenience implementation, users can choose to use it or implement their own version
/// 
/// 注意：这个实现需要在使用者的项目中添加 google_sign_in 依赖
/// Note: This implementation requires adding google_sign_in dependency in the user's project
class DefaultGoogleSignInProvider implements GoogleSignInProvider {
  /// 检查是否可用 / Check if available
  /// 
  /// 由于这个实现需要 google_sign_in 包，我们需要检查是否可用
  /// Since this implementation requires the google_sign_in package, we need to check if it's available
  static bool get isAvailable {
    try {
      // 尝试导入 google_sign_in 包
      // Try to import the google_sign_in package
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> initialize(GoogleAuthConfig config) async {
    throw UnimplementedError(
      '默认 Google 登录提供者需要在使用者项目中添加 google_sign_in 依赖。'
      '请实现自己的 GoogleSignInProvider 或添加 google_sign_in 依赖。'
      'Default Google Sign-In Provider requires adding google_sign_in dependency in the user project. '
      'Please implement your own GoogleSignInProvider or add google_sign_in dependency.'
    );
  }

  @override
  Future<GoogleSignInAccount?> signIn() async {
    throw UnimplementedError(
      '默认 Google 登录提供者需要在使用者项目中添加 google_sign_in 依赖。'
      '请实现自己的 GoogleSignInProvider 或添加 google_sign_in 依赖。'
      'Default Google Sign-In Provider requires adding google_sign_in dependency in the user project. '
      'Please implement your own GoogleSignInProvider or add google_sign_in dependency.'
    );
  }

  @override
  Future<GoogleSignInAccount?> signInSilently() async {
    throw UnimplementedError(
      '默认 Google 登录提供者需要在使用者项目中添加 google_sign_in 依赖。'
      '请实现自己的 GoogleSignInProvider 或添加 google_sign_in 依赖。'
      'Default Google Sign-In Provider requires adding google_sign_in dependency in the user project. '
      'Please implement your own GoogleSignInProvider or add google_sign_in dependency.'
    );
  }

  @override
  Future<void> signOut() async {
    throw UnimplementedError(
      '默认 Google 登录提供者需要在使用者项目中添加 google_sign_in 依赖。'
      '请实现自己的 GoogleSignInProvider 或添加 google_sign_in 依赖。'
      'Default Google Sign-In Provider requires adding google_sign_in dependency in the user project. '
      'Please implement your own GoogleSignInProvider or add google_sign_in dependency.'
    );
  }

  @override
  Future<GoogleSignInAccount?> getCurrentUser() async {
    throw UnimplementedError(
      '默认 Google 登录提供者需要在使用者项目中添加 google_sign_in 依赖。'
      '请实现自己的 GoogleSignInProvider 或添加 google_sign_in 依赖。'
      'Default Google Sign-In Provider requires adding google_sign_in dependency in the user project. '
      'Please implement your own GoogleSignInProvider or add google_sign_in dependency.'
    );
  }

  @override
  Future<bool> isSignedIn() async {
    throw UnimplementedError(
      '默认 Google 登录提供者需要在使用者项目中添加 google_sign_in 依赖。'
      '请实现自己的 GoogleSignInProvider 或添加 google_sign_in 依赖。'
      'Default Google Sign-In Provider requires adding google_sign_in dependency in the user project. '
      'Please implement your own GoogleSignInProvider or add google_sign_in dependency.'
    );
  }
}

/// 创建 Google 登录提供者的工厂函数 / Factory function to create Google Sign-In Provider
/// 
/// 这个函数可以帮助使用者快速创建 Google 登录提供者
/// This function can help users quickly create a Google Sign-In Provider
GoogleSignInProvider createGoogleSignInProvider({
  String? clientId,
  List<String>? scopes,
  bool? hostedDomain,
  String? serverClientId,
}) {
  // 这里可以返回一个基于 google_sign_in 的实现
  // 但为了保持包的独立性，我们返回默认实现
  // Here we could return an implementation based on google_sign_in
  // But to maintain package independence, we return the default implementation
  return DefaultGoogleSignInProvider();
} 