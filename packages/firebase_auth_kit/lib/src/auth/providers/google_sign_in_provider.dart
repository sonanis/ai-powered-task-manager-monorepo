/// Google 登录提供者接口 / Google Sign-In Provider Interface
/// 
/// 定义 Google 登录的标准接口，使用者可以实现自己的 Google 登录逻辑
/// Define the standard interface for Google sign-in, allowing users to implement their own Google sign-in logic
abstract class GoogleSignInProvider {
  /// 执行 Google 登录 / Perform Google sign-in
  /// 
  /// 返回 Google 用户账户，如果用户取消则返回 null
  /// Returns Google user account, or null if user cancels
  Future<GoogleSignInAccount?> signIn();
  
  /// 静默登录 / Silent sign-in
  /// 
  /// 尝试获取当前已登录的 Google 用户，不显示登录界面
  /// Attempts to get the currently signed-in Google user without showing the sign-in UI
  Future<GoogleSignInAccount?> signInSilently();
  
  /// 退出 Google 登录 / Sign out from Google
  /// 
  /// 清除当前的 Google 登录状态
  /// Clears the current Google sign-in state
  Future<void> signOut();
  
  /// 获取当前用户 / Get current user
  /// 
  /// 返回当前已登录的 Google 用户，如果没有登录则返回 null
  /// Returns the currently signed-in Google user, or null if not signed in
  Future<GoogleSignInAccount?> getCurrentUser();
  
  /// 检查是否已登录 / Check if signed in
  /// 
  /// 返回当前是否有活跃的 Google 登录会话
  /// Returns whether there is an active Google sign-in session
  Future<bool> isSignedIn();
}

/// Google 登录账户模型 / Google Sign-In Account Model
/// 
/// 模拟 GoogleSignInAccount 的基本属性，避免直接依赖 google_sign_in 包
/// Simulates basic properties of GoogleSignInAccount to avoid direct dependency on google_sign_in package
class GoogleSignInAccount {
  /// 用户 ID / User ID
  final String id;
  
  /// 邮箱地址 / Email address
  final String email;
  
  /// 显示名称 / Display name
  final String? displayName;
  
  /// 头像 URL / Photo URL
  final String? photoUrl;
  
  /// 服务器认证代码 / Server auth code
  final String? serverAuthCode;
  
  /// 访问令牌 / Access token
  final String? accessToken;
  
  /// ID 令牌 / ID token
  final String? idToken;

  const GoogleSignInAccount({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.serverAuthCode,
    this.accessToken,
    this.idToken,
  });

  /// 从 JSON 创建 / Create from JSON
  factory GoogleSignInAccount.fromJson(Map<String, dynamic> json) {
    return GoogleSignInAccount(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      serverAuthCode: json['serverAuthCode'] as String?,
      accessToken: json['accessToken'] as String?,
      idToken: json['idToken'] as String?,
    );
  }

  /// 转换为 JSON / Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'serverAuthCode': serverAuthCode,
      'accessToken': accessToken,
      'idToken': idToken,
    };
  }

  @override
  String toString() {
    return 'GoogleSignInAccount(id: $id, email: $email, displayName: $displayName)';
  }
} 