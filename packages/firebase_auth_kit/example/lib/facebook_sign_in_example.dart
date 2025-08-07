import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_kit/firebase_auth_kit.dart';
import 'firebase_options.dart';
import 'facebook_sign_in_provider_impl.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'config/env.dart';

class FacebookSignInExample extends StatefulWidget {
  const FacebookSignInExample({super.key});

  @override
  State<FacebookSignInExample> createState() => _FacebookSignInExampleState();
}

class _FacebookSignInExampleState extends State<FacebookSignInExample> {
  String _status = '未登录/Not signed in';
  User? _user;

  // 从环境变量获取 Facebook 配置
  final FirebaseAuthConfig _config = FirebaseAuthConfig(
    facebook: FacebookAuthConfig(
      isEnabled: true,
      appId: Env.facebookAppId,
      appSecret: Env.facebookAppSecret,
      permissions: ['email', 'public_profile'],
    ),
    anonymous: AnonymousAuthConfig(isEnabled: true),
  );

  late final MyFacebookSignInProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = MyFacebookSignInProvider();
    _checkIfAlreadySignedIn();
  }

  Future<void> _checkIfAlreadySignedIn() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        _user = currentUser;
        _status = '已登录/Already signed in';
      });
    } else {
      // 未登录，尝试静默登录
      setState(() {
        _user = null;
        _status = '尝试静默登录/Trying silent sign-in...';
      });
      final facebookUser = await _provider.signInSilently();
      if (facebookUser != null) {
        final credential = FacebookAuthProvider.credential(
          facebookUser.accessToken!,
        );
        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        setState(() {
          _user = userCredential.user;
          _status = '已自动登录/Auto signed in';
        });
      } else {
        setState(() {
          _user = null;
          _status = '未登录/Not signed in';
        });
      }
    }
  }

  Future<void> _signInWithFacebook() async {
    setState(() {
      _status = '登录中/Signing in...';
    });

    try {
      final facebookUser = await _provider.signIn();
      if (facebookUser == null) {
        setState(() {
          _status = '用户取消登录/User cancelled sign in';
        });
        return;
      }
      
      // 使用 Facebook 用户信息与 Firebase Auth 集成
      final credential = FacebookAuthProvider.credential(
        facebookUser.accessToken!,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        _user = userCredential.user;
        _status = '登录成功/Sign in success';
      });
    } catch (e) {
      setState(() {
        _status = '登录失败/Sign in failed: $e';
      });
    }
  }

  Future<void> _signInAnonymously() async {
    setState(() {
      _status = '匿名登录中/Signing in anonymously...';
    });
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      setState(() {
        _user = userCredential.user;
        _status = '匿名登录成功/Anonymous sign-in success';
      });
    } catch (e) {
      setState(() {
        _status = '匿名登录失败/Anonymous sign-in failed: $e';
      });
    }
  }

  Future<void> _signOut() async {
    try {
      // 退出 Firebase Auth
      await FirebaseAuth.instance.signOut();
      // 退出 Facebook 登录
      await _provider.signOut();
      setState(() {
        _user = null;
        _status = '已退出登录/Signed out';
      });
    } catch (e) {
      setState(() {
        _status = '退出登录失败/Sign out failed: $e';
      });
    }
  }

  Future<void> _getUserPermissions() async {
    try {
      final permissions = await _provider.getPermissions();
      setState(() {
        _status = '用户权限/User permissions: ${permissions.join(', ')}';
      });
    } catch (e) {
      setState(() {
        _status = '获取权限失败/Get permissions failed: $e';
      });
    }
  }

  Future<void> _requestAdditionalPermissions() async {
    try {
      final success = await _provider.requestPermissions([
        'email',
        'public_profile',
        'user_friends',
      ]);
      setState(() {
        _status = success 
          ? '权限请求成功/Permission request success'
          : '权限请求失败/Permission request failed';
      });
    } catch (e) {
      setState(() {
        _status = '权限请求失败/Permission request failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook 登录示例 / Facebook Sign-In Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 状态显示
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _status,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              
              // 用户信息显示
              if (_user != null) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '用户信息 / User Info',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text('用户ID/User ID: ${_user!.uid}'),
                      Text('邮箱/Email: ${_user!.email ?? "-"}'),
                      Text('昵称/Name: ${_user!.displayName ?? "-"}'),
                      if (_user!.photoURL != null)
                        Text('头像/Photo: ${_user!.photoURL}'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
              
              // 登录按钮
              ElevatedButton.icon(
                onPressed: _signInWithFacebook,
                icon: const Icon(Icons.facebook),
                label: const Text('使用 Facebook 登录 / Sign in with Facebook'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1877F2), // Facebook 蓝色
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              
              // 匿名登录按钮
              ElevatedButton.icon(
                onPressed: _signInAnonymously,
                icon: const Icon(Icons.person_outline),
                label: const Text('匿名登录 / Sign in Anonymously'),
              ),
              const SizedBox(height: 16),
              
              // 权限相关按钮
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _getUserPermissions,
                    child: const Text('获取权限 / Get Permissions'),
                  ),
                  ElevatedButton(
                    onPressed: _requestAdditionalPermissions,
                    child: const Text('请求权限 / Request Permissions'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // 退出登录按钮
              ElevatedButton.icon(
                onPressed: _signOut,
                icon: const Icon(Icons.logout),
                label: const Text('退出登录 / Sign out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Colors.white,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // 配置说明
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '配置说明 / Configuration Notes',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• 请确保已在 Firebase Console 中启用 Facebook 登录\n'
                      '• 请替换代码中的 Facebook App ID 和 App Secret\n'
                      '• 请配置相应的平台设置（Android/iOS/Web）',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 