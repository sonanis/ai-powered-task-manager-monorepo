# firebase_auth_kit Example 示例

本目录包含 `firebase_auth_kit` 的使用示例。

This directory contains usage examples for `firebase_auth_kit`.

## 📱 示例列表 / Examples

### 1. Google 登录示例 / Google Sign-In Example

**入口文件**: `main.dart`

**运行命令**:
```bash
cd example
flutter pub get
flutter run
```

**功能特性**:
- Google 登录集成
- 静默登录
- 匿名登录
- 用户信息显示

### 2. Facebook 登录示例 / Facebook Sign-In Example

**入口文件**: `facebook_main.dart`

**运行命令**:
```bash
cd example
flutter pub get
flutter run -t facebook_main.dart
```

**功能特性**:
- Facebook 登录集成
- 静默登录
- 权限管理
- 用户信息显示
- 匿名登录

**详细文档**: [Facebook 示例文档](./FACEBOOK_EXAMPLE_README.md)

## 🚀 快速开始 / Quick Start

### 环境要求 / Requirements

- Flutter SDK: >=3.10.0
- Dart SDK: >=3.0.0
- Firebase 项目配置
- 相应的平台配置（Android/iOS/Web）

### 安装依赖 / Install Dependencies

```bash
cd example
flutter pub get
```

### 配置 Firebase / Configure Firebase

1. 在 Firebase Console 中创建项目
2. 下载并配置 `firebase_options.dart`
3. 启用相应的登录方式（Google/Facebook）

### 运行示例 / Run Examples

#### Google 登录示例
```bash
flutter run
```

#### Facebook 登录示例
```bash
flutter run -t facebook_main.dart
```

## 📋 示例说明 / Example Descriptions

### Google 登录示例 / Google Sign-In Example

- 初始化 Firebase Auth Kit
- 配置 Google 登录
- 实现登录、静默登录、退出登录功能
- 显示用户信息

### Facebook 登录示例 / Facebook Sign-In Example

- 初始化 Firebase Auth Kit
- 配置 Facebook 登录
- 实现登录、静默登录、权限管理功能
- 显示用户信息和权限状态
- 支持匿名登录

## 🔧 技术实现 / Technical Implementation

### 架构模式 / Architecture Pattern

- **依赖注入**：使用 Provider 接口模式
- **配置管理**：统一的认证配置管理
- **错误处理**：完善的错误处理和用户反馈
- **状态管理**：使用 setState 管理 UI 状态

### 核心组件 / Core Components

- `GoogleSignInProvider`：Google 登录提供者接口
- `FacebookSignInProvider`：Facebook 登录提供者接口
- `FirebaseAuthService`：Firebase 认证服务
- `AuthProvider`：状态管理提供者

## 📚 相关文档 / Related Documentation

- [Firebase Auth Kit 主文档](../README.md)
- [Facebook 登录集成指南](../FACEBOOK_SIGN_IN_GUIDE.md)
- [Google 登录集成指南](../GOOGLE_SIGN_IN_GUIDE.md)

## 🤝 贡献 / Contributing

欢迎提交 Issue 和 Pull Request！

Feel free to submit issues and pull requests!

---

**作者**: Er.Lin - Flutter工程师，9年Android开发经验，4年Flutter经验 