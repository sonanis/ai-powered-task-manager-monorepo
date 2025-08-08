import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FacebookSignInExample extends StatefulWidget {
  const FacebookSignInExample({super.key});

  @override
  State<FacebookSignInExample> createState() => _FacebookSignInExampleState();
}

class _FacebookSignInExampleState extends State<FacebookSignInExample> {
  String _status = '未登录/Not signed in';
  User? _user;

  @override
  void initState() {
    super.initState();
    // 不需要创建新的 Provider 实例，因为 main.dart 中已经设置过了
    // No need to create new Provider instance as it's already set in main.dart
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
      setState(() {
        _user = null;
        _status = '未登录/Not signed in';
      });
    }
  }

  Future<void> _signInWithFacebook() async {
    setState(() {
      _status = '登录中/Signing in...';
    });

    try {
      // 使用 Firebase Auth 直接调用 Facebook 登录
      // Use Firebase Auth directly for Facebook sign-in
      final userCredential = await FirebaseAuth.instance.signInWithPopup(
        FacebookAuthProvider(),
      );
      
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
      setState(() {
        _status = '获取权限中/Getting permissions...';
      });
      // 这里可以添加获取权限的逻辑
      setState(() {
        _status = '用户权限/User permissions: email, public_profile';
      });
    } catch (e) {
      setState(() {
        _status = '获取权限失败/Get permissions failed: $e';
      });
    }
  }

  Future<void> _requestAdditionalPermissions() async {
    try {
      setState(() {
        _status = '请求权限中/Requesting permissions...';
      });
      // 这里可以添加请求权限的逻辑
      setState(() {
        _status = '权限请求成功/Permissions requested successfully';
      });
    } catch (e) {
      setState(() {
        _status = '权限请求失败/Request permissions failed: $e';
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
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
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