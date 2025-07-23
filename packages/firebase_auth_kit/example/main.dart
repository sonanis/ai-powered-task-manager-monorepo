import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 新增，直接用firebase_auth的User
import 'package:firebase_auth_kit/firebase_auth_kit.dart';
import 'firebase_options.dart';
import 'google_sign_in_provider_impl.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuthKit.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'firebase_auth_kit Google 登录示例',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const GoogleSignInDemoPage(),
    );
  }
}

class GoogleSignInDemoPage extends StatefulWidget {
  const GoogleSignInDemoPage({super.key});

  @override
  State<GoogleSignInDemoPage> createState() => _GoogleSignInDemoPageState();
}

class _GoogleSignInDemoPageState extends State<GoogleSignInDemoPage> {
  String _status = '未登录/Not signed in';
  User? _user;

  // 用你的clientId替换下面内容
  final FirebaseAuthConfig _config = FirebaseAuthConfig(
    google: GoogleAuthConfig(
      isEnabled: true,
      webClientId: '105823303997-9s7mi73qsc6slmbi14193as6pq6383rp.apps.googleusercontent.com',
      androidClientId: '105823303997-eu48geoopemd820vjp18r3caksmoskek.apps.googleusercontent.com',
      iosClientId: '105823303997-a2ke496904uvutd7f0gvan2bbmah6skk.apps.googleusercontent.com',
    ),
  );

  late final MyGoogleSignInProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = MyGoogleSignInProvider(clientId: getGoogleClientId());
    _checkIfAlreadySignedIn();
  }

  String getGoogleClientId() {
    if (kIsWeb) {
      return _config.google?.webClientId ?? '';
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _config.google?.androidClientId ?? '';
      case TargetPlatform.iOS:
        return _config.google?.iosClientId ?? '';
      default:
        return '';
    }
  }

  Future<void> _checkIfAlreadySignedIn() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        _user = currentUser;
        _status = '已登录/Already signed in';
      });
    } else {
      // 未登录，尝试静默登录
      setState(() {
        _user = null;
        _status = '尝试静默登录/Trying silent sign-in...';
      });
      final googleUser = await _provider.signInSilently();
      if (googleUser != null) {
        final credential = GoogleAuthProvider.credential(
          idToken: googleUser.idToken,
          accessToken: googleUser.accessToken,
        );
        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        setState(() {
          _user = userCredential.user;
          _status = '已自动登录/Auto signed in';
        });
      } else {
        setState(() {
          _user = null;
          _status = '未登录/Not signed in';
        });
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _status = '登录中/Signing in...';
    });

    try {
      final googleUser = await _provider.signIn();
      if (googleUser == null) {
        setState(() {
          _status = '用户取消登录/User cancelled sign in';
        });
        return;
      }
      // 用googleUser.idToken等信息与Firebase Auth集成
      final credential = GoogleAuthProvider.credential(
        idToken: googleUser.idToken,
        accessToken: googleUser.accessToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        _user = userCredential.user;
        _status = '登录成功/Sign in success';
      });
    } catch (e) {
      setState(() {
        _status = '登录失败/Sign in failed: $e';
      });
    }
  }

  // 退出登录功能
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      _user = null;
      _status = '已退出登录/Signed out';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google 登录示例 / Google Sign-In Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_status),
              const SizedBox(height: 16),
              if (_user != null) ...[
                Text('用户ID/User ID: ${_user!.uid}'),
                Text('邮箱/Email: ${_user!.email ?? "-"}'),
                Text('昵称/Name: ${_user!.displayName ?? "-"}'),
                if (_user!.photoURL != null)
                  Image.network(_user!.photoURL!, width: 80, height: 80),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _signInWithGoogle,
                child: const Text('使用Google登录 / Sign in with Google'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _signOut,
                child: const Text('退出登录 / Sign out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 