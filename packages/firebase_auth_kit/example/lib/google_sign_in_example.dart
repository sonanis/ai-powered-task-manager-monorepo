import 'package:flutter/material.dart';
import 'package:firebase_auth_kit/firebase_auth_kit.dart' hide AuthProvider;
import 'package:firebase_auth_kit/src/providers/auth_provider.dart' as kit;
import 'google_sign_in_provider_impl.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'config/env.dart';

class GoogleSignInExample extends StatefulWidget {
  const GoogleSignInExample({super.key});

  @override
  State<GoogleSignInExample> createState() => _GoogleSignInExampleState();
}

class _GoogleSignInExampleState extends State<GoogleSignInExample> {
  // 从环境变量获取 Firebase 项目配置
  final FirebaseAuthConfig _config = FirebaseAuthConfig(
    google: GoogleAuthConfig(
      isEnabled: true,
      webClientId: Env.googleWebClientId,
      androidClientId: Env.googleAndroidClientId,
      iosClientId: Env.googleIosClientId,
    ),
    anonymous: AnonymousAuthConfig(isEnabled: true),
  );

  late final MyGoogleSignInProvider _provider;

  @override
  void initState() {
    super.initState();
    _debugPrintConfig();
    _provider = MyGoogleSignInProvider(clientId: getGoogleClientId());
    _setupAuthProvider();
  }

  /// 调试打印配置信息 / Debug print configuration
  void _debugPrintConfig() {
    print('🔍 === Google 登录配置调试信息 ===');
    print('📱 当前平台: ${defaultTargetPlatform}');
    print('🌐 是否为 Web: $kIsWeb');
    print('');
    print('🔧 环境变量配置:');
    print('  GOOGLE_WEB_CLIENT_ID: ${Env.googleWebClientId}');
    print('  GOOGLE_ANDROID_CLIENT_ID: ${Env.googleAndroidClientId}');
    print('  GOOGLE_IOS_CLIENT_ID: ${Env.googleIosClientId}');
    print('');
    print('⚙️ FirebaseAuthConfig 配置:');
    print('  _config.google?.webClientId: ${_config.google?.webClientId}');
    print('  _config.google?.androidClientId: ${_config.google?.androidClientId}');
    print('  _config.google?.iosClientId: ${_config.google?.iosClientId}');
    print('  _config.google?.isEnabled: ${_config.google?.isEnabled}');
    print('');
    print('🎯 最终使用的 Client ID: ${getGoogleClientId()}');
    print('🔍 === 调试信息结束 ===');
  }

  String getGoogleClientId() {
    print('🔍 getGoogleClientId() 调用:');
    print('  kIsWeb: $kIsWeb');
    print('  defaultTargetPlatform: $defaultTargetPlatform');
    
    String clientId;
    if (kIsWeb) {
      clientId = _config.google?.webClientId ?? '';
      print('  🌐 Web 平台，使用 webClientId: $clientId');
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          clientId = _config.google?.androidClientId ?? '';
          print('  📱 Android 平台，使用 androidClientId: $clientId');
          break;
        case TargetPlatform.iOS:
          clientId = _config.google?.iosClientId ?? '';
          print('  🍎 iOS 平台，使用 iosClientId: $clientId');
          break;
        default:
          clientId = '';
          print('  ❓ 未知平台，返回空字符串');
          break;
      }
    }
    
    print('  ✅ 最终返回的 clientId: $clientId');
    return clientId;
  }

  void _setupAuthProvider() {
    print('🔧 设置 Google 登录提供者...');
    print('  provider 类型: ${_provider.runtimeType}');
    print('  provider clientId: ${_provider.clientId}');
    print('  FirebaseAuthService.instance: ${FirebaseAuthService.instance}');
    
    // 设置 Google 登录提供者
    FirebaseAuthService.instance.setGoogleProvider(_provider);
    print('✅ Google 登录提供者设置完成');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google 登录示例 / Google Sign-In Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<kit.AuthProvider>(
        builder: (context, authProvider, child) {
          // 类型转换
          final provider = authProvider as kit.AuthProvider?;
          if (provider == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 状态显示
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          '认证状态 / Auth Status',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getStatusText(provider),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        if (provider.currentUser != null) ...[
                          const SizedBox(height: 16),
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: provider.currentUser!.photoURL != null
                                ? NetworkImage(provider.currentUser!.photoURL!)
                                : null,
                            child: provider.currentUser!.photoURL == null
                                ? Text(
                                    provider.currentUser!.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                                    style: const TextStyle(fontSize: 24),
                                  )
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            provider.currentUser!.displayName ?? 'Unknown User',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            provider.currentUser!.email ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
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
    print('🔧 使用的配置:');
    print('  webClientId: ${_config.google?.webClientId}');
    print('  androidClientId: ${_config.google?.androidClientId}');
    print('  iosClientId: ${_config.google?.iosClientId}');
    print('  isEnabled: ${_config.google?.isEnabled}');
    
    try {
      await context.read<kit.AuthProvider>().signInWithGoogle(config: _config.google!);
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