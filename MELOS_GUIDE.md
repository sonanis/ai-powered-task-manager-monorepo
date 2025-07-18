# Melos 使用指南

本项目使用 Melos 来管理 Monorepo，提供统一的开发、构建和发布工作流。

## 🚀 快速开始

### 安装 Melos
```bash
dart pub global activate melos
```

### 初始化项目
```bash
# 安装所有依赖
melos bootstrap

# 运行代码生成
melos run codegen
```

## 📋 可用命令

### 基础命令
```bash
# 安装依赖
melos bootstrap

# 清理构建文件
melos clean

# 代码分析
melos run analyze

# 运行测试
melos run test

# 格式化代码
melos run format
```

### 开发命令
```bash
# 启动Web开发服务器
melos run dev:web

# 启动Android开发
melos run dev:android

# 启动iOS开发
melos run dev:ios
```

### 构建命令
```bash
# 构建Web版本
melos run build:web

# 构建Android版本
melos run build:android

# 构建iOS版本
melos run build:ios
```

### 代码生成
```bash
# 生成Freezed代码
melos run codegen
```

### 发布命令
```bash
# 发布firebase_auth_kit到pub.dev（预览）
melos run pub:publish
```

### 依赖管理
```bash
# 检查依赖更新
melos run deps:check

# 升级依赖
melos run deps:upgrade
```

### 工作流命令
```bash
# CI/CD工作流
melos run workflow:ci

# 发布前准备
melos run workflow:prepublish
```

## 🏗️ 项目结构

```
ai_powered_task_manager_monorepo/
├── melos.yaml                    # Melos配置
├── pubspec.yaml                  # 根目录依赖
├── apps/
│   └── ai_powered_task_manager/  # 主应用
├── packages/
│   └── firebase_auth_kit/        # 认证库
└── PROJECT_SUMMARY.md            # 项目总结
```

## 🔧 包管理

### 针对特定包运行命令
```bash
# 只对firebase_auth_kit运行测试
melos exec --scope firebase_auth_kit -- "flutter test"

# 只对主应用运行构建
melos exec --scope ai_powered_task_manager -- "flutter build web"
```

### 并行执行
```bash
# 并行运行所有包的测试
melos exec -c 1 "flutter test"

# 并行运行代码分析
melos exec -c 1 "flutter analyze"
```

## 📦 包说明

### firebase_auth_kit
- **类型**: Flutter Package
- **功能**: Firebase认证库，支持多平台登录
- **测试**: `melos exec --scope firebase_auth_kit -- "flutter test"`
- **代码生成**: `melos exec --scope firebase_auth_kit -- "flutter packages pub run build_runner build"`

### ai_powered_task_manager
- **类型**: Flutter Application
- **功能**: AI驱动的任务管理应用
- **开发**: `melos run dev:web` / `melos run dev:android` / `melos run dev:ios`
- **构建**: `melos run build:web` / `melos run build:android` / `melos run build:ios`

## 🛠️ 开发工作流

### 日常开发
```bash
# 1. 启动开发环境
melos bootstrap

# 2. 代码生成（如果需要）
melos run codegen

# 3. 启动开发服务器
melos run dev:web

# 4. 运行测试
melos run test

# 5. 代码分析
melos run analyze
```

### 发布前检查
```bash
# 运行完整的发布前检查
melos run workflow:prepublish
```

### CI/CD集成
```bash
# 运行CI/CD工作流
melos run workflow:ci
```

## 📝 配置说明

### melos.yaml 配置
- **packages**: 定义包含的包路径
- **scripts**: 定义可执行的脚本命令
- **packageFilters**: 过滤特定包执行命令
- **scope**: 指定包范围
- **ignore**: 忽略特定包

### 环境要求
- Flutter SDK >= 3.4.3
- Dart SDK >= 3.4.3
- Melos >= 3.4.0

## 🚨 常见问题

### 1. 依赖冲突
```bash
# 清理并重新安装依赖
melos clean
melos bootstrap
```

### 2. 代码生成失败
```bash
# 清理构建文件
melos clean

# 重新生成代码
melos run codegen
```

### 3. 测试失败
```bash
# 检查特定包的测试
melos exec --scope firebase_auth_kit -- "flutter test"

# 查看详细错误信息
melos exec --scope firebase_auth_kit -- "flutter test --verbose"
```

## 📚 更多资源

- [Melos 官方文档](https://melos.invertase.dev/)
- [Flutter Monorepo 最佳实践](https://docs.flutter.dev/development/packages-and-plugins/developing-packages)
- [Firebase Flutter 文档](https://firebase.flutter.dev/)

---

**作者**: Er.Lin - Flutter工程师，9年Android开发经验，4年Flutter经验 