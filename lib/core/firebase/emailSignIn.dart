import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_weather/core/enums/sign_in_enum.dart';

Future<SignIn?> emailSignIn(String emailAddress,   String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password
    );
    return SignIn.correct;
  }
  on FirebaseAuthException
  catch (e) {
    if (e.code == 'user-not-found') {
      return SignIn.inCorrectEmailPassword;

    } else if (e.code == 'wrong-password') {
      return SignIn.inCorrectEmailPassword;
    }
  }
  return null;
}