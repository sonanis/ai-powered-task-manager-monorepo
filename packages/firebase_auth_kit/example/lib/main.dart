import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth_kit/firebase_auth_kit.dart' hide AuthProvider;
import 'firebase_github_auth_example.dart';
import 'google_sign_in_example.dart';
import 'facebook_sign_in_example.dart';
import 'firebase_options.dart';
import 'config/env.dart';
import 'google_sign_in_provider_impl.dart';
import 'facebook_sign_in_provider_impl.dart';
import 'firebase_github_sign_in_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // 创建 Firebase Auth 配置
  // Create Firebase Auth configuration
  final authConfig = FirebaseAuthConfig(
    // 在开发环境中，只启用不需要外部配置的平台
    // In development environment, only enable platforms that don't require external configuration
    google: GoogleAuthConfig(
      isEnabled: true, 
      webClientId: Env.googleWebClientId,
      androidClientId: Env.googleAndroidClientId,
      iosClientId: Env.googleIosClientId,
    ),
    facebook: FacebookAuthConfig(
      isEnabled: false, // 暂时禁用，需要真实的 Facebook App 配置
      appId: Env.facebookAppId,
      appSecret: Env.facebookAppSecret,
      permissions: ['email', 'public_profile'],
    ),
    github: GitHubAuthConfig(
      isEnabled: true, 
      clientId: Env.githubClientId,
      clientSecret: Env.githubClientSecret,
      redirectUri: Env.githubCallbackUrl,
      scopes: ['read:user', 'user:email'],
    ),
    emailPassword: EmailPasswordAuthConfig(
      isEnabled: true, // 启用邮箱密码登录
      allowSignUp: true,
      allowPasswordReset: true,
      requireEmailVerification: false,
    ),
    anonymous: AnonymousAuthConfig(isEnabled: true), // 启用匿名登录
  );
  
  // 打印配置信息用于调试
  print('🔧 === Firebase Auth 配置调试信息 ===');
  print('启用的平台: ${authConfig.google?.isEnabled == true ? 'Google' : ''} ${authConfig.facebook?.isEnabled == true ? 'Facebook' : ''} ${authConfig.github?.isEnabled == true ? 'GitHub' : ''} ${authConfig.emailPassword?.isEnabled == true ? 'EmailPassword' : ''} ${authConfig.anonymous?.isEnabled == true ? 'Anonymous' : ''}');
  print('Google enabled: ${authConfig.google?.isEnabled}');
  print('Facebook enabled: ${authConfig.facebook?.isEnabled}');
  print('GitHub enabled: ${authConfig.github?.isEnabled}');
  print('EmailPassword enabled: ${authConfig.emailPassword?.isEnabled}');
  print('Anonymous enabled: ${authConfig.anonymous?.isEnabled}');
  print('🔧 === 配置调试信息结束 ===');
  
  // 初始化 Firebase Auth Kit
  // Initialize Firebase Auth Kit
  await FirebaseAuthKit.initialize(config: authConfig);
  
  // 设置 Provider 实例（只设置启用的平台）
  // Set up Provider instances (only for enabled platforms)
  final authService = FirebaseAuthService.instance;
  
  // 注意：由于 Google、Facebook、GitHub 配置已禁用，暂时不设置这些 Provider
  // Note: Since Google, Facebook, GitHub configurations are disabled, don't set these providers for now
  authService.setGoogleProvider(MyGoogleSignInProvider());
  authService.setFacebookProvider(MyFacebookSignInProvider());
  authService.setGitHubProvider(FirebaseGitHubSignInProvider());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Kit 示例',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthExamplePage(),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            createAuthProvider(),
          ],
          child: child!,
        );
      },
    );
  }
}

class AuthExamplePage extends StatefulWidget {
  const AuthExamplePage({super.key});

  @override
  State<AuthExamplePage> createState() => _AuthExamplePageState();
}

class _AuthExamplePageState extends State<AuthExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth Kit 示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '认证方式演示',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '本示例展示了如何使用 Firebase Auth Kit 实现各种认证方式。'
                      '点击下面的按钮查看不同的认证实现。',
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 配置警告
            if (Env.isDevelopment) ...[
              Card(
                color: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            '配置警告',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '检测到您使用的是开发环境配置。请按照 FIREBASE_SETUP_GUIDE.md 文件中的说明配置 Firebase 项目和 GitHub OAuth 应用。',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // GitHub 认证示例
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FirebaseGitHubAuthExample(),
                  ),
                );
              },
              icon: const Icon(Icons.code),
              label: const Text('Firebase GitHub 认证示例'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Google 认证示例
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const GoogleSignInExample(),
                  ),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('Google 登录示例'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Facebook 认证示例
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FacebookSignInExample(),
                  ),
                );
              },
              icon: const Icon(Icons.facebook),
              label: const Text('Facebook 登录示例'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1877F2), // Facebook 蓝色
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 说明信息
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '认证示例说明',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '本示例展示了 Firebase Auth Kit 的多种认证方式：\n\n'
                      '• GitHub 认证：使用 Firebase Auth 的 GithubAuthProvider 实现\n'
                      '• Google 认证：使用 Firebase Auth 的 GoogleAuthProvider 实现\n'
                      '• Facebook 认证：使用 Firebase Auth 的 FacebookAuthProvider 实现\n\n'
                      '所有认证方式都支持移动端和 Web 端，'
                      '需要先在 Firebase Console 中启用相应的认证方式，'
                      '并配置相应的 OAuth 应用。\n\n'
                      '详细配置说明请查看 FIREBASE_SETUP_GUIDE.md 文件。',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
