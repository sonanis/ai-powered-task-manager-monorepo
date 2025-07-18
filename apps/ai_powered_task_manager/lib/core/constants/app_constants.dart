/// 应用常量
class AppConstants {
  static const String appName = 'AI Task Manager';
  static const String appVersion = '1.0.0';
  
  // API配置
  static const String baseUrl = 'https://api.example.com';
  static const int apiTimeout = 30000; // 30秒
  
  // 本地存储键
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String userIdKey = 'user_id';
  
  // 任务相关
  static const int maxTaskTitleLength = 100;
  static const int maxTaskDescriptionLength = 500;
  
  // 分页
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
} 