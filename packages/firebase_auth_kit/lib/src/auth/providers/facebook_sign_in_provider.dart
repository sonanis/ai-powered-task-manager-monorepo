import '../../config/auth_platform_config.dart';

/// Facebook 登录提供者接口 / Facebook Sign-In Provider Interface
/// 
/// 定义 Facebook 登录的标准接口，使用者可以实现自己的 Facebook 登录逻辑
/// Define the standard interface for Facebook sign-in, allowing users to implement their own Facebook sign-in logic
abstract class FacebookSignInProvider {
  /// 初始化 Facebook 登录提供者 / Initialize Facebook Sign-In Provider
  /// 
  /// 使用配置初始化提供者，设置必要的参数
  /// Initialize the provider with configuration, setting necessary parameters
  Future<void> initialize(FacebookAuthConfig config);
  
  /// 执行 Facebook 登录 / Perform Facebook sign-in
  /// 
  /// 返回 Facebook 用户账户，如果用户取消则返回 null
  /// Returns Facebook user account, or null if user cancels
  Future<FacebookSignInAccount?> signIn();
  
  /// 静默登录 / Silent sign-in
  /// 
  /// 尝试获取当前已登录的 Facebook 用户，不显示登录界面
  /// Attempts to get the currently signed-in Facebook user without showing the sign-in UI
  Future<FacebookSignInAccount?> signInSilently();
  
  /// 退出 Facebook 登录 / Sign out from Facebook
  /// 
  /// 清除当前的 Facebook 登录状态
  /// Clears the current Facebook sign-in state
  Future<void> signOut();
  
  /// 获取当前用户 / Get current user
  /// 
  /// 返回当前已登录的 Facebook 用户，如果没有登录则返回 null
  /// Returns the currently signed-in Facebook user, or null if not signed in
  Future<FacebookSignInAccount?> getCurrentUser();
  
  /// 检查是否已登录 / Check if signed in
  /// 
  /// 返回当前是否有活跃的 Facebook 登录会话
  /// Returns whether there is an active Facebook sign-in session
  Future<bool> isSignedIn();
  
  /// 获取用户权限 / Get user permissions
  /// 
  /// 返回当前用户授予的权限列表
  /// Returns the list of permissions granted by the current user
  Future<List<String>> getPermissions();
  
  /// 请求额外权限 / Request additional permissions
  /// 
  /// 向用户请求额外的权限
  /// Request additional permissions from the user
  Future<bool> requestPermissions(List<String> permissions);
}

/// Facebook 登录账户模型 / Facebook Sign-In Account Model
/// 
/// 模拟 FacebookSignInAccount 的基本属性，避免直接依赖 flutter_facebook_auth 包
/// Simulates basic properties of FacebookSignInAccount to avoid direct dependency on flutter_facebook_auth package
class FacebookSignInAccount {
  /// 用户 ID / User ID
  final String id;
  
  /// 邮箱地址 / Email address
  final String? email;
  
  /// 显示名称 / Display name
  final String? displayName;
  
  /// 头像 URL / Photo URL
  final String? photoUrl;
  
  /// 访问令牌 / Access token
  final String? accessToken;
  
  /// 用户权限 / User permissions
  final List<String> permissions;
  
  /// 用户数据 / User data
  final Map<String, dynamic> userData;

  const FacebookSignInAccount({
    required this.id,
    this.email,
    this.displayName,
    this.photoUrl,
    this.accessToken,
    this.permissions = const [],
    this.userData = const {},
  });

  /// 从 JSON 创建 / Create from JSON
  factory FacebookSignInAccount.fromJson(Map<String, dynamic> json) {
    return FacebookSignInAccount(
      id: json['id'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      accessToken: json['accessToken'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)?.cast<String>() ?? [],
      userData: json['userData'] as Map<String, dynamic>? ?? {},
    );
  }

  /// 转换为 JSON / Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'accessToken': accessToken,
      'permissions': permissions,
      'userData': userData,
    };
  }

  @override
  String toString() {
    return 'FacebookSignInAccount(id: $id, email: $email, displayName: $displayName)';
  }
} 