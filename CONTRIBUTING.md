# Contributing to AI-Powered Task Manager

Thank you for your interest in contributing to AI-Powered Task Manager! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Before You Start

1. **Check existing issues** - Your idea might already be discussed
2. **Read the documentation** - Understand the project structure and conventions
3. **Set up your development environment** - Follow the setup instructions in README.md

### Development Workflow

1. **Fork the repository**
   ```bash
   git clone https://github.com/your-username/ai_powered_task_manager_monorepo.git
   cd ai_powered_task_manager_monorepo
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-fix-name
   ```

3. **Make your changes**
   - Follow the coding standards below
   - Write tests for new features
   - Update documentation as needed

4. **Test your changes**
   ```bash
   melos test
   melos analyze
   ```

5. **Commit your changes**
   ```bash
   git commit -m "feat: add new feature description"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Use the PR template
   - Describe your changes clearly
   - Link any related issues

## 📋 Pull Request Guidelines

### PR Title Format
Use conventional commit format:
- `feat: add new feature`
- `fix: resolve bug`
- `docs: update documentation`
- `style: format code`
- `refactor: restructure code`
- `test: add tests`
- `chore: maintenance tasks`

### PR Description Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Tests added/updated
```

## 🎯 Coding Standards

### Dart/Flutter Conventions

1. **File Naming**
   - Use snake_case for file names: `user_repository.dart`
   - Use PascalCase for class names: `UserRepository`

2. **Code Style**
   - Follow Dart analyzer rules
   - Use meaningful variable names
   - Keep functions small and focused
   - Add comments for complex logic

3. **Architecture**
   - Follow Clean Architecture principles
   - Use dependency injection with Get_it
   - Implement proper error handling
   - Use appropriate state management patterns

### State Management Guidelines

- **Riverpod**: For complex state management
- **Bloc**: For event-driven features
- **Provider**: For simple state sharing

### Testing Standards

1. **Unit Tests**
   - Test all business logic
   - Mock dependencies
   - Use descriptive test names

2. **Widget Tests**
   - Test UI components
   - Verify user interactions
   - Test responsive behavior

3. **Integration Tests**
   - Test complete user flows
   - Test cross-platform compatibility

## 🏗️ Project Structure

### Adding New Features

1. **Create feature directory**
   ```
   lib/features/your_feature/
   ├── data/
   │   ├── datasources/
   │   ├── models/
   │   └── repositories/
   ├── domain/
   │   ├── entities/
   │   ├── repositories/
   │   └── usecases/
   └── presentation/
       ├── bloc/
       ├── pages/
       └── widgets/
   ```

2. **Follow naming conventions**
   - Models: `UserModel`
   - Entities: `User`
   - Repositories: `UserRepository`
   - Use Cases: `GetUserUseCase`

### Adding New Packages

1. **Create package structure**
   ```
   packages/your_package/
   ├── lib/
   ├── test/
   ├── pubspec.yaml
   └── README.md
   ```

2. **Update melos.yaml**
   - Add package to packages list
   - Configure scripts if needed

## 🐛 Bug Reports

### Before Reporting

1. Check existing issues
2. Try to reproduce the bug
3. Check if it's a known issue

### Bug Report Template

```markdown
## Bug Description
Clear description of the bug

## Steps to Reproduce
1. Step 1
2. Step 2
3. Step 3

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- OS: [e.g., macOS 14.0]
- Flutter: [e.g., 3.19.0]
- Dart: [e.g., 3.3.0]

## Additional Information
Screenshots, logs, etc.
```

## 💡 Feature Requests

### Before Requesting

1. Check if the feature already exists
2. Consider if it fits the project scope
3. Think about implementation complexity

### Feature Request Template

```markdown
## Feature Description
Clear description of the feature

## Use Case
Why this feature is needed

## Proposed Implementation
How you think it should be implemented

## Alternatives Considered
Other approaches you considered

## Additional Information
Mockups, examples, etc.
```

## 📚 Documentation

### Writing Documentation

1. **Keep it clear and concise**
2. **Use examples**
3. **Update when code changes**
4. **Include code snippets**

### Documentation Types

- **API Documentation**: Use dartdoc comments
- **User Guides**: Step-by-step instructions
- **Developer Guides**: Technical implementation details

## 🚀 Release Process

### Versioning

We use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Checklist

- [ ] All tests pass
- [ ] Documentation updated
- [ ] Version numbers updated
- [ ] Changelog updated
- [ ] Release notes prepared

## 🤝 Community Guidelines

### Be Respectful
- Use inclusive language
- Be patient with newcomers
- Provide constructive feedback

### Communication
- Use clear, concise language
- Ask questions when unsure
- Share knowledge and help others

### Code of Conduct
- Be respectful and inclusive
- Focus on what is best for the community
- Show empathy towards other community members

## 📞 Getting Help

### Questions and Support

1. **Check the documentation**
2. **Search existing issues**
3. **Ask in discussions**
4. **Join our community**

### Contact Information

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Discord**: For real-time chat and support

## 🙏 Recognition

Contributors will be recognized in:
- Project README
- Release notes
- Contributor hall of fame

Thank you for contributing to AI-Powered Task Manager! 🎉 