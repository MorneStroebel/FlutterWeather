import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/core/models/themeModel.dart';
import 'package:flutter_weather/core/models/current_weather_model.dart';
import 'package:flutter_weather/core/navigation/routes.dart';
import 'package:flutter_weather/core/services/firebase_services.dart';
import 'package:flutter_weather/core/services/locationService.dart';
import 'package:flutter_weather/src/bloc/current_weather_bloc.dart';
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

  final FirebaseServices _firebaseServices = FirebaseServices();
  final LocationService _locationService = LocationService();

  late StreamSubscription<User> loginStateSubscription;
  late CurrentWeatherBlock _weatherBlock;
  late Future<LocationData?> futureLocation;

  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    _weatherBlock = CurrentWeatherBlock();
    futureLocation = _locationService.getLocation().then((value) async {
      if (value == null) Navigator.of(context).pushReplacementNamed(
          Routes.noLocation);
      currentLocation = value;
      _weatherBlock.lat = currentLocation?.latitude;
      _weatherBlock.lon = currentLocation?.longitude;
      await _weatherBlock.getData();
      return currentLocation;
    });
  }

  @override
  void dispose() {
    _weatherBlock.dispose();
    super.dispose();
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
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Center(
                child: SizedBox(
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: StreamBuilder(
                        stream: _weatherBlock.streamWeatherData,
                        builder: (BuildContext context,
                            AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            CurrentWeatherModel weatherModel = snapshot.data;
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 10, right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                              '${weatherModel
                                                  .cityName}, ${weatherModel
                                                  .country}',
                                              style: Provider
                                                  .of<ThemeModel>(context)
                                                  .currentTheme
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(fontSize: 28)
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3),
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
                                        icon: const Icon(
                                            Icons.add_location_alt_rounded),
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
                                          child: Lottie.asset(
                                              'assets/anim/clear.json')
                                      ),
                                      SizedBox(
                                        width: screenWidth,
                                        height: screenHeight * 0.4,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 80),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: [
                                              Text(
                                                "${weatherModel.temp
                                                    .round()} °C",
                                                style: Provider
                                                    .of<ThemeModel>(context)
                                                    .currentTheme
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(fontSize: 50,
                                                    fontWeight: FontWeight
                                                        .w900),
                                              ),
                                              // Text(
                                              //   'weather type',
                                              //   style: Provider
                                              //       .of<ThemeModel>(context)
                                              //       .currentTheme
                                              //       .textTheme
                                              //       .bodyMedium
                                              //       ?.copyWith(fontSize: 18),
                                              // )
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
                                        borderRadius: const BorderRadius.all(
                                            Radius
                                                .circular(25))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
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
                                                          .of<ThemeModel>(
                                                          context)
                                                          .currentTheme
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          top: 3),
                                                      child: Text(
                                                        '${(weatherModel.wind *
                                                            3.6).round()} km/h',
                                                        style: Provider
                                                            .of<ThemeModel>(
                                                            context)
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
                                                      'Humidity',
                                                      style: Provider
                                                          .of<ThemeModel>(
                                                          context)
                                                          .currentTheme
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          top: 3),
                                                      child: Text(
                                                        '${weatherModel
                                                            .humidity} %',
                                                        style: Provider
                                                            .of<ThemeModel>(
                                                            context)
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
                                                          .of<ThemeModel>(
                                                          context)
                                                          .currentTheme
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(top: 3),
                                                      child: Text(
                                                        '${weatherModel
                                                            .pressure} hPa',
                                                        style: Provider
                                                            .of<ThemeModel>(
                                                            context)
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
                                ),
                                MaterialButton(
                                    onPressed: () {
                                      _firebaseServices.signOut();
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                          Routes.loginScreen);
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
                                        "sign out",
                                        textAlign: TextAlign.center,
                                        style: Provider
                                            .of<ThemeModel>(context)
                                            .currentTheme
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(fontSize: 26),
                                      ),
                                    )
                                )
                              ],
                            );
                          } else {
                            return Column(
                                children: [
                                  Lottie.asset(
                                      'assets/anim/loading_indicator.json')
                                ]
                            );
                          }
                        }
                    ),
                  ),
                ),
              ),
            )
        )
    );
  }
}