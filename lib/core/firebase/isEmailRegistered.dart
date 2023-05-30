import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_weather/core/enums/emailCheck.dart';

Future<EmailCheck?> checkIfEmailInUse(String emailAddress) async {
  final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);
  if (list.isNotEmpty) {
    return EmailCheck.isUser;
  } else {
    return EmailCheck.notUser;
  }
}