import 'package:firebase_auth_kit/firebase_auth_kit.dart';
import 'package:google_sign_in/google_sign_in.dart' as g;

/// GoogleSignInProvider 的实际实现
class MyGoogleSignInProvider implements GoogleSignInProvider {
  final g.GoogleSignIn _googleSignIn;

  MyGoogleSignInProvider({String? clientId})
      : _googleSignIn = g.GoogleSignIn(
          clientId: clientId,
          scopes: ['email', 'profile'],
        );

  @override
  Future<GoogleSignInAccount?> signIn() async {
    final account = await _googleSignIn.signIn();
    if (account == null) return null;
    final auth = await account.authentication;
    // 用 kit 的 GoogleSignInAccount 包装
    return GoogleSignInAccount(
      id: account.id,
      email: account.email,
      displayName: account.displayName,
      photoUrl: account.photoUrl,
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
  }

  @override
  Future<GoogleSignInAccount?> signInSilently() async {
    final account = await _googleSignIn.signInSilently();
    if (account == null) return null;
    final auth = await account.authentication;
    return GoogleSignInAccount(
      id: account.id,
      email: account.email,
      displayName: account.displayName,
      photoUrl: account.photoUrl,
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
  }

  @override
  Future<void> signOut() => _googleSignIn.signOut();

  @override
  Future<GoogleSignInAccount?> getCurrentUser() async {
    final account = await _googleSignIn.signInSilently();
    if (account == null) return null;
    final auth = await account.authentication;
    return GoogleSignInAccount(
      id: account.id,
      email: account.email,
      displayName: account.displayName,
      photoUrl: account.photoUrl,
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
  }

  @override
  Future<bool> isSignedIn() => _googleSignIn.isSignedIn();
}