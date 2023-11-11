import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wheather/model/weather.dart';
import 'package:wheather/service/weatherservice.dart';

class WeatherPge extends StatefulWidget {
  const WeatherPge({super.key});

  @override
  State<WeatherPge> createState() => _WeatherPgeState();
}

class _WeatherPgeState extends State<WeatherPge> {
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "asset/images/sunny_lottie.json";
    switch (mainCondition.toLowerCase()) {
      case 'Clouds':
      case 'Mist':
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Frog':
        return "asset/images/cloudy.json";
      case 'Rain':
      case 'Drizzle':
      case 'Shower rain':
        return "asset/images/rainy.json";
      case 'Thunderstorm':
        return "asset/images/thunder.json";
      case 'Clear':
        return "asset/images/sunny_lottie.json";
      default:
        return 'asset/images/sunny_lottie.json';
    }
  }

  @override
  void initState() {
    _fetchWeather();
    super.initState();
  }

  final _WeatherService = WeatherService('fea0a1b02176bd587ca28ea868c1cb0a');
  Weather? _weather;
//fetch weather
  _fetchWeather() async {
    String cityName = await _WeatherService.getcurrentCity();
    try {
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          Text(_weather?.cityName ?? "loading city"),
          Text(
              '${_weather?.temperature != null ? _weather!.temperature.round() : "loading temperature"}°C'),
        ]),
      ),
    );
  }
}
