import 'package:firebase_auth_kit/firebase_auth_kit.dart';
import 'package:google_sign_in/google_sign_in.dart' as g;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/foundation.dart' show kIsWeb;

/// GoogleSignInProvider 的实际实现
class MyGoogleSignInProvider implements GoogleSignInProvider {
  g.GoogleSignIn? _googleSignIn;
  GoogleAuthConfig? _config;
  bool _isInitialized = false;

  /// 获取配置的 Client ID
  String? get clientId => _config?.webClientId;

  @override
  Future<void> initialize(GoogleAuthConfig config) async {
    if (_isInitialized) return;
    
    try {
      _config = config;
      
      // 根据平台选择合适的 clientId / Select the appropriate clientId based on the platform
      // 支持 Web、Android、iOS 平台 / Support Web, Android, iOS platforms
      String? clientId;
      if (kIsWeb) {
        // Web 平台 / Web platform
        clientId = config.webClientId;
      } else {
        // 非 Web 平台，判断是 Android 还是 iOS / Non-web platform, check Android or iOS
        if (defaultTargetPlatform == TargetPlatform.android) {
          clientId = config.androidClientId;
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          clientId = config.iosClientId;
        } else {
          clientId = config.webClientId; // 兜底
        }
      }
      
      _googleSignIn = g.GoogleSignIn(
        clientId: clientId,
        scopes: ['email', 'profile'],
      );
      
      _isInitialized = true;
    } catch (e) {
      throw Exception('Google 登录提供者初始化失败: $e');
    }
  }

  @override
  Future<GoogleSignInAccount?> signIn() async {
    if (!_isInitialized) {
      throw Exception('Google 登录提供者未初始化，请先调用 initialize()');
    }
    
    final account = await _googleSignIn!.signIn();
    if (account == null) return null;
    final auth = await account.authentication;
    // 用 kit 的 GoogleSignInAccount 包装
    return GoogleSignInAccount(
      id: account.id,
      email: account.email,
      displayName: account.displayName,
      photoUrl: account.photoUrl,
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
  }

  @override
  Future<GoogleSignInAccount?> signInSilently() async {
    if (!_isInitialized) {
      throw Exception('Google 登录提供者未初始化，请先调用 initialize()');
    }
    
    final account = await _googleSignIn!.signInSilently();
    if (account == null) return null;
    final auth = await account.authentication;
    return GoogleSignInAccount(
      id: account.id,
      email: account.email,
      displayName: account.displayName,
      photoUrl: account.photoUrl,
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
  }

  @override
  Future<void> signOut() async {
    if (!_isInitialized) {
      throw Exception('Google 登录提供者未初始化，请先调用 initialize()');
    }
    
    await _googleSignIn!.signOut();
  }

  @override
  Future<GoogleSignInAccount?> getCurrentUser() async {
    if (!_isInitialized) {
      throw Exception('Google 登录提供者未初始化，请先调用 initialize()');
    }
    
    final account = await _googleSignIn!.signInSilently();
    if (account == null) return null;
    final auth = await account.authentication;
    return GoogleSignInAccount(
      id: account.id,
      email: account.email,
      displayName: account.displayName,
      photoUrl: account.photoUrl,
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
  }

  @override
  Future<bool> isSignedIn() async {
    if (!_isInitialized) {
      throw Exception('Google 登录提供者未初始化，请先调用 initialize()');
    }
    
    return await _googleSignIn!.isSignedIn();
  }
}