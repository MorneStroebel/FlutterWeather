import 'package:firebase_auth/firebase_auth.dart';

Future<void> sendForgotPasswordEmail(String email) async{
  FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}