import 'package:flutter/material.dart';
import 'package:flutter_weather/models/themeModel.dart';
import 'package:flutter_weather/navigation/route_builder.dart';
import 'package:flutter_weather/widgets/dismissKeyboard.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModel>(
          create: (_) => ThemeModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        title: 'Flutter Weather',
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeModel>(context).currentTheme,
        onGenerateRoute: RouteBuilder.generateRoute,
      ),
    );
  }
}
