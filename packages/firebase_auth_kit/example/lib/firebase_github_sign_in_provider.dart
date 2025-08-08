import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_kit/firebase_auth_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Firebase GitHub 登录提供者实现 / Firebase GitHub Sign-In Provider Implementation
/// 
/// 使用 Firebase Auth 的 GithubAuthProvider 实现 GitHub 登录功能
/// Uses Firebase Auth's GithubAuthProvider to implement GitHub sign-in functionality
class FirebaseGitHubSignInProvider implements GitHubSignInProvider {
  /// 是否已初始化 / Whether initialized
  bool _isInitialized = false;
  
  /// Firebase Auth 实例 / Firebase Auth instance
  late final FirebaseAuth _auth;
  
  /// GitHub 认证提供者 / GitHub Auth Provider
  late final GithubAuthProvider _githubProvider;

  /// 初始化 / Initialize
  @override
  Future<void> initialize(GitHubAuthConfig config) async {
    if (_isInitialized) return;
    
    try {
      _auth = FirebaseAuth.instance;
      _githubProvider = GithubAuthProvider();
      
      // 设置 GitHub 提供者的自定义参数
      _githubProvider.addScope('read:user');
      _githubProvider.addScope('user:email');
      
      // 设置 GitHub OAuth 配置
      _githubProvider.setCustomParameters({
        'client_id': config.clientId,
        'client_secret': config.clientSecret,
        if (config.redirectUri != null) 'redirect_uri': config.redirectUri!,
      });
      
      _isInitialized = true;
    } catch (e) {
      throw Exception('Firebase GitHub 登录初始化失败: $e');
    }
  }

  @override
  Future<GitHubSignInAccount?> signIn() async {
    try {
      if (!_isInitialized) {
        throw Exception('GitHub 登录提供者未初始化，请先调用 initialize()');
      }
      
      UserCredential? userCredential;
      
      if (kIsWeb) {
        // Web 端使用弹窗登录 / Web platform uses popup sign-in
        userCredential = await _auth.signInWithPopup(_githubProvider);
      } else {
        // 移动端使用重定向登录 / Mobile platform uses redirect sign-in
        userCredential = await _auth.signInWithProvider(_githubProvider);
      }
      
      if (userCredential.user != null) {
        final user = userCredential.user!;
        final credential = userCredential.credential as OAuthCredential?;
        
        // 获取 GitHub 用户信息
        final userData = await _getGitHubUserData(credential?.accessToken);
        
        return GitHubSignInAccount(
          id: user.uid,
          login: userData['login'] as String? ?? user.displayName ?? 'unknown',
          email: user.email,
          name: user.displayName,
          avatarUrl: user.photoURL,
          accessToken: credential?.accessToken,
          permissions: ['read:user', 'user:email'],
          userData: userData,
        );
      }
      
      return null;
    } catch (e) {
      print('Firebase GitHub 登录失败 / Firebase GitHub sign-in failed: $e');
      return null;
    }
  }

  @override
  Future<GitHubSignInAccount?> signInSilently() async {
    try {
      if (!_isInitialized) {
        throw Exception('GitHub 登录提供者未初始化，请先调用 initialize()');
      }
      
      // 检查是否已登录
      if (await isSignedIn()) {
        return await getCurrentUser();
      }
      
      return null;
    } catch (e) {
      print('Firebase GitHub 静默登录失败 / Firebase GitHub silent sign-in failed: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (!_isInitialized) {
        throw Exception('GitHub 登录提供者未初始化，请先调用 initialize()');
      }
      
      // Firebase Auth 会自动处理退出登录
      // 如果需要，可以在这里添加额外的清理逻辑
      print('Firebase GitHub 退出登录 / Firebase GitHub sign-out');
    } catch (e) {
      print('Firebase GitHub 退出登录失败 / Firebase GitHub sign-out failed: $e');
    }
  }

  @override
  Future<GitHubSignInAccount?> getCurrentUser() async {
    try {
      if (!_isInitialized) {
        throw Exception('GitHub 登录提供者未初始化，请先调用 initialize()');
      }
      
      final user = _auth.currentUser;
      if (user == null) {
        return null;
      }
      
      // 检查用户是否通过 GitHub 登录
      final providerData = user.providerData;
      final githubProvider = providerData.where((p) => p.providerId == 'github.com').firstOrNull;
      
      if (githubProvider == null) {
        return null;
      }
      
      return GitHubSignInAccount(
        id: user.uid,
        login: githubProvider.displayName ?? user.displayName ?? 'unknown',
        email: user.email,
        name: user.displayName,
        avatarUrl: user.photoURL,
        accessToken: null, // Firebase 不直接提供访问令牌
        permissions: ['read:user', 'user:email'],
        userData: {
          'uid': user.uid,
          'email': user.email,
          'displayName': user.displayName,
          'photoURL': user.photoURL,
          'providerId': githubProvider.providerId,
        },
      );
    } catch (e) {
      print('获取 Firebase GitHub 当前用户失败 / Get Firebase GitHub current user failed: $e');
      return null;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      if (!_isInitialized) {
        throw Exception('GitHub 登录提供者未初始化，请先调用 initialize()');
      }
      
      final user = _auth.currentUser;
      if (user == null) {
        return false;
      }
      
      // 检查用户是否通过 GitHub 登录
      final providerData = user.providerData;
      return providerData.any((p) => p.providerId == 'github.com');
    } catch (e) {
      print('检查 Firebase GitHub 登录状态失败 / Check Firebase GitHub sign-in status failed: $e');
      return false;
    }
  }

  @override
  Future<List<String>> getPermissions() async {
    try {
      if (!await isSignedIn()) {
        return [];
      }
      
      // 返回默认权限
      return ['read:user', 'user:email'];
    } catch (e) {
      print('获取 Firebase GitHub 权限失败 / Get Firebase GitHub permissions failed: $e');
      return [];
    }
  }

  @override
  Future<bool> requestPermissions(List<String> permissions) async {
    try {
      // Firebase Auth 在登录时已经请求了权限，这里返回成功
      return true;
    } catch (e) {
      print('请求 Firebase GitHub 权限失败 / Request Firebase GitHub permissions failed: $e');
      return false;
    }
  }

  /// 获取 GitHub 用户数据 / Get GitHub user data
  Future<Map<String, dynamic>> _getGitHubUserData(String? accessToken) async {
    try {
      if (accessToken == null) {
        return {};
      }
      
      // 使用 GitHub API 获取用户信息
      final response = await _fetchGitHubUserData(accessToken);
      return response;
    } catch (e) {
      print('获取 GitHub 用户数据失败 / Get GitHub user data failed: $e');
      return {};
    }
  }

  /// 从 GitHub API 获取用户数据 / Fetch user data from GitHub API
  Future<Map<String, dynamic>> _fetchGitHubUserData(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.github.com/user'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/vnd.github.v3+json',
        },
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('GitHub API 请求失败，状态码: ${response.statusCode} / GitHub API request failed with status code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('从 GitHub API 获取用户数据失败 / Fetch user data from GitHub API failed: $e');
      return {};
    }
  }
} 