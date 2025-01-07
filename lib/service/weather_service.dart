import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/weather_model.dart';

class WeatherService {
  final http.Client client;
  // final String _apiKey = dotenv.env['API_KEY'] ?? '';
  final String _apiKey = "b7923b87efb76bc797ea1d30fdf43d68";

  WeatherService([http.Client? client]) : client = client ?? http.Client();

  Future<WeatherModel> fetchWeather(String cityName) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$_apiKey&units=metric');

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception(
            'Failed to fetch weather data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  Future<List<DailyForecast>> fetchForecastByCoordinates(double lat, double lon) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$_apiKey&units=metric');

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> forecastList = data['list'];

        // Filtrer pour obtenir une prévision par jour (ex : à midi)
        List<DailyForecast> dailyForecasts = [];
        for (var i = 0; i < forecastList.length; i++) {
          final forecast = forecastList[i];
          final dateTime = DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
          if (dateTime.hour == 12) {
            dailyForecasts.add(DailyForecast.fromJson(forecast));
          }
        }

        return dailyForecasts;
      } else {
        throw Exception('Failed to fetch forecast data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }


}

