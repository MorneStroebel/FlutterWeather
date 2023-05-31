import 'package:flutter/material.dart';
import 'package:flutter_weather/core/models/themeModel.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

 @override
 HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  Location location = Location();

  getLocation() async {
    return await location.getLocation();
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return SafeArea(
        child: Scaffold(
            body: Center(
              child: SizedBox(
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentLocation.longitude.toString(),
                                  style: Provider
                                      .of<ThemeModel>(context)
                                      .currentTheme
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 28),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    DateFormat('EEEE, MMMM d').format(
                                        DateTime.now()),
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add_location_alt_rounded),
                              color: Provider
                                  .of<ThemeModel>(context)
                                  .currentTheme
                                  .colorScheme
                                  .onBackground,
                              iconSize: 40,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.4,
                        width: screenWidth,
                        child: Stack(
                          children: [
                            SizedBox(
                                width: screenWidth,
                                child: Lottie.asset('assets/anim/clear.json')
                            ),
                            SizedBox(
                              width: screenWidth,
                              height: screenHeight * 0.4,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 80),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "50 °C",
                                      style: Provider
                                          .of<ThemeModel>(context)
                                          .currentTheme
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 50,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      'weather type',
                                      style: Provider
                                          .of<ThemeModel>(context)
                                          .currentTheme
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          width: screenWidth,
                          decoration: BoxDecoration(
                              color: Provider
                                  .of<ThemeModel>(context)
                                  .currentTheme
                                  .colorScheme
                                  .background,
                              borderRadius: const BorderRadius.all(Radius
                                  .circular(25))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: SizedBox(
                                      width: (screenWidth - 100) / 3,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            'Wind',
                                            style: Provider
                                                .of<ThemeModel>(context)
                                                .currentTheme
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3),
                                            child: Text(
                                              '26km/h',
                                              style: Provider
                                                  .of<ThemeModel>(context)
                                                  .currentTheme
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    width: 1,
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: SizedBox(
                                      width: (screenWidth - 80) / 3,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            'Humidity',
                                            style: Provider
                                                .of<ThemeModel>(context)
                                                .currentTheme
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3),
                                            child: Text(
                                              '90%',
                                              style: Provider
                                                  .of<ThemeModel>(context)
                                                  .currentTheme
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    width: 1,
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: SizedBox(
                                      width: (screenWidth - 100) / 3,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            'Pressure',
                                            style: Provider
                                                .of<ThemeModel>(context)
                                                .currentTheme
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3),
                                            child: Text(
                                              '1005 hPa',
                                              style: Provider
                                                  .of<ThemeModel>(context)
                                                  .currentTheme
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}