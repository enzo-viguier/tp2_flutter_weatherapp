import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/screens/weather_screen.dart';
import 'package:weatherapp/service/weather_service.dart';

void main() async {
  // Charge le fichier .env
  // await dotenv.load(fileName: "../.env");
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
