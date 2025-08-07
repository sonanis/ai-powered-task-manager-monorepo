import 'package:flutter/material.dart';
import 'package:firebase_auth_kit/firebase_auth_kit.dart';
import 'firebase_github_sign_in_provider.dart';

/// Firebase GitHub 认证示例页面 / Firebase GitHub Auth Example Page
/// 
/// 展示如何使用 Firebase Auth Kit 实现 GitHub 认证
/// Demonstrates how to implement GitHub authentication using Firebase Auth Kit
class FirebaseGitHubAuthExample extends StatefulWidget {
  const FirebaseGitHubAuthExample({super.key});

  @override
  State<FirebaseGitHubAuthExample> createState() => _FirebaseGitHubAuthExampleState();
}

class _FirebaseGitHubAuthExampleState extends State<FirebaseGitHubAuthExample> {
  /// Firebase Auth Kit 服务实例 / Firebase Auth Kit service instance
  late final FirebaseAuthService _authService;
  
  /// GitHub 登录提供者 / GitHub sign-in provider
  late final FirebaseGitHubSignInProvider _githubProvider;
  
  /// 当前用户信息 / Current user information
  GitHubSignInAccount? _currentUser;
  
  /// 加载状态 / Loading state
  bool _isLoading = false;
  
  /// 错误信息 / Error message
  String? _errorMessage;
  
  /// 登录状态 / Sign-in status
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  /// 初始化认证服务 / Initialize authentication service
  Future<void> _initializeAuth() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // 初始化 Firebase Auth Kit 服务
      _authService = FirebaseAuthService.instance;
      
      // 创建 GitHub 登录提供者
      _githubProvider = FirebaseGitHubSignInProvider();
      
      // 设置 GitHub 提供者到 Auth 服务
      _authService.setGitHubProvider(_githubProvider);
      
      // 检查当前登录状态
      await _checkSignInStatus();
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '初始化失败：$e';
      });
    }
  }

  /// 检查登录状态 / Check sign-in status
  Future<void> _checkSignInStatus() async {
    try {
      final isSignedIn = await _githubProvider.isSignedIn();
      final currentUser = await _githubProvider.getCurrentUser();
      
      setState(() {
        _isSignedIn = isSignedIn;
        _currentUser = currentUser;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '检查登录状态失败：$e';
      });
    }
  }

  /// GitHub 登录 / GitHub sign-in
  Future<void> _signInWithGitHub() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // 执行 GitHub 登录
      final user = await _githubProvider.signIn();
      
      if (user != null) {
        setState(() {
          _currentUser = user;
          _isSignedIn = true;
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('登录成功！欢迎 ${user.login ?? '用户'}'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = '登录失败或用户取消';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '登录失败：$e';
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('登录失败：$e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }



  /// 退出登录 / Sign out
  Future<void> _signOut() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // 退出 GitHub 登录
      await _githubProvider.signOut();
      
      // 退出 Firebase 登录
      await _authService.signOut();
      
      setState(() {
        _currentUser = null;
        _isSignedIn = false;
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('已退出登录'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '退出登录失败：$e';
      });
    }
  }

  /// 获取用户权限 / Get user permissions
  Future<void> _getPermissions() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final permissions = await _githubProvider.getPermissions();
      
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('用户权限：${permissions.join(', ')}'),
          backgroundColor: Colors.blue,
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '获取权限失败：$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase GitHub 认证示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _isLoading ? null : _checkSignInStatus,
            icon: const Icon(Icons.refresh),
            tooltip: '刷新状态',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 状态卡片
                  _buildStatusCard(),
                  
                  const SizedBox(height: 16),
                  
                  // 错误信息
                  if (_errorMessage != null) _buildErrorCard(),
                  
                  const SizedBox(height: 16),
                  
                  // 操作按钮
                  _buildActionButtons(),
                  
                  const SizedBox(height: 16),
                  
                  // 用户信息详情
                  if (_currentUser != null) _buildUserDetailsCard(),
                  
                  const Spacer(),
                  
                  // 说明信息
                  _buildInfoCard(),
                ],
              ),
            ),
    );
  }

  /// 构建状态卡片 / Build status card
  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _isSignedIn ? Icons.check_circle : Icons.cancel,
                  color: _isSignedIn ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  '登录状态',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _isSignedIn ? '已登录' : '未登录',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: _isSignedIn ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_currentUser != null) ...[
              const SizedBox(height: 8),
              Text('用户：${_currentUser!.login ?? '未知'}'),
              if (_currentUser!.email != null) Text('邮箱：${_currentUser!.email}'),
            ],
          ],
        ),
      ),
    );
  }

  /// 构建错误信息卡片 / Build error card
  Widget _buildErrorCard() {
    return Card(
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.error, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  '错误信息',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建操作按钮 / Build action buttons
  Widget _buildActionButtons() {
    return Column(
      children: [
        // GitHub 登录按钮
        ElevatedButton.icon(
          onPressed: _isSignedIn ? null : _signInWithGitHub,
          icon: const Icon(Icons.login),
          label: const Text('GitHub 登录'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
          ),
        ),
        
        const SizedBox(height: 8),
        

        
        // 退出登录按钮
        ElevatedButton.icon(
          onPressed: _isSignedIn ? _signOut : null,
          icon: const Icon(Icons.logout),
          label: const Text('退出登录'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
          ),
        ),
        
        const SizedBox(height: 8),
        
        // 获取权限按钮
        ElevatedButton.icon(
          onPressed: _isSignedIn ? _getPermissions : null,
          icon: const Icon(Icons.security),
          label: const Text('获取权限'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  /// 构建用户详情卡片 / Build user details card
  Widget _buildUserDetailsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '用户详情',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // 用户头像
            if (_currentUser!.avatarUrl != null)
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(_currentUser!.avatarUrl!),
                ),
              ),
            
            const SizedBox(height: 16),
            
            // 用户信息
            _buildInfoRow('用户ID', _currentUser!.id),
            _buildInfoRow('用户名', _currentUser!.login ?? '未知'),
            _buildInfoRow('显示名称', _currentUser!.name ?? '未设置'),
            _buildInfoRow('邮箱', _currentUser!.email ?? '未提供'),
            _buildInfoRow('访问令牌', _currentUser!.accessToken != null ? '已获取' : '未获取'),
            _buildInfoRow('权限数量', '${_currentUser!.permissions.length}'),
            
            const SizedBox(height: 8),
            
            // 权限列表
            Text(
              '权限列表：',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            ...(_currentUser!.permissions.map((permission) => 
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 2),
                child: Text('• $permission'),
              ),
            )),
          ],
        ),
      ),
    );
  }

  /// 构建信息行 / Build info row
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label：',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  /// 构建说明信息卡片 / Build info card
  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '使用说明',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              '• 本示例使用 Firebase Auth 的 GithubAuthProvider 实现 GitHub 认证\n'
              '• 支持移动端和 Web 端\n'
              '• 需要先在 Firebase Console 中启用 GitHub 认证\n'
              '• 需要配置 GitHub OAuth 应用的回调地址',
            ),
          ],
        ),
      ),
    );
  }
} 