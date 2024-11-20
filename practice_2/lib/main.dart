import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        scaffoldBackgroundColor: Colors.pink.shade50,
      ),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _cityController = TextEditingController();
  String _cityName = "Введите город";
  String _weatherDescription = "Погода будет здесь!";
  String _details = "";
  bool _isLoading = false;

  final String _apiKey = "";
  final String _apiUrl = "https://api.openweathermap.org/data/2.5/weather";

  void _fetchWeather(String cityName) async {
    setState(() {
      _isLoading = true;
      _details = "";
    });

    try {
      final url = Uri.parse("$_apiUrl?q=$cityName&appid=$_apiKey&units=metric&lang=ru");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['cod'] == 200) {
          setState(() {
            _cityName = data['name'];
            _weatherDescription = "${data['weather'][0]['description']}, ${data['main']['temp']}°C";
            _details =
            "Влажность: ${data['main']['humidity']}%\n"
                "Ветер: ${data['wind']['speed']} м/с\n"
                "Температура: ${data['main']['temp_min']}°C - ${data['main']['temp_max']}°C";
          });
        }
      } else {
        setState(() {
          _weatherDescription = "Ошибка: ${response.reasonPhrase}";
        });
      }
    } catch (e) {
      setState(() {
        _weatherDescription = "Ошибка подключения!";
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
        title: Text("Погода", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Spacer(),
            Text(
              _cityName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.pink.shade700),
            ),
            SizedBox(height: 10),
            if (_isLoading)
              CircularProgressIndicator(color: Colors.pinkAccent)
            else
              Column(
                children: [
                  Text(
                    _weatherDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: Colors.pink.shade600),
                  ),
                  if (_details.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        _details,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.pink.shade800),
                      ),
                    ),
                ],
              ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: "Введите название города",
                  hintStyle: TextStyle(color: Colors.pink.shade300),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.pink),
                    onPressed: () {
                      if (_cityController.text.isNotEmpty) {
                        _fetchWeather(_cityController.text.trim());
                      }
                    },
                  ),
                ),
                style: TextStyle(color: Colors.pink.shade900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
