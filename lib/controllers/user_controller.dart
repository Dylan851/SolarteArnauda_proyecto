import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController {
  static String? nombre = "";
  static String? email = "";
  static String? foto = "";

  static Future<UserCredential?> loginGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      // Recogemos los datos:
      nombre = googleUser.displayName ?? "";
      email = googleUser.email ?? "";
      foto = googleUser.photoUrl ?? "";

      return userCredential;
    } catch (e) {
      return null;
    }
  }

  static Future<User?> signInWithGoogleWeb() async {
    try {
      final provider = GoogleAuthProvider();
      provider.addScope('email');
      provider.addScope('profile');

      final userCredential = await FirebaseAuth.instance.signInWithPopup(
        provider,
      );
      final user = userCredential.user;

      nombre = user?.displayName;
      email = user?.email;
      foto = user?.photoURL;

      return user;
    } catch (e) {
      return null;
    }
  }
}
