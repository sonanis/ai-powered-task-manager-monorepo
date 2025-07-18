import 'package:flutter/foundation.dart';

/// 平台类型枚举
enum PlatformType {
  android,
  ios,
  web,
  windows,
  macos,
  linux,
  unknown,
}

/// 平台检测器
class PlatformDetector {
  /// 获取当前平台类型
  static PlatformType get currentPlatform {
    if (kIsWeb) {
      return PlatformType.web;
    }
    
    // 在非Web平台上，我们使用更安全的方式检测平台
    // 避免直接使用dart:io，而是通过其他方式检测
    return _detectNativePlatform();
  }

  /// 检测原生平台（不使用dart:io）
  static PlatformType _detectNativePlatform() {
    // 使用Flutter的defaultTargetPlatform来检测平台
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return PlatformType.android;
      case TargetPlatform.iOS:
        return PlatformType.ios;
      case TargetPlatform.windows:
        return PlatformType.windows;
      case TargetPlatform.macOS:
        return PlatformType.macos;
      case TargetPlatform.linux:
        return PlatformType.linux;
      default:
        return PlatformType.unknown;
    }
  }

  /// 检查是否为移动平台
  static bool get isMobile {
    final platform = currentPlatform;
    return platform == PlatformType.android || platform == PlatformType.ios;
  }

  /// 检查是否为桌面平台
  static bool get isDesktop {
    final platform = currentPlatform;
    return platform == PlatformType.windows || 
           platform == PlatformType.macos || 
           platform == PlatformType.linux;
  }

  /// 检查是否为Web平台
  static bool get isWeb => currentPlatform == PlatformType.web;

  /// 获取平台名称
  static String get platformName {
    switch (currentPlatform) {
      case PlatformType.android:
        return 'Android';
      case PlatformType.ios:
        return 'iOS';
      case PlatformType.web:
        return 'Web';
      case PlatformType.windows:
        return 'Windows';
      case PlatformType.macos:
        return 'macOS';
      case PlatformType.linux:
        return 'Linux';
      case PlatformType.unknown:
        return 'Unknown';
    }
  }

  /// 检查平台是否支持特定功能
  static bool supportsFeature(String feature) {
    switch (feature) {
      case 'apple_sign_in':
        return currentPlatform == PlatformType.ios || 
               currentPlatform == PlatformType.macos;
      case 'google_sign_in':
        return true; // 所有平台都支持
      case 'facebook_sign_in':
        return true; // 所有平台都支持
      case 'phone_auth':
        return isMobile; // 仅移动平台支持
      case 'biometric_auth':
        return isMobile; // 仅移动平台支持
      default:
        return true;
    }
  }

  /// 获取平台特定的配置键
  static String getPlatformConfigKey(String baseKey) {
    switch (currentPlatform) {
      case PlatformType.android:
        return '${baseKey}_android';
      case PlatformType.ios:
        return '${baseKey}_ios';
      case PlatformType.web:
        return '${baseKey}_web';
      default:
        return baseKey;
    }
  }
} 