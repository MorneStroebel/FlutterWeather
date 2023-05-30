
import 'package:flutter/material.dart';
import 'package:flutter_weather/core/navigation/routes.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
            ()
        {
          Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
        }
    );
  }

  @override
  Widget build(BuildContext context){

    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SizedBox(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Lottie.asset(
                          'assets/anim/loading_indicator.json',
                          fit: BoxFit.fill,
                        height: screenWidth,
                        width: screenWidth
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: screenWidth,
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 80),
                              child: Text(
                                  "Flutter",
                                style: TextStyle(
                                  fontFamily: 'ArialRound',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            Text(
                                "weather",
                              style: TextStyle(
                                  fontFamily: 'ArialRound',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}