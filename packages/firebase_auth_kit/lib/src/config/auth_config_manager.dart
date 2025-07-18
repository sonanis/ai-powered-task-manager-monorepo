import 'auth_platform_config.dart';

/// 认证配置管理器
class AuthConfigManager {
  final FirebaseAuthConfig _config;

  const AuthConfigManager(this._config);

  /// 获取所有启用的平台配置
  List<String> get enabledPlatforms {
    final platforms = <String>[];
    
    if (_config.google?.isEnabled == true) platforms.add('google');
    if (_config.facebook?.isEnabled == true) platforms.add('facebook');
    if (_config.apple?.isEnabled == true) platforms.add('apple');
    if (_config.twitter?.isEnabled == true) platforms.add('twitter');
    if (_config.github?.isEnabled == true) platforms.add('github');
    if (_config.microsoft?.isEnabled == true) platforms.add('microsoft');
    if (_config.yahoo?.isEnabled == true) platforms.add('yahoo');
    if (_config.linkedin?.isEnabled == true) platforms.add('linkedin');
    if (_config.emailPassword?.isEnabled == true) platforms.add('email_password');
    if (_config.phone?.isEnabled == true) platforms.add('phone');
    if (_config.anonymous?.isEnabled == true) platforms.add('anonymous');
    if (_config.saml?.isEnabled == true) platforms.add('saml');
    if (_config.oidc?.isEnabled == true) platforms.add('oidc');
    
    return platforms;
  }

  /// 验证配置是否完整
  bool validateConfig() {
    try {
      // 验证Google配置
      if (_config.google?.isEnabled == true) {
        if (_config.google!.webClientId.isEmpty) {
          throw Exception('Google配置缺少webClientId');
        }
      }

      // 验证Facebook配置
      if (_config.facebook?.isEnabled == true) {
        if (_config.facebook!.appId.isEmpty || _config.facebook!.appSecret.isEmpty) {
          throw Exception('Facebook配置缺少appId或appSecret');
        }
      }

      // 验证Apple配置
      if (_config.apple?.isEnabled == true) {
        if (_config.apple!.serviceId.isEmpty || 
            _config.apple!.teamId.isEmpty || 
            _config.apple!.keyId.isEmpty) {
          throw Exception('Apple配置缺少必要参数');
        }
      }

      // 验证Twitter配置
      if (_config.twitter?.isEnabled == true) {
        if (_config.twitter!.apiKey.isEmpty || _config.twitter!.apiSecret.isEmpty) {
          throw Exception('Twitter配置缺少apiKey或apiSecret');
        }
      }

      // 验证GitHub配置
      if (_config.github?.isEnabled == true) {
        if (_config.github!.clientId.isEmpty || _config.github!.clientSecret.isEmpty) {
          throw Exception('GitHub配置缺少clientId或clientSecret');
        }
      }

      // 验证Microsoft配置
      if (_config.microsoft?.isEnabled == true) {
        if (_config.microsoft!.clientId.isEmpty || _config.microsoft!.clientSecret.isEmpty) {
          throw Exception('Microsoft配置缺少clientId或clientSecret');
        }
      }

      // 验证Yahoo配置
      if (_config.yahoo?.isEnabled == true) {
        if (_config.yahoo!.clientId.isEmpty || _config.yahoo!.clientSecret.isEmpty) {
          throw Exception('Yahoo配置缺少clientId或clientSecret');
        }
      }

      // 验证LinkedIn配置
      if (_config.linkedin?.isEnabled == true) {
        if (_config.linkedin!.clientId.isEmpty || _config.linkedin!.clientSecret.isEmpty) {
          throw Exception('LinkedIn配置缺少clientId或clientSecret');
        }
      }

      // 验证SAML配置
      if (_config.saml?.isEnabled == true) {
        if (_config.saml!.providerId.isEmpty || 
            _config.saml!.entityId.isEmpty || 
            _config.saml!.ssoUrl.isEmpty || 
            _config.saml!.x509Certificate.isEmpty) {
          throw Exception('SAML配置缺少必要参数');
        }
      }

      // 验证OIDC配置
      if (_config.oidc?.isEnabled == true) {
        if (_config.oidc!.providerId.isEmpty || 
            _config.oidc!.clientId.isEmpty || 
            _config.oidc!.issuer.isEmpty) {
          throw Exception('OIDC配置缺少必要参数');
        }
      }

      return true;
    } catch (e) {
      print('配置验证失败: $e');
      return false;
    }
  }

  /// 获取特定平台的配置
  T? getPlatformConfig<T>() {
    switch (T) {
      case GoogleAuthConfig:
        return _config.google as T?;
      case FacebookAuthConfig:
        return _config.facebook as T?;
      case AppleAuthConfig:
        return _config.apple as T?;
      case TwitterAuthConfig:
        return _config.twitter as T?;
      case GitHubAuthConfig:
        return _config.github as T?;
      case MicrosoftAuthConfig:
        return _config.microsoft as T?;
      case YahooAuthConfig:
        return _config.yahoo as T?;
      case LinkedInAuthConfig:
        return _config.linkedin as T?;
      case EmailPasswordAuthConfig:
        return _config.emailPassword as T?;
      case PhoneAuthConfig:
        return _config.phone as T?;
      case AnonymousAuthConfig:
        return _config.anonymous as T?;
      case SAMLAuthConfig:
        return _config.saml as T?;
      case OIDCAuthConfig:
        return _config.oidc as T?;
      default:
        return null;
    }
  }

  /// 检查平台是否启用
  bool isPlatformEnabled(String platform) {
    switch (platform.toLowerCase()) {
      case 'google':
        return _config.google?.isEnabled == true;
      case 'facebook':
        return _config.facebook?.isEnabled == true;
      case 'apple':
        return _config.apple?.isEnabled == true;
      case 'twitter':
        return _config.twitter?.isEnabled == true;
      case 'github':
        return _config.github?.isEnabled == true;
      case 'microsoft':
        return _config.microsoft?.isEnabled == true;
      case 'yahoo':
        return _config.yahoo?.isEnabled == true;
      case 'linkedin':
        return _config.linkedin?.isEnabled == true;
      case 'email_password':
        return _config.emailPassword?.isEnabled == true;
      case 'phone':
        return _config.phone?.isEnabled == true;
      case 'anonymous':
        return _config.anonymous?.isEnabled == true;
      case 'saml':
        return _config.saml?.isEnabled == true;
      case 'oidc':
        return _config.oidc?.isEnabled == true;
      default:
        return false;
    }
  }

  /// 获取配置摘要
  Map<String, dynamic> getConfigSummary() {
    return {
      'enabled_platforms': enabledPlatforms,
      'total_platforms': enabledPlatforms.length,
      'config_valid': validateConfig(),
    };
  }
} 