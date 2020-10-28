import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/weather.dart';

void main() {
  analytics = FirebaseAnalytics();
  runApp(MyApp());
}

FirebaseAnalytics analytics;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simply Weather',
      home: CurrentWeather(),
    );
  }
}
