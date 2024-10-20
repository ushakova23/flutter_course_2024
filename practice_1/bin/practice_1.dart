import 'package:practice_1/features/core/data/debug/weather_repository_debug.dart';
import 'package:practice_1/features/core/data/weather_api/repository_weatherapi.dart';
import 'package:practice_1/features/core/data/weather_api/weather_api.dart';
import 'package:practice_1/features/core/presentation/app.dart';

const String version = '0.0.1';
const String url_osm = 'https://api.openweathermap.org';
const String url_weatherapi = 'http://api.weatherapi.com/v1';
const String apiKey = 'key';


void main(List<String> arguments) {
  var app = App(WeatherRepositoryWeatherAPI(WeatherAPI(url_weatherapi, apiKey)));

  app.run();
}
