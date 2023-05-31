import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/core/enums/locationEnums.dart';
import 'package:flutter_weather/core/enums/sign_in_enum.dart';
import 'package:flutter_weather/core/firebase/emailSignIn.dart';
import 'package:flutter_weather/core/models/themeModel.dart';
import 'package:flutter_weather/core/navigation/routes.dart';
import 'package:flutter_weather/core/services/locationService.dart';
import 'package:flutter_weather/src/widgets/passwordTextInput.dart';
import 'package:flutter_weather/src/widgets/snackbar.dart';
import 'package:flutter_weather/src/widgets/textInput.dart';
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
  void initState() {
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
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              SizedBox(
                  width: screenWidth,
                  height: double.infinity,
                  child: Lottie.asset(
                      'assets/anim/background_day_to_night.json',
                      fit: BoxFit.cover,
                      controller: controller,
                      onLoaded: (animation) {
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
                      color: Provider
                          .of<ThemeModel>(
                          context,
                          listen: false
                      )
                          .currentTheme
                          .colorScheme
                          .onSurface,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Welcome back',
                              style: Provider
                                  .of<ThemeModel>(context)
                                  .currentTheme
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                  fontSize: 32, fontWeight: FontWeight.w900),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'Login to continue',
                                style: Provider
                                    .of<ThemeModel>(context)
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
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 2),
                                child: PassTextInput(
                                    onPressed: () {
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
                                      style: Provider
                                          .of<ThemeModel>(context)
                                          .currentTheme
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(fontSize: 18),
                                      text: "Forgot password?",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          Navigator.of(context).pushNamed(
                                              Routes.forgotPassword);
                                        }
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: MaterialButton(
                                  onPressed: () {
                                    checkLocationPermission().then((permission){
                                      if(permission == LocationPermissionsState.enabled){
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();

                                        late bool isValidEmail = EmailValidator
                                            .validate(_emailController.text);

                                        if (_emailController.text.isEmpty ||
                                            _passwordController.text.isEmpty) {
                                          ErrorSnackBar.show(
                                              context,
                                              'Please fill in both email and password'
                                          );
                                        } else if (!isValidEmail) {
                                          ErrorSnackBar.show(
                                              context,
                                              'Invalid email or password'
                                          );
                                        } else {
                                          emailSignIn(
                                              _emailController.text,
                                              _passwordController.text
                                          ).then((state) {
                                            switch (state) {
                                              case SignIn.correct:
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                    Routes.homePage);
                                                break;
                                              case SignIn.inCorrectEmailPassword:
                                                ErrorSnackBar.show(
                                                    context,
                                                    'Incorrect email or password'
                                                );
                                            }
                                          });
                                        }
                                      } else if(permission == LocationPermissionsState.notEnabled){
                                        ErrorSnackBar.show(
                                            context,
                                            'Location services are disabled. Please enable the services'
                                        );
                                      } else if(permission == LocationPermissionsState.denied){
                                        ErrorSnackBar.show(
                                            context,
                                            'Location permissions are denied'
                                        );
                                      } else if(permission == LocationPermissionsState.permanentDisabled){
                                        ErrorSnackBar.show(
                                            context,
                                            'Location permissions are permanently denied, we cannot request permissions.'
                                        );
                                      }
                                    });

                                  },
                                  color: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                                      style: Provider
                                          .of<ThemeModel>(context)
                                          .currentTheme
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 26),
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
                                      style: Provider
                                          .of<ThemeModel>(context)
                                          .currentTheme
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 16),
                                      children: [
                                        const TextSpan(
                                            text: "Don't have an account? "),
                                        TextSpan(
                                            style: Provider
                                                .of<ThemeModel>(context)
                                                .currentTheme
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                              fontSize: 18,
                                            ),
                                            text: "Sign up\n",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                Navigator.of(context).pushNamed(
                                                    Routes.signUp);
                                              }
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