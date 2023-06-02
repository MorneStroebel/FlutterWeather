import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/core/enums/sign_in_enum.dart';
import 'package:flutter_weather/core/models/themeModel.dart';
import 'package:flutter_weather/core/navigation/routes.dart';
import 'package:flutter_weather/core/services/locationService.dart';
import 'package:flutter_weather/src/viewmodels/login_view_model.dart';
import 'package:flutter_weather/src/widgets/passwordTextInput.dart';
import 'package:flutter_weather/src/widgets/snackbar.dart';
import 'package:flutter_weather/src/widgets/textInput.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  LocationService locationService = LocationService();

  bool passwordVisible = false;
  LoginViewModel viewModel = LoginViewModel();
  late bool hasLocation;
  late AnimationController controller;
  late Future<LocationData?>? location;


  @override
  void initState() {
    super.initState();
    location = locationService.getLocation();
    viewModel.passwordTextController = TextEditingController();
    viewModel.emailTextController = TextEditingController();

    controller = AnimationController(
        duration: const Duration(seconds: 5),
        vsync: this
    );
    passwordVisible = true;
  }

  @override
  void dispose() {
    controller.dispose();
   viewModel.emailTextController.dispose();
   viewModel.passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;

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
                                  controller: viewModel.emailTextController,
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
                                    controller: viewModel.passwordTextController,
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
                                  onPressed: () async {
                                    SignInEnum result = await viewModel.signInWithEmail();
                                    if(mounted){
                                      if(result == SignInEnum.emptyFields) ErrorSnackBar.show(context, 'fill in all fields');
                                      if(result == SignInEnum.inValidEmail) ErrorSnackBar.show(context, 'invalid email');
                                      if(result == SignInEnum.inCorrectEmailPassword) ErrorSnackBar.show(context, 'incorrect email or password');
                                      if(result == SignInEnum.correct && location != null) Navigator.of(context).pushReplacementNamed(Routes.homePage);
                                      if(result == SignInEnum.correct && location == null) Navigator.of(context).pushReplacementNamed(Routes.noLocation);
                                    }
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