import 'package:flutter/material.dart';
import 'package:firebase_auth_kit/firebase_auth_kit.dart' hide AuthProvider;
import 'package:firebase_auth_kit/src/providers/auth_provider.dart' as kit;

class GoogleSignInExample extends StatefulWidget {
  const GoogleSignInExample({super.key});

  @override
  State<GoogleSignInExample> createState() => _GoogleSignInExampleState();
}

class _GoogleSignInExampleState extends State<GoogleSignInExample> {
  @override
  void initState() {
    super.initState();
    // 不需要创建新的 Provider 实例，因为 main.dart 中已经设置过了
    // No need to create new Provider instance as it's already set in main.dart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google 登录示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<kit.AuthProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 状态显示
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          '登录状态 / Sign-in Status',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getStatusText(provider),
                          style: TextStyle(
                            color: provider.status == UserStatus.authenticated 
                                ? Colors.green 
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // 操作按钮
                if (provider.isLoading)
                  const CircularProgressIndicator()
                else ...[
                  ElevatedButton.icon(
                    onPressed: provider.currentUser == null ? _signInWithGoogle : null,
                    icon: const Icon(Icons.login),
                    label: const Text('Google 登录 / Google Sign-In'),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  ElevatedButton.icon(
                    onPressed: provider.currentUser == null ? _signInAnonymously : null,
                    icon: const Icon(Icons.person_outline),
                    label: const Text('匿名登录 / Anonymous Sign-In'),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  ElevatedButton.icon(
                    onPressed: provider.currentUser != null ? _signOut : null,
                    icon: const Icon(Icons.logout),
                    label: const Text('退出登录 / Sign Out'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
                
                // 错误显示
                if (provider.error != null) ...[
                  const SizedBox(height: 16),
                  Card(
                    color: Colors.red.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Icon(Icons.error, color: Colors.red),
                          const SizedBox(height: 8),
                          Text(
                            '错误 / Error',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            provider.error!.message,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: provider.clearError,
                            child: const Text('清除错误 / Clear Error'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  String _getStatusText(kit.AuthProvider authProvider) {
    switch (authProvider.status) {
      case UserStatus.unauthenticated:
        return '未登录 / Not signed in';
      case UserStatus.authenticating:
        return '登录中 / Signing in...';
      case UserStatus.authenticated:
        return '已登录 / Signed in';
      case UserStatus.authenticationFailed:
        return '登录失败 / Sign-in failed';
      default:
        return '未知状态 / Unknown status';
    }
  }

  Future<void> _signInWithGoogle() async {
    print('🚀 开始 Google 登录...');
    
    try {
      await context.read<kit.AuthProvider>().signInWithGoogle();
      print('✅ Google 登录成功');
    } catch (e) {
      print('❌ Google 登录失败 / Google sign-in failed: $e');
      print('🔍 错误详情: $e');
    }
  }

  Future<void> _signInAnonymously() async {
    try {
      await context.read<kit.AuthProvider>().signInAnonymously();
    } catch (e) {
      print('匿名登录失败 / Anonymous sign-in failed: $e');
    }
  }

  Future<void> _signOut() async {
    try {
      await context.read<kit.AuthProvider>().signOut();
    } catch (e) {
      print('退出登录失败 / Sign out failed: $e');
    }
  }
} 