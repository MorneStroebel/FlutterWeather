import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/core/enums/signUpEnums.dart';
import 'package:flutter_weather/core/firebase/signUp.dart';
import 'package:flutter_weather/core/models/themeModel.dart';
import 'package:flutter_weather/src/widgets/passwordTextInput.dart';
import 'package:flutter_weather/src/widgets/snackbar.dart';
import 'package:flutter_weather/src/widgets/textInput.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount>
    with SingleTickerProviderStateMixin {

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  var userCollection = FirebaseFirestore.instance.collection('users');

  late AnimationController controller;

  bool passwordVisible = false;

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
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    controller.dispose();
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
                          onLoaded: (animation) {
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
                                      'Fill in all fields to register your new account',
                                      style: Provider
                                          .of<ThemeModel>(context)
                                          .currentTheme
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 18),
                                    ),
                                  ),
                                  TextInput(
                                      icon: Icons.person,
                                      controller: _usernameController,
                                      hintText: 'Enter your username...',
                                      labelText: 'Username'
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: TextInput(
                                        icon: Icons.email,
                                        controller: _emailController,
                                        hintText: 'Enter your email...',
                                        labelText: 'Email'
                                    ),
                                  ),
                                  PassTextInput(
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
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50.0),
                                    child: MaterialButton(
                                        onPressed: () async {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          late bool isValidEmail = EmailValidator.validate(_emailController.text);
                                          if(_emailController.text.isEmpty || _passwordController.text.isEmpty || _usernameController.text.isEmpty) {
                                            ErrorSnackBar.show(
                                                context,
                                                'Please fill in all fields'
                                            );
                                          }
                                          else if(!isValidEmail){
                                            ErrorSnackBar.show(
                                                context,
                                                'Invalid email'
                                            );
                                          }
                                          else {
                                            signUp(
                                                _emailController.text,
                                                _passwordController.text,
                                                _usernameController.text
                                            ).then((state) {
                                              switch (state) {
                                                case SignUpEnums.correct:
                                                  Navigator.of(context).pop();
                                                  break;
                                                case SignUpEnums.weakPassword:
                                                  ErrorSnackBar.show(context,
                                                      'password must be 6 characters or longer');
                                                  break;
                                                case SignUpEnums.emailAlreadyExists:
                                                  ErrorSnackBar.show(
                                                      context, 'Email already exists!');
                                                  break;
                                              }
                                            });
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
                                            "Register",
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
                    'SignUp',
                    style: Provider
                        .of<ThemeModel>(context)
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