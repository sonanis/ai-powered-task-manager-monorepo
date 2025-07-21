library firebase_auth_kit;

// 导出配置相关类
export 'src/config/auth_platform_config.dart';
export 'src/config/auth_config_manager.dart';
export 'src/config/auth_config_example.dart';

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

/// Firebase Auth Kit 主类
class FirebaseAuthKit {
  /// 初始化Firebase Auth Kit
  static Future<void> initialize() async {
    // TODO: 实现初始化逻辑
  }
  
  /// 获取版本信息
  static String get version => '0.0.1';
  
  /// 获取支持的平台列表
  static List<String> get supportedPlatforms => [
    'google',
    'facebook', 
    'apple',
    'twitter',
    'github',
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
