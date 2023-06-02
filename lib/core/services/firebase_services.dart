import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_weather/core/enums/emailCheck.dart';
import 'package:flutter_weather/core/enums/signUpEnums.dart';
import 'package:flutter_weather/core/enums/sign_in_enum.dart';

class FirebaseServices {

  Future<SignInEnum> emailSignIn(String emailAddress, String password) async {
    try {
      await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      return SignInEnum.correct;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') return SignInEnum.inCorrectEmailPassword;
      return SignInEnum.unknownError;
    }
  }

  Future<EmailCheck> checkIfEmailInUse(String emailAddress) async {
    final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);
    if (list.isNotEmpty) return EmailCheck.isUser;
    return EmailCheck.notUser;
  }

  sendForgotPasswordEmail(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<SignUpEnums> signUp(String emailAddress, String password, String username) async {
    try {
     await _createNewUer(emailAddress, password, username);

     return SignUpEnums.correct;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') return SignUpEnums.weakPassword;
      if (e.code == 'email-already-in-use') return SignUpEnums.emailAlreadyExists;
      return SignUpEnums.unknownError;
    }

  }

  Future<void> _createNewUer(String emailAddress, String password, String username) async {
   await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

   User? updateUser  = FirebaseAuth.instance.currentUser;
   updateUser?.updateDisplayName(username);
  }

  User? isUserLogin () {
    return FirebaseAuth.instance.currentUser;
  }




}