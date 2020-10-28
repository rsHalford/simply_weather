import 'dart:async';

import 'package:weather/weather.dart';

String key = '65452a095dde4cffe2cd646e23267775';
String cityName = '';
double celcius = w.temperature.celsius;
double fahrenheit = w.temperature.fahrenheit;
double kelvin = w.temperature.kelvin;
WeatherFactory wf = WeatherFactory('key');
Weather w = await wf.currentWeatherByCityName(cityName);
