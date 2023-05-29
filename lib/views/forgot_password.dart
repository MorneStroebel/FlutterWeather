import 'package:flutter/material.dart';
import 'package:flutter_weather/models/themeModel.dart';
import 'package:flutter_weather/navigation/routes.dart';
import 'package:flutter_weather/widgets/textInput.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {

  final _emailController = TextEditingController();

  late AnimationController controller;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 5),
        vsync: this
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Stack(
                children: [
                  SizedBox(
                      width: screenWidth,
                      height: double.infinity,
                      child: Lottie.asset(
                          "assets/anim/background_day_to_night.json",
                          fit: BoxFit.cover,
                          controller: controller,
                          onLoaded: (animation){
                            controller.reverse(from: 100);
                          }
                      )
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          width: screenWidth * 0.8,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 50),
                                    child: Text(
                                      'Enter your email, we will send you password reset instructions',
                                      style: Provider.of<ThemeModel>(context)
                                          .currentTheme
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 18),
                                    ),
                                  ),
                                  TextInput(
                                      icon: Icons.email,
                                      controller: _emailController,
                                      hintText: 'Enter your email...',
                                      labelText: 'Email'
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50.0),
                                    child: MaterialButton(
                                        onPressed: (){
                                          Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
                                        },
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                AppBar(
                  title: Text(
                    'Reset password',
                    style: Provider.of<ThemeModel>(context)
                        .currentTheme
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 26),
                  ),
                  centerTitle: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                  ),
                  elevation: 20,
                  backgroundColor: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}