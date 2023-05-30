import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_weather/core/enums/signUpEnums.dart';

Future<SignUpEnums?> signUp(String emailAddress, String password, String userName) async {

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    User? updateUser  = FirebaseAuth.instance.currentUser;
    updateUser?.updateDisplayName(userName);
    return SignUpEnums.correct;

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return SignUpEnums.weakPassword;
    } else if (e.code == 'email-already-in-use') {
      return SignUpEnums.emailAlreadyExists;
    }
  }
  return null;
}