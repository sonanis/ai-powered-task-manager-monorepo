# AI-Powered Task Manager

[![Flutter](https://img.shields.io/badge/Flutter-3.19.0-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.3.0-blue.svg)](https://dart.dev/)
[![Melos](https://img.shields.io/badge/Melos-3.1.0-green.svg)](https://melos.invertase.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A modern, AI-powered task management application built with Flutter, featuring intelligent task organization, smart reminders, and cross-platform support.

## 🚀 Features

- **AI-Powered Task Management**: Intelligent task categorization and prioritization
- **Cross-Platform Support**: iOS, Android, Web, macOS, Windows, Linux
- **Modern Architecture**: Clean Architecture with MVVM pattern
- **State Management**: Riverpod, Bloc, and Provider for different use cases
- **Authentication**: Firebase Authentication with multiple providers
- **Responsive Design**: Material Design 3 with adaptive layouts
- **Monorepo Structure**: Managed with Melos for efficient development

## 🏗️ Architecture

This project follows Clean Architecture principles with a feature-based structure:

```
lib/
├── core/           # Core utilities, DI, routing, theming
├── features/       # Feature modules
│   ├── ai/        # AI-powered features
│   ├── auth/      # Authentication
│   ├── settings/  # App settings
│   └── task/      # Task management
└── shared/        # Shared components and services
```

## 🛠️ Tech Stack

### Frontend
- **Flutter 3.19.0** - Cross-platform UI framework
- **Dart 3.3.0** - Programming language
- **Material Design 3** - Design system

### State Management
- **Riverpod** - Primary state management (v2.4+)
- **Bloc** - Event-driven architecture
- **Provider** - Lightweight state management

### Architecture & DI
- **Get_it** - Dependency injection
- **Clean Architecture** - Software architecture pattern
- **MVVM** - Presentation layer pattern

### Networking & Data
- **Dio** - HTTP client
- **Retrofit** - Type-safe API client
- **Firebase** - Backend services
- **Hive** - Local data storage
- **SharedPreferences** - Key-value storage

### Development Tools
- **Melos** - Monorepo management
- **Freezed** - Immutable data classes
- **Go Router** - Type-safe routing
- **Responsive Framework** - Adaptive layouts

## 📦 Project Structure

```
ai_powered_task_manager_monorepo/
├── apps/
│   └── ai_powered_task_manager/    # Main Flutter application
├── packages/
│   └── firebase_auth_kit/          # Firebase authentication library
├── melos.yaml                      # Melos configuration
└── pubspec.yaml                    # Root dependencies
```

## 🚀 Getting Started

### Prerequisites

- Flutter 3.19.0 or higher
- Dart 3.3.0 or higher
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/ai_powered_task_manager_monorepo.git
   cd ai_powered_task_manager_monorepo
   ```

2. **Install Melos globally**
   ```bash
   dart pub global activate melos
   ```

3. **Bootstrap the project**
   ```bash
   melos bootstrap
   ```

4. **Run the application**
   ```bash
   melos run dev
   ```

### Development Commands

```bash
# Bootstrap dependencies
melos bootstrap

# Clean all packages
melos clean

# Run tests
melos test

# Analyze code
melos analyze

# Generate code
melos codegen

# Build for all platforms
melos build

# Run development server
melos dev
```

## 📱 Platform Support

| Platform | Status |
|----------|--------|
| iOS | ✅ Supported |
| Android | ✅ Supported |
| Web | ✅ Supported |
| macOS | ✅ Supported |
| Windows | ✅ Supported |
| Linux | ✅ Supported |

## 🔧 Configuration

### Firebase Setup

1. Create a Firebase project
2. Add your apps (iOS, Android, Web)
3. Download configuration files:
   - `google-services.json` for Android
   - `GoogleService-Info.plist` for iOS
   - Web configuration for web platform

### Environment Variables

Create `.env` file in the root directory:

```env
FIREBASE_API_KEY=your_api_key
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_APP_ID=your_app_id
```

## 🧪 Testing

```bash
# Run all tests
melos test

# Run tests with coverage
melos test --coverage

# Run specific package tests
melos test --scope=ai_powered_task_manager
```

## 📦 Building

```bash
# Build for all platforms
melos build

# Build specific platform
melos build --scope=ai_powered_task_manager --platform=web
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style

- Follow Dart/Flutter conventions
- Use meaningful commit messages
- Write tests for new features
- Update documentation as needed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod team for state management
- Firebase team for backend services
- Material Design team for design system

## 📞 Support

If you have any questions or need help, please:

1. Check the [Issues](https://github.com/your-username/ai_powered_task_manager_monorepo/issues) page
2. Create a new issue if your problem isn't already listed
3. Join our [Discord](https://discord.gg/your-server) community

---

**Made with ❤️ by [Your Name]** 