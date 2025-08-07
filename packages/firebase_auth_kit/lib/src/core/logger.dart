import 'dart:developer' as developer;

/// 日志级别枚举 / Log Level Enum
enum LogLevel {
  /// 调试信息 / Debug information
  debug,
  
  /// 一般信息 / General information
  info,
  
  /// 警告信息 / Warning information
  warning,
  
  /// 错误信息 / Error information
  error,
  
  /// 严重错误 / Fatal error
  fatal,
}

/// Firebase Auth Kit 日志系统 / Firebase Auth Kit Logger System
/// 
/// 提供专业的日志记录功能，支持不同级别和格式化输出
/// Provides professional logging functionality with different levels and formatted output
class AuthLogger {
  static const String _tag = '[FirebaseAuthKit]';
  static LogLevel _minLevel = LogLevel.info;
  static bool _enableConsoleOutput = true;

  /// 设置日志级别 / Set log level
  static void setLogLevel(LogLevel level) {
    _minLevel = level;
  }

  /// 启用/禁用控制台输出 / Enable/disable console output
  static void setConsoleOutput(bool enabled) {
    _enableConsoleOutput = enabled;
  }



  /// 调试日志 / Debug log
  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, error: error, stackTrace: stackTrace);
  }

  /// 信息日志 / Info log
  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.info, message, error: error, stackTrace: stackTrace);
  }

  /// 警告日志 / Warning log
  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message, error: error, stackTrace: stackTrace);
  }

  /// 错误日志 / Error log
  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, error: error, stackTrace: stackTrace);
  }

  /// 严重错误日志 / Fatal log
  static void fatal(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.fatal, message, error: error, stackTrace: stackTrace);
  }

  /// 内部日志方法 / Internal log method
  static void _log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    // 检查日志级别 / Check log level
    if (level.index < _minLevel.index) {
      return;
    }

    // 控制台输出 / Console output
    if (_enableConsoleOutput) {
      switch (level) {
        case LogLevel.debug:
        case LogLevel.info:
          developer.log(message, name: _tag, level: level.index);
          break;
        case LogLevel.warning:
          developer.log('⚠️  $message', name: _tag, level: level.index);
          break;
        case LogLevel.error:
        case LogLevel.fatal:
          developer.log('❌ $message', name: _tag, level: level.index, error: error, stackTrace: stackTrace);
          break;
      }
    }


  }


}

/// 便捷的日志方法 / Convenient logging methods
/// 
/// 提供简化的日志调用方式
/// Provides simplified logging call methods
class Log {
  /// 调试日志 / Debug log
  static void d(String message, {Object? error, StackTrace? stackTrace}) {
    AuthLogger.debug(message, error: error, stackTrace: stackTrace);
  }

  /// 信息日志 / Info log
  static void i(String message, {Object? error, StackTrace? stackTrace}) {
    AuthLogger.info(message, error: error, stackTrace: stackTrace);
  }

  /// 警告日志 / Warning log
  static void w(String message, {Object? error, StackTrace? stackTrace}) {
    AuthLogger.warning(message, error: error, stackTrace: stackTrace);
  }

  /// 错误日志 / Error log
  static void e(String message, {Object? error, StackTrace? stackTrace}) {
    AuthLogger.error(message, error: error, stackTrace: stackTrace);
  }

  /// 严重错误日志 / Fatal log
  static void f(String message, {Object? error, StackTrace? stackTrace}) {
    AuthLogger.fatal(message, error: error, stackTrace: stackTrace);
  }
} 