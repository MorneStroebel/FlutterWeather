import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/core/enums/emailCheck.dart';
import 'package:flutter_weather/core/models/themeModel.dart';
import 'package:flutter_weather/core/services/firebase_services.dart';
import 'package:flutter_weather/src/widgets/snackbar.dart';
import 'package:flutter_weather/src/widgets/textInput.dart';
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

  FirebaseServices firebaseServices = FirebaseServices();

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
                              color: Provider.of<ThemeModel>(
                                  context,
                                  listen: false
                              )
                                  .currentTheme
                                  .colorScheme
                                  .onSurface,
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
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          late bool isValidEmail = EmailValidator.validate(_emailController.text);
                                          if(_emailController.text.isEmpty){
                                            ErrorSnackBar.show(
                                                context,
                                                'Please enter your email address'
                                            );
                                          }
                                          else if(!isValidEmail) {
                                            ErrorSnackBar.show(
                                                context,
                                                'Invalid email or password'
                                            );
                                          } else {
                                            firebaseServices.checkIfEmailInUse(_emailController.text).then((state) {
                                              switch (state) {
                                                case EmailCheck.isUser:
                                                  firebaseServices.sendForgotPasswordEmail(_emailController.text);
                                                  Navigator.of(context).pop();
                                                  break;
                                                case EmailCheck.notUser:
                                                  ErrorSnackBar.show(context, 'Email not found');
                                                  break;
                                              }
                                            });
                                          }

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
                                            "Reset",
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
                  backgroundColor: Provider.of<ThemeModel>(
                      context,
                      listen: false
                  )
                      .currentTheme
                      .colorScheme
                      .onSurface,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}