import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';

class CurrentWeather extends StatefulWidget {
  @override
  _CurrentWeather createState() => _CurrentWeather();
}

class _CurrentWeather extends State<CurrentWeather> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  String key = '65452a095dde4cffe2cd646e23267775';
  WeatherFactory wf;
  List<Weather> _data = [];
  DateTime _dateTimeNow = DateTime.now();
  String _timeFormatted;
  String _dayFormatted;
  String _monthFormatted;


  @override
  void initState() {
    _getLocation();
    _dateTimeNow = DateTime.now();
    _timeFormatted = DateFormat.Hm().format(_dateTimeNow);
    _dayFormatted = DateFormat.d().format(_dateTimeNow);
    _monthFormatted = DateFormat.MMM().format(_dateTimeNow);
    _scaffoldKey = GlobalKey();
    super.initState();
    wf = WeatherFactory(key);
  }
  
  @override
  void dispose() {
    _scaffoldKey?.currentState?.dispose();
    super.dispose();
  }

  _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print('Current location lat lon ' +
        position.latitude.toString() +
        " | " +
        position.longitude.toString());

    Weather weather = await wf.currentWeatherByLocation(
        position.latitude, position.longitude);
    setState(() {
      _data = [weather];
    });

    print(_data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        key: _scaffoldKey,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/simply_weather_raining.png"
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
              () {
                setState(() {
                  _getLocation();
                  _dateTimeNow = DateTime.now();
                  _timeFormatted = DateFormat.Hm().format(_dateTimeNow);
                  _dayFormatted = DateFormat.d().format(_dateTimeNow);
                  _monthFormatted = DateFormat.MMM().format(_dateTimeNow);
                });

                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: const Text("Page Refreshed"),
                  ),
                );
              },
            );
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height - 250),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 15, 160, 10),
                    child: RichText(
                      text: TextSpan(
                        text: "Oooh, it's brisk",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 5, 10, 20),
                    child: RichText(
                      text: TextSpan(
                        text: _data[index].areaName + "  |  Feels like " + _data[index].tempFeelsLike.celsius.round().toString() + "°C",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget> [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 0, 15),
                        child: RichText(
                          text: TextSpan(
                            text: _data[index].latitude.toString() +
                                  '°  |  ' +
                                  _data[index].longitude.toString() + "°",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 15, 15),
                        decoration: BoxDecoration(
                          border: Border.all (
                            color: Colors.white54,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        padding: EdgeInsets.all(3),
                        child: RichText(
                          text: TextSpan(
                            text: '$_timeFormatted, $_dayFormatted/$_monthFormatted',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
