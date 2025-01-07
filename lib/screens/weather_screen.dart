import 'package:flutter/material.dart';
import '../service/weather_service.dart';
import '../models/weather_model.dart';
import '../widgets/forecast_card.dart';
import '../widgets/weather_card.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  WeatherModel? _weather;
  bool _isLoading = false;
  String? _errorMessage;
  List<DailyForecast>? _forecast;

  void _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final weatherService = WeatherService();
      final weather = await weatherService.fetchWeather(_cityController.text);

      // Récupérer les prévisions basées sur la latitude et la longitude
      final forecast = await weatherService.fetchForecastByCoordinates(
        weather.coord?.lat ?? 0,
        weather.coord?.lon ?? 0,
      );

      setState(() {
        _weather = weather;
        _forecast = forecast;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "La ville données n'a pas été trouvée";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text('Get Weather'),
            ),
            if (_isLoading)
              Center(child: CircularProgressIndicator()),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            if (_weather != null) ...[
              WeatherCard(weather: _weather!),
              SizedBox(height: 16.0),
              _forecast != null
                  ? SizedBox(
                height: 150.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _forecast!.length,
                  itemBuilder: (context, index) {
                    return ForecastCard(forecast: _forecast![index]);
                  },
                ),
              )
                  : Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}