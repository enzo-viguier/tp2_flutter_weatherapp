import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  WeatherCard({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 8.0,
      color: Colors.blueAccent.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Nom de la ville
            Text(
              weather.name ?? '',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            // Température principale
            Text(
              '${weather.main?.temp?.toStringAsFixed(1)}°C',
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            // Icône météo
            Icon(
              _getWeatherIcon(weather.weather?[0].main),
              size: 64.0,
              color: Colors.white,
            ),
            SizedBox(height: 8.0),
            // Description de la météo
            Text(
              weather.weather?[0].description ?? '',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            Divider(color: Colors.white),
            // Détails supplémentaires (humidité, etc.)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDetail(
                  icon: FontAwesomeIcons.tint,
                  label: 'Humidity',
                  value: '${weather.main?.humidity}%',
                ),
                _buildDetail(
                  icon: FontAwesomeIcons.wind,
                  label: 'Wind',
                  value: '${weather.wind?.speed?.toStringAsFixed(1)} m/s',
                ),
                _buildDetail(
                  icon: FontAwesomeIcons.thermometerThreeQuarters,
                  label: 'Pressure',
                  value: '${weather.main?.pressure} hPa',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        FaIcon(icon, color: Colors.white, size: 24.0),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
        SizedBox(height: 2.0),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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
