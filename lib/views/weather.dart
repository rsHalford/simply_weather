import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';

class CurrentWeather extends StatefulWidget {
  @override
  _CurrentWeather createState() => _CurrentWeather();
}

class _CurrentWeather extends State<CurrentWeather> {
  String key = '65452a095dde4cffe2cd646e23267775';
  WeatherFactory wf;
  List<Weather> _data = [];
  String _sunriseTime = '';
  String _sunsetTime = '';
  String _weekdayWord;
  String _monthWord;
  int _minute = DateTime.now().minute;
  int _hour = DateTime.now().hour;
  int _day = DateTime.now().weekday;
  int _month = DateTime.now().month;

  var _weekdayValue = {
    1: 'Mon',
    2: 'Tue',
    3: 'Wed',
    4: 'Thu',
    5: 'Fri',
    6: 'Sat',
    7: 'Sun',
  };

  var _monthValue = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  @override
  void initState() {
    _getLocation();
    _weekdayWord = _weekdayValue[_day];
    _monthWord = _monthValue[_month];
    super.initState();
    wf = WeatherFactory(key);
  }

  _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    print('Current location lat lon ' +
        position.latitude.toString() +
        " - " +
        position.longitude.toString());

    Weather weather = await wf.currentWeatherByLocation(
        position.latitude, position.longitude);
    setState(() {
      _data = [weather];
    });

    print(_data.toString());

    var sunrise = _data[0].sunrise.toString();
    var sunriseParse = DateTime.parse(sunrise);
    var sunriseFormatted = '${sunriseParse.hour}:${sunriseParse.minute}';
    setState(() {
      _sunriseTime = sunriseFormatted.toString();
    });

    var sunset = _data[0].sunset.toString();
    var sunsetParse = DateTime.parse(sunset);
    var sunsetFormatted = '${sunsetParse.hour}:${sunsetParse.minute}';
    setState(() {
      _sunsetTime = sunsetFormatted.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 10),
                      child: RichText(
                        text: TextSpan(
                          text: _data[index].areaName,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                          child: RichText(
                            text: TextSpan(
                              children: <InlineSpan>[
                                TextSpan(
                                  text: _data[index]
                                      .tempMax
                                      .celsius
                                      .round()
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: '°',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: 'C',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.import_export,
                                    size: 24,
                                  ),
                                ),
                                TextSpan(
                                  text: _data[index]
                                      .tempMin
                                      .celsius
                                      .round()
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: '°',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: 'C',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            '|',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Feels like ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                                TextSpan(
                                  text: _data[index]
                                      .tempFeelsLike
                                      .celsius
                                      .round()
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: '°',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: 'C',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: _data[index]
                                  .temperature
                                  .celsius
                                  .round()
                                  .toString(),
                              style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '°',
                              style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'C',
                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: RichText(
                            text: TextSpan(
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Icon(
                                    Icons.brightness_7,
                                    color: Colors.yellow,
                                    size: 30,
                                  ),
                                ),
                                WidgetSpan(
                                  child: SizedBox(width: 40),
                                ),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.brightness_3,
                                    color: Colors.blueGrey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '0' + _sunriseTime + '  ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                                TextSpan(
                                  text: '  ' + _sunsetTime,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      ' ',
                    ),
                    Text(
                      'Cloudiness: ' + _data[index].cloudiness.toString(),
                    ),
                    Text(
                      'Hash Code: ' + _data[index].hashCode.toString(),
                    ),
                    Text(
                      'Humidity: ' + _data[index].humidity.toString(),
                    ),
                    Text(
                      'Lat & Lon: ' +
                          _data[index].latitude.toString() +
                          ' - ' +
                          _data[index].longitude.toString(),
                    ),
                    Text(
                      'Pressure: ' + _data[index].pressure.toString(),
                    ),
                    Text(
                      'Snow Last Hour: ' + _data[index].snowLastHour.toString(),
                    ),
                    Text(
                      'Snow Last 3 Hours: ' +
                          _data[index].snowLast3Hours.toString(),
                    ),
                  ],
                );
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 10),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Last update: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54,
                      ),
                    ),
                    TextSpan(
                      text: '$_hour:$_minute ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: ' $_weekdayWord, $_monthWord',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
