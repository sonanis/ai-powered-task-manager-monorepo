import 'package:get_it/get_it.dart';

/// 全局依赖注入容器
final GetIt getIt = GetIt.instance;

/// 配置依赖注入
Future<void> configureDependencies() async {
  // 注册服务
  // getIt.registerSingleton<AuthService>(AuthService());
  // getIt.registerSingleton<TaskRepository>(TaskRepository());
  // getIt.registerSingleton<ApiService>(ApiService());
  
  // 注册工厂
  // getIt.registerFactory<TaskBloc>(() => TaskBloc(getIt<TaskRepository>()));
  
  // 注册异步单例
  // getIt.registerSingletonAsync<DatabaseService>(() async {
  //   final db = DatabaseService();
  //   await db.initialize();
  //   return db;
  // });
  
  // 暂时为空，后续添加具体实现
} 