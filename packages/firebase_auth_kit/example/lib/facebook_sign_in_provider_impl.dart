import 'package:firebase_auth_kit/firebase_auth_kit.dart' hide LoginStatus;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

/// Facebook 登录提供者的实际实现 / Facebook Sign-In Provider Implementation
/// 
/// 使用 flutter_facebook_auth 插件实现 Facebook 登录功能
/// Uses flutter_facebook_auth plugin to implement Facebook sign-in functionality
class MyFacebookSignInProvider implements FacebookSignInProvider {
  /// 是否已初始化 / Whether initialized
  bool _isInitialized = false;
  
  /// 存储的配置 / Stored configuration
  FacebookAuthConfig? _config;

  /// 初始化 / Initialize
  @override
  Future<void> initialize(FacebookAuthConfig config) async {
    if (_isInitialized) return;
    
    try {
      _config = config;
      
      // 初始化 Facebook 登录
      await FacebookAuth.instance.logOut();
      _isInitialized = true;
    } catch (e) {
      throw Exception('Facebook 登录初始化失败: $e');
    }
  }

  @override
  Future<FacebookSignInAccount?> signIn() async {
    try {
      if (!_isInitialized) {
        throw Exception('Facebook 登录提供者未初始化，请先调用 initialize()');
      }
      
      // 执行 Facebook 登录
      final result = await FacebookAuth.instance.login(
        permissions: _config?.permissions ?? ['email', 'public_profile'],
      );
      
      if (result.status == LoginStatus.success) {
        // 获取用户信息
        final userData = await FacebookAuth.instance.getUserData(
          fields: 'id,name,email,picture.width(200)',
        );
        
        return FacebookSignInAccount(
          id: userData['id'] as String,
          email: userData['email'] as String?,
          displayName: userData['name'] as String?,
          photoUrl: userData['picture']?['data']?['url'] as String?,
          accessToken: result.accessToken?.token,
          permissions: [], // AccessToken 没有 permissions 属性，使用空列表
          userData: userData,
        );
      }
      
      return null;
    } catch (e) {
      print('Facebook 登录失败 / Facebook sign-in failed: $e');
      return null;
    }
  }

  @override
  Future<FacebookSignInAccount?> signInSilently() async {
    try {
      if (!_isInitialized) {
        throw Exception('Facebook 登录提供者未初始化，请先调用 initialize()');
      }
      
      // 检查是否已登录
      if (await isSignedIn()) {
        return await getCurrentUser();
      }
      
      return null;
    } catch (e) {
      print('Facebook 静默登录失败 / Facebook silent sign-in failed: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (!_isInitialized) {
        throw Exception('Facebook 登录提供者未初始化，请先调用 initialize()');
      }
      
      await FacebookAuth.instance.logOut();
    } catch (e) {
      print('Facebook 退出登录失败 / Facebook sign-out failed: $e');
    }
  }

  @override
  Future<FacebookSignInAccount?> getCurrentUser() async {
    try {
      if (!_isInitialized) {
        throw Exception('Facebook 登录提供者未初始化，请先调用 initialize()');
      }
      
      if (!await isSignedIn()) {
        return null;
      }
      
      // 获取当前用户信息
      final userData = await FacebookAuth.instance.getUserData(
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
      print('获取 Facebook 当前用户失败 / Get Facebook current user failed: $e');
      return null;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      if (!_isInitialized) {
        throw Exception('Facebook 登录提供者未初始化，请先调用 initialize()');
      }
      
      // 使用 getUserData 来检查是否已登录
      await FacebookAuth.instance.getUserData();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<String>> getPermissions() async {
    try {
      if (!_isInitialized) {
        throw Exception('Facebook 登录提供者未初始化，请先调用 initialize()');
      }
      
      if (!await isSignedIn()) {
        return [];
      }
      
      final result = await FacebookAuth.instance.getUserData();
      return result['permissions'] as List<String>? ?? [];
    } catch (e) {
      print('获取 Facebook 权限失败 / Get Facebook permissions failed: $e');
      return [];
    }
  }

  @override
  Future<bool> requestPermissions(List<String> permissions) async {
    try {
      if (!_isInitialized) {
        throw Exception('Facebook 登录提供者未初始化，请先调用 initialize()');
      }
      
      final result = await FacebookAuth.instance.login(
        permissions: permissions,
      );
      
      return result.status == LoginStatus.success;
    } catch (e) {
      print('请求 Facebook 权限失败 / Request Facebook permissions failed: $e');
      return false;
    }
  }
} 