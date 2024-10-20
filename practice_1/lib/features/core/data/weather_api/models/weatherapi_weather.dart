class WeatherAPIWeather {
  final double temp;
  final String type;

  const WeatherAPIWeather(this.temp, this.type);

  @override
  String toString() {
    return 'WeatherAPIWeather{temp: $temp), type: $type}';
  }
}