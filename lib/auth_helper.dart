import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  authAnonymous() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }

  authEmail() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "umangkaklotar02@gmail.com", password: "Umang@2004");
    } catch (e) {
      print(e);
    }
  }

  authGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print("Email: ${googleUser!.email}");
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
