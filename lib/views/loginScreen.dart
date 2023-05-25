import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 @override
 Widget build(BuildContext context){

   final double screenHeight = MediaQuery.of(context).size.height * 0.95;
   final double screenWidth = MediaQuery.of(context).size.width * 0.9;

   return Scaffold(
     body: Center(
       child: SizedBox(
         height: screenHeight,
         width: screenWidth,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: const [
             Text("Hello")
           ],
         ),
       ),
     ),
   );
 }
}