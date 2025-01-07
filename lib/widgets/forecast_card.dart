import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/weather_model.dart';


class ForecastCard extends StatelessWidget {
  final DailyForecast forecast;

  ForecastCard({required this.forecast});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(forecast.dt! * 1000);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.blueAccent.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${date.day}/${date.month}',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Icon(
              _getWeatherIcon(forecast.weather?.main),
              size: 32.0,
              color: Colors.white,
            ),
            SizedBox(height: 8.0),
            Text(
              '${forecast.temp?.day?.toStringAsFixed(1)}°C',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWeatherIcon(String? condition) {
    switch (condition?.toLowerCase()) {
      case 'clear':
        return FontAwesomeIcons.sun;
      case 'clouds':
        return FontAwesomeIcons.cloud;
      case 'rain':
        return FontAwesomeIcons.cloudRain;
      case 'snow':
        return FontAwesomeIcons.snowflake;
      case 'thunderstorm':
        return FontAwesomeIcons.bolt;
      default:
        return FontAwesomeIcons.cloud;
    }
  }
}
