library firebase_auth_kit;

// 导入必要的类
import 'src/config/auth_platform_config.dart';
import 'src/auth/firebase_auth_service.dart';
import 'src/core/logger.dart';

// 导出配置相关类
export 'src/config/auth_platform_config.dart';
export 'src/config/auth_config_manager.dart';

// 导出平台检测器
export 'src/platform/platform_detector.dart';

// 导出认证服务
export 'src/auth/firebase_auth_service.dart';

// 导出数据模型
export 'src/models/auth_models.dart';

// 导出状态管理
export 'src/providers/auth_provider.dart';

// 导出认证提供者
export 'src/auth/providers/google_sign_in_provider.dart';
export 'src/auth/providers/default_google_sign_in_provider.dart';
export 'src/auth/providers/facebook_sign_in_provider.dart';
export 'src/auth/providers/default_facebook_sign_in_provider.dart';
export 'src/auth/providers/github_sign_in_provider.dart';

// 导出日志系统
export 'src/core/logger.dart';

// 导出 Provider 相关类型（方便用户使用）
export 'package:provider/provider.dart';

/// Firebase Auth Kit 主类
class FirebaseAuthKit {
  /// 初始化Firebase Auth Kit
  /// Initialize Firebase Auth Kit with configuration
  static Future<void> initialize({
    required FirebaseAuthConfig config,
  }) async {
    try {
      // 调用 FirebaseAuthService 的初始化方法
      // Call FirebaseAuthService initialization method
      await FirebaseAuthService.initialize(config: config);
      
      Log.i('Firebase Auth Kit 初始化成功 / Firebase Auth Kit initialized successfully');
    } catch (e) {
      Log.e('Firebase Auth Kit 初始化失败 / Firebase Auth Kit initialization failed', error: e);
      rethrow;
    }
  }
  
  /// 获取版本信息
  static String get version => '0.0.1';
  
  /// 获取支持的平台列表
  static List<String> get supportedPlatforms => [
    'google',
    'facebook', 
    'github',
    'apple',
    'twitter',
    'microsoft',
    'yahoo',
    'linkedin',
    'email_password',
    'phone',
    'anonymous',
    'saml',
    'oidc',
  ];
}
