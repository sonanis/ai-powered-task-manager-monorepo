import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_platform_config.freezed.dart';
part 'auth_platform_config.g.dart';

/// Firebase Auth 平台配置基类
@freezed
class AuthPlatformConfig with _$AuthPlatformConfig {
  const factory AuthPlatformConfig({
    required String platformName,
    required bool isEnabled,
    String? clientId,
    String? clientSecret,
    String? redirectUri,
    Map<String, dynamic>? additionalConfig,
  }) = _AuthPlatformConfig;

  factory AuthPlatformConfig.fromJson(Map<String, dynamic> json) =>
      _$AuthPlatformConfigFromJson(json);
}

/// Google登录配置
@freezed
class GoogleAuthConfig with _$GoogleAuthConfig {
  const factory GoogleAuthConfig({
    @Default(true) bool isEnabled,
    required String webClientId,
    String? iosClientId,
    String? androidClientId,
    String? serverClientId,
    String? redirectUri,
  }) = _GoogleAuthConfig;

  factory GoogleAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$GoogleAuthConfigFromJson(json);
}

/// Facebook登录配置
@freezed
class FacebookAuthConfig with _$FacebookAuthConfig {
  const factory FacebookAuthConfig({
    @Default(true) bool isEnabled,
    required String appId,
    required String appSecret,
    String? clientToken,
    List<String>? permissions,
    String? redirectUri,
  }) = _FacebookAuthConfig;

  factory FacebookAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$FacebookAuthConfigFromJson(json);
}

/// Apple登录配置
@freezed
class AppleAuthConfig with _$AppleAuthConfig {
  const factory AppleAuthConfig({
    @Default(true) bool isEnabled,
    required String serviceId,
    required String teamId,
    required String keyId,
    String? privateKey,
    String? redirectUri,
    List<String>? scopes,
  }) = _AppleAuthConfig;

  factory AppleAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$AppleAuthConfigFromJson(json);
}

/// Twitter登录配置
@freezed
class TwitterAuthConfig with _$TwitterAuthConfig {
  const factory TwitterAuthConfig({
    @Default(true) bool isEnabled,
    required String apiKey,
    required String apiSecret,
    String? redirectUri,
  }) = _TwitterAuthConfig;

  factory TwitterAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$TwitterAuthConfigFromJson(json);
}

/// GitHub登录配置
@freezed
class GitHubAuthConfig with _$GitHubAuthConfig {
  const factory GitHubAuthConfig({
    @Default(true) bool isEnabled,
    required String clientId,
    required String clientSecret,
    String? redirectUri,
    List<String>? scopes,
  }) = _GitHubAuthConfig;

  factory GitHubAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$GitHubAuthConfigFromJson(json);
}

/// Microsoft登录配置
@freezed
class MicrosoftAuthConfig with _$MicrosoftAuthConfig {
  const factory MicrosoftAuthConfig({
    @Default(true) bool isEnabled,
    required String clientId,
    required String clientSecret,
    String? tenantId,
    String? redirectUri,
    List<String>? scopes,
  }) = _MicrosoftAuthConfig;

  factory MicrosoftAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$MicrosoftAuthConfigFromJson(json);
}

/// Yahoo登录配置
@freezed
class YahooAuthConfig with _$YahooAuthConfig {
  const factory YahooAuthConfig({
    @Default(true) bool isEnabled,
    required String clientId,
    required String clientSecret,
    String? redirectUri,
  }) = _YahooAuthConfig;

  factory YahooAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$YahooAuthConfigFromJson(json);
}

/// LinkedIn登录配置
@freezed
class LinkedInAuthConfig with _$LinkedInAuthConfig {
  const factory LinkedInAuthConfig({
    @Default(true) bool isEnabled,
    required String clientId,
    required String clientSecret,
    String? redirectUri,
    List<String>? scopes,
  }) = _LinkedInAuthConfig;

  factory LinkedInAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$LinkedInAuthConfigFromJson(json);
}

/// 邮箱密码登录配置
@freezed
class EmailPasswordAuthConfig with _$EmailPasswordAuthConfig {
  const factory EmailPasswordAuthConfig({
    @Default(true) bool isEnabled,
    @Default(true) bool allowSignUp,
    @Default(true) bool allowPasswordReset,
    @Default(false) bool requireEmailVerification,
    String? passwordMinLength,
  }) = _EmailPasswordAuthConfig;

  factory EmailPasswordAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$EmailPasswordAuthConfigFromJson(json);
}

/// 手机号登录配置
@freezed
class PhoneAuthConfig with _$PhoneAuthConfig {
  const factory PhoneAuthConfig({
    @Default(true) bool isEnabled,
    @Default(60) int codeTimeout,
    @Default(6) int codeLength,
    String? defaultCountryCode,
    List<String>? allowedCountryCodes,
  }) = _PhoneAuthConfig;

  factory PhoneAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$PhoneAuthConfigFromJson(json);
}

/// 匿名登录配置
@freezed
class AnonymousAuthConfig with _$AnonymousAuthConfig {
  const factory AnonymousAuthConfig({
    @Default(true) bool isEnabled,
  }) = _AnonymousAuthConfig;

  factory AnonymousAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$AnonymousAuthConfigFromJson(json);
}

/// SAML配置
@freezed
class SAMLAuthConfig with _$SAMLAuthConfig {
  const factory SAMLAuthConfig({
    @Default(true) bool isEnabled,
    required String providerId,
    required String entityId,
    required String ssoUrl,
    required String x509Certificate,
    String? displayName,
    String? photoURL,
  }) = _SAMLAuthConfig;

  factory SAMLAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$SAMLAuthConfigFromJson(json);
}

/// OIDC配置
@freezed
class OIDCAuthConfig with _$OIDCAuthConfig {
  const factory OIDCAuthConfig({
    @Default(true) bool isEnabled,
    required String providerId,
    required String clientId,
    required String issuer,
    String? clientSecret,
    String? displayName,
    String? photoURL,
  }) = _OIDCAuthConfig;

  factory OIDCAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$OIDCAuthConfigFromJson(json);
}

/// 综合认证配置
@freezed
class FirebaseAuthConfig with _$FirebaseAuthConfig {
  const factory FirebaseAuthConfig({
    GoogleAuthConfig? google,
    FacebookAuthConfig? facebook,
    AppleAuthConfig? apple,
    TwitterAuthConfig? twitter,
    GitHubAuthConfig? github,
    MicrosoftAuthConfig? microsoft,
    YahooAuthConfig? yahoo,
    LinkedInAuthConfig? linkedin,
    EmailPasswordAuthConfig? emailPassword,
    PhoneAuthConfig? phone,
    AnonymousAuthConfig? anonymous,
    SAMLAuthConfig? saml,
    OIDCAuthConfig? oidc,
  }) = _FirebaseAuthConfig;

  factory FirebaseAuthConfig.fromJson(Map<String, dynamic> json) =>
      _$FirebaseAuthConfigFromJson(json);
} 