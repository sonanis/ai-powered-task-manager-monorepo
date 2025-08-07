import 'facebook_sign_in_provider.dart';
import '../../core/logger.dart';

/// 默认 Facebook 登录提供者实现 / Default Facebook Sign-In Provider Implementation
/// 
/// 使用 flutter_facebook_auth 插件实现 Facebook 登录功能
/// Uses flutter_facebook_auth plugin to implement Facebook sign-in functionality
class DefaultFacebookSignInProvider implements FacebookSignInProvider {
  /// 是否已初始化 / Whether initialized
  bool _isInitialized = false;
  
  /// 动态导入 flutter_facebook_auth / Dynamic import of flutter_facebook_auth
  dynamic get _facebookAuth {
    // 这里使用动态导入，避免在包中添加依赖
    // Using dynamic import to avoid adding dependency to the package
    try {
      return _getFacebookAuthInstance();
    } catch (e) {
      throw Exception('flutter_facebook_auth 插件未安装，请添加依赖: flutter_facebook_auth: ^6.1.1');
    }
  }
  
  /// 获取 Facebook Auth 实例 / Get Facebook Auth instance
  dynamic _getFacebookAuthInstance() {
    // 这里需要使用者提供具体的实现
    // Users need to provide specific implementation
    throw UnimplementedError('需要实现 _getFacebookAuthInstance() 方法');
  }

  /// 初始化 / Initialize
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // 初始化 Facebook 登录
      await _facebookAuth.logOut();
      _isInitialized = true;
    } catch (e) {
      Log.e('Facebook 登录初始化失败 / Facebook sign-in initialization failed', error: e);
      throw Exception('Facebook 登录初始化失败: $e');
    }
  }

  @override
  Future<FacebookSignInAccount?> signIn() async {
    try {
      await initialize();
      
      // 执行 Facebook 登录
      final result = await _facebookAuth.login(
        permissions: ['email', 'public_profile'],
      );
      
      if (result.status == LoginStatus.success) {
        // 获取用户信息
        final userData = await _facebookAuth.getUserData(
          fields: 'id,name,email,picture.width(200)',
        );
        
        return FacebookSignInAccount(
          id: userData['id'] as String,
          email: userData['email'] as String?,
          displayName: userData['name'] as String?,
          photoUrl: userData['picture']?['data']?['url'] as String?,
          accessToken: result.accessToken?.token,
          permissions: result.accessToken?.permissions ?? [],
          userData: userData,
        );
      }
      
      return null;
    } catch (e) {
      Log.e('Facebook 登录失败 / Facebook sign-in failed', error: e);
      return null;
    }
  }

  @override
  Future<FacebookSignInAccount?> signInSilently() async {
    try {
      await initialize();
      
      // 检查是否已登录
      if (await isSignedIn()) {
        return await getCurrentUser();
      }
      
      return null;
    } catch (e) {
      Log.e('Facebook 静默登录失败 / Facebook silent sign-in failed', error: e);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _facebookAuth.logOut();
    } catch (e) {
      Log.e('Facebook 退出登录失败 / Facebook sign-out failed', error: e);
    }
  }

  @override
  Future<FacebookSignInAccount?> getCurrentUser() async {
    try {
      if (!await isSignedIn()) {
        return null;
      }
      
      // 获取当前用户信息
      final userData = await _facebookAuth.getUserData(
        fields: 'id,name,email,picture.width(200)',
      );
      
      return FacebookSignInAccount(
        id: userData['id'] as String,
        email: userData['email'] as String?,
        displayName: userData['name'] as String?,
        photoUrl: userData['picture']?['data']?['url'] as String?,
        userData: userData,
      );
    } catch (e) {
      Log.e('获取 Facebook 当前用户失败 / Get Facebook current user failed', error: e);
      return null;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      final result = await _facebookAuth.isLoggedIn;
      return result;
    } catch (e) {
      Log.e('检查 Facebook 登录状态失败 / Check Facebook sign-in status failed', error: e);
      return false;
    }
  }

  @override
  Future<List<String>> getPermissions() async {
    try {
      if (!await isSignedIn()) {
        return [];
      }
      
      final result = await _facebookAuth.getUserData();
      return result['permissions'] as List<String>? ?? [];
    } catch (e) {
      Log.e('获取 Facebook 权限失败 / Get Facebook permissions failed', error: e);
      return [];
    }
  }

  @override
  Future<bool> requestPermissions(List<String> permissions) async {
    try {
      final result = await _facebookAuth.login(
        permissions: permissions,
      );
      
      return result.status == LoginStatus.success;
    } catch (e) {
      Log.e('请求 Facebook 权限失败 / Request Facebook permissions failed', error: e);
      return false;
    }
  }
}

/// Facebook 登录状态枚举 / Facebook Login Status Enum
enum LoginStatus {
  /// 成功 / Success
  success,
  
  /// 取消 / Cancelled
  cancelled,
  
  /// 失败 / Failed
  failed,
}

/// Facebook 访问令牌模型 / Facebook Access Token Model
class FacebookAccessToken {
  /// 令牌字符串 / Token string
  final String token;
  
  /// 权限列表 / Permissions list
  final List<String> permissions;
  
  /// 过期时间 / Expiration time
  final DateTime? expiresAt;
  
  /// 应用 ID / Application ID
  final String applicationId;
  
  /// 用户 ID / User ID
  final String userId;

  const FacebookAccessToken({
    required this.token,
    required this.permissions,
    this.expiresAt,
    required this.applicationId,
    required this.userId,
  });
} 