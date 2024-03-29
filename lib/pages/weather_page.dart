import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_flutter_app/services/weather_service.dart';
import 'package:weather_flutter_app/models/weather_model.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key
  final _weatherService= WeatherService('ceca6323fe58e8bbdb074e00f1894b49');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async{

    String cityName = await _weatherService.getCurrentCity();

  // weather for a city

  try{
    final weather = await _weatherService.getWeather(cityName);
    setState(() {
      _weather=weather;
    });
  }
  catch(e){
    print(e);
  }
}

//weather animation
String getWeatherAnimation(String?mainCondition){
  if(mainCondition==null) return 'assets/sunny.json';

  switch(mainCondition.toLowerCase()){
    case 'clouds':
      return 'assets/clouds.json';
    case 'drizzle':
      return 'assets/rainy.json';
    case 'rain':
      return 'assets/rainy.json';
    case 'thunderstorm':
      return 'assets/thunder.json';
    case 'clear':
      return 'assets/sunny.json';
    default:
      return 'assets/sunny.json';
  }
}

//init state
@override
void initState(){
  super.initState();
//fetch weather on start page
  _fetchWeather();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //city name
          Text(_weather?.cityName??"loading city..."),

          //animation
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          //temperature
          Text('${_weather?.temperature.round()}°C'),

          //weather condition
          Text(_weather?.mainCondition ??"")
        ],  
      ),
      ),
    );
  }
}