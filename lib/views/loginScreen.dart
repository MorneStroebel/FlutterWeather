import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/models/themeModel.dart';
import 'package:flutter_weather/navigation/routes.dart';
import 'package:flutter_weather/widgets/passwordTextInput.dart';
import 'package:flutter_weather/widgets/textInput.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passwordVisible = false;
  
  late AnimationController controller;
  
  @override
  void initState(){
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
        vsync: this
    );
    passwordVisible = true;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
 @override
 Widget build(BuildContext context){

   final double screenHeight = MediaQuery.of(context).size.height;
   final double screenWidth = MediaQuery.of(context).size.width;

   return Scaffold(
     body: Center(
       child: SafeArea(
         child: Stack(
           children: [
             SizedBox(
               width: screenWidth,
               height: double.infinity,
               child: Lottie.network(
                   "https://assets8.lottiefiles.com/private_files/lf30_dbkiaaqd.json",
                   fit: BoxFit.cover,
                   controller: controller,
                   onLoaded: (animation){
                     controller.forward();
                     controller.reverse(from: 100);
                   }
               )
             ),
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Center(
                   child: Container(
                     width: screenWidth * 0.8,
                     color: Colors.black.withOpacity(0.5),
                     child: Padding(
                       padding: const EdgeInsets.all(20),
                       child: Column(
                         children: [
                           Text(
                             'Welcome back',
                             style: Provider.of<ThemeModel>(context)
                                 .currentTheme
                                 .textTheme
                                 .bodyMedium
                                 ?.copyWith(fontSize: 32, fontWeight: FontWeight.w900),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 5),
                             child: Text(
                               'Login to continue',
                               style: Provider.of<ThemeModel>(context)
                                   .currentTheme
                                   .textTheme
                                   .bodyMedium
                                   ?.copyWith(fontSize: 22),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 50),
                             child: TextInput(
                                 icon: Icons.email,
                                 controller: _emailController,
                                 hintText: "Enter your email...",
                                 labelText: "Email"
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 20, bottom: 2),
                             child: PassTextInput(
                                 onPressed: (){
                                   setState(() {
                                     passwordVisible = !passwordVisible;
                                   });
                                 },
                                 passwordVisible: passwordVisible,
                                 icon: Icons.lock,
                                 controller: _passwordController,
                                 hintText: 'Enter your password...',
                                 labelText: 'Password'
                             )
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Text.rich(
                                 TextSpan(
                                     style: Provider.of<ThemeModel>(context)
                                         .currentTheme
                                         .textTheme
                                         .bodySmall
                                         ?.copyWith(fontSize: 18),
                                     text: "Forgot password?",
                                     recognizer: TapGestureRecognizer()
                                       ..onTap = () async {}
                                 ),
                               ),
                             ],
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 50.0),
                             child: MaterialButton(
                               onPressed: (){},
                               color: Colors.grey,
                                 shape: RoundedRectangleBorder(
                                   borderRadius:  BorderRadius.circular(10),
                                 ),
                                 child: Container(
                                 alignment: Alignment.center,
                                 constraints: BoxConstraints(
                                   minHeight: 30,
                                   maxWidth: screenWidth * 0.4,
                                 ),
                                 child: Text(
                                   "Login",
                                   textAlign: TextAlign.center,
                                   style: Provider.of<ThemeModel>(context).currentTheme.textTheme.bodyMedium?.copyWith(fontSize: 26),
                                 ),
                              )
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text.rich(TextSpan(
                                     style: Provider.of<ThemeModel>(context)
                                         .currentTheme
                                         .textTheme
                                         .bodyMedium
                                         ?.copyWith(fontSize: 16),
                                     children: [
                                       const TextSpan(text: "Don't have an account? "),
                                       TextSpan(
                                           style: Provider.of<ThemeModel>(context)
                                               .currentTheme
                                               .textTheme
                                               .bodySmall
                                               ?.copyWith(
                                             fontSize: 18,
                                           ),
                                           text: "Sign up\n",
                                           recognizer: TapGestureRecognizer()
                                             ..onTap = () async {}
                                       ),
                                     ])
                                 )
                               ],
                             ),
                           )
                         ],
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           ],
         ),
       ),
     ),
   );
 }
}