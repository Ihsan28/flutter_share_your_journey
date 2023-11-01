import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  static User? user = FirebaseAuth.instance.currentUser;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        user = authResult.user!;

        return authResult;
      }
    } catch (error) {
      print(error);
      // Handle errors here
    }
    return null;
  }

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = authResult.user!;
      return true;
    } catch (error) {
      print(error);
      // Handle errors here
    }
    return false;
  }

  Future<void> signout() async {
    if (user?.providerData[0].providerId == 'google.com') {
      FirebaseAuth.instance.signOut();
      await _googleSignIn.disconnect();
      if (_auth.isSignInWithEmailLink(user!.email!)) {
        await _auth.signOut();
      }
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      user = null;
    }
  }
}
