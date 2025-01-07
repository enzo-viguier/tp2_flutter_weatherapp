import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/service/weather_service.dart';
import 'dart:convert';

// Génère un mock pour le client HTTP
@GenerateMocks([http.Client])
import 'weather_service_test.mocks.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Charge explicitement le fichier .env avant les tests
  await dotenv.load(fileName: "/home/enzo/Documents/M2/IoT/weatherapp/.env");

  group('WeatherService Tests', () {
    late MockClient mockClient;
    late WeatherService weatherService;

    setUp(() {
      mockClient = MockClient();
      weatherService = WeatherService(mockClient);
    });

    test('Fetch weather for a valid city', () async {
      final fakeResponse = jsonEncode({
        "name": "Paris",
        "main": {"temp": 15.5},
      });

      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(fakeResponse, 200),
      );

      final weather = await weatherService.fetchWeather('Paris');

      expect(weather.name, 'Paris');
      expect(weather.main?.temp, 15.5);
    });

    test('Fetch weather for an invalid city', () async {
      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('{"message": "city not found"}', 404),
      );

      expect(() async => await weatherService.fetchWeather('InvalidCity'),
          throwsException);
    });
  });
}
