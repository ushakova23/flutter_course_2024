import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:./practice_1/features/core/data/weather_api/models/weatherapi_weather.dart';


class WeatherAPI {
  final String url;
  final String apiKey;

  WeatherAPI(this.url, this.apiKey);

  Future<WeatherAPIWeather> getWeather(String city) async {
    var response = await http.get(Uri.parse('$url/current.json?key=$apiKey&q=$city'));
    var rJson = jsonDecode(response.body);

    return WeatherAPIWeather(rJson['current']['temp_c'], rJson['current']['condition']['text']);
  }
}