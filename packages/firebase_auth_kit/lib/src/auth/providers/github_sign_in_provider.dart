/// GitHub 登录提供者接口 / GitHub Sign-In Provider Interface
/// 
/// 定义 GitHub 登录的标准接口，使用者可以实现自己的 GitHub 登录逻辑
/// Define the standard interface for GitHub sign-in, allowing users to implement their own GitHub sign-in logic
abstract class GitHubSignInProvider {
  /// 执行 GitHub 登录 / Perform GitHub sign-in
  /// 
  /// 返回 GitHub 用户账户，如果用户取消则返回 null
  /// Returns GitHub user account, or null if user cancels
  Future<GitHubSignInAccount?> signIn();
  
  /// 静默登录 / Silent sign-in
  /// 
  /// 尝试获取当前已登录的 GitHub 用户，不显示登录界面
  /// Attempts to get the currently signed-in GitHub user without showing the sign-in UI
  Future<GitHubSignInAccount?> signInSilently();
  
  /// 退出 GitHub 登录 / Sign out from GitHub
  /// 
  /// 清除当前的 GitHub 登录状态
  /// Clears the current GitHub sign-in state
  Future<void> signOut();
  
  /// 获取当前用户 / Get current user
  /// 
  /// 返回当前已登录的 GitHub 用户，如果没有登录则返回 null
  /// Returns the currently signed-in GitHub user, or null if not signed in
  Future<GitHubSignInAccount?> getCurrentUser();
  
  /// 检查是否已登录 / Check if signed in
  /// 
  /// 返回当前是否有活跃的 GitHub 登录会话
  /// Returns whether there is an active GitHub sign-in session
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

/// GitHub 登录账户模型 / GitHub Sign-In Account Model
/// 
/// 模拟 GitHubSignInAccount 的基本属性，避免直接依赖 github_sign_in 包
/// Simulates basic properties of GitHubSignInAccount to avoid direct dependency on github_sign_in package
class GitHubSignInAccount {
  /// 用户 ID / User ID
  final String id;
  
  /// 用户名 / Username
  final String login;
  
  /// 邮箱地址 / Email address
  final String? email;
  
  /// 显示名称 / Display name
  final String? name;
  
  /// 头像 URL / Avatar URL
  final String? avatarUrl;
  
  /// 访问令牌 / Access token
  final String? accessToken;
  
  /// 用户权限 / User permissions
  final List<String> permissions;
  
  /// 用户数据 / User data
  final Map<String, dynamic> userData;

  const GitHubSignInAccount({
    required this.id,
    required this.login,
    this.email,
    this.name,
    this.avatarUrl,
    this.accessToken,
    this.permissions = const [],
    this.userData = const {},
  });

  /// 从 JSON 创建 / Create from JSON
  factory GitHubSignInAccount.fromJson(Map<String, dynamic> json) {
    return GitHubSignInAccount(
      id: json['id'] as String,
      login: json['login'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      accessToken: json['access_token'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)?.cast<String>() ?? [],
      userData: json['user_data'] as Map<String, dynamic>? ?? {},
    );
  }

  /// 转换为 JSON / Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'email': email,
      'name': name,
      'avatar_url': avatarUrl,
      'access_token': accessToken,
      'permissions': permissions,
      'user_data': userData,
    };
  }

  @override
  String toString() {
    return 'GitHubSignInAccount(id: $id, login: $login, email: $email, name: $name)';
  }
} 