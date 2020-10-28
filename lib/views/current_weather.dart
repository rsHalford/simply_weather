//import 'package:flutter/material.dart';
//import 'package:weather/weather.dart';
//
//enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }
//
//class SimplyWeather extends StatefulWidget {
//  @override
//  _SimplyWeather createState() => _SimplyWeather();
//}
//
//class _SimplyWeather extends State<SimplyWeather> {
//  String key = '65452a095dde4cffe2cd646e23267775';
//  WeatherFactory wf;
//  List<Weather> _data = [];
//  AppState _state = AppState.NOT_DOWNLOADED;
//  String cityName = '';
//  //Weather w = await wf.currentWeatherByCityName(cityName);
//
//  @override
//  void initState() {
//    super.initState();
//    wf = WeatherFactory(key);
//  }
//
//  void queryForecast() async {
//    // Removes keyboard
//    FocusScope.of(context).requestFocus(FocusNode());
//    setState(() {
//      _state = AppState.DOWNLOADING;
//    });
//
//    List<Weather> forecasts = await wf.fiveDayForecastByCityName(cityName);
//    setState(() {
//      _data = forecasts;
//      _state = AppState.FINISHED_DOWNLOADING;
//    });
//  }
//
//  void queryWeather() async {
//    // Removes keyboard
//    FocusScope.of(context).requestFocus(FocusNode());
//    setState(() {
//      _state = AppState.DOWNLOADING;
//    });
//
//    Weather weather = await wf.currentWeatherByCityName(cityName);
//    setState(() {
//      _data = [weather];
//      _state = AppState.FINISHED_DOWNLOADING;
//    });
//  }
//
//  Widget contentNotDownloaded() {
//    return Container(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: [
//          Text(
//            'Press button to download the weather',
//            style: TextStyle(
//              fontSize: 20,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget contentDownloading() {
//    return Container(
//      margin: EdgeInsets.all(25),
//      child: Column(
//        children: [
//          Text(
//            'Fetching weather...',
//            style: TextStyle(
//              fontSize: 20,
//            ),
//          ),
//          Container(
//            margin: EdgeInsets.only(top: 50),
//            child: Center(
//              child: CircularProgressIndicator(
//                strokeWidth: 10,
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget contentFinishedDownload() {
//    return Center(
//      child: ListView.separated(
//        scrollDirection: Axis.vertical,
//        shrinkWrap: true,
//        itemCount: _data.length,
//        itemBuilder: (context, index) {
//          return ListTile(
//            title: Text(
//              _data[index].areaName + ', ' + _data[index].country,
//            ),
//            subtitle: Text(
//              _data[index].weatherMain,
//            ),
//          );
//        },
//        separatorBuilder: (context, index) {
//          return Divider();
//        },
//      ),
//    );
//  }
//
//  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
//      ? contentFinishedDownload()
//      : _state == AppState.DOWNLOADING
//          ? contentDownloading()
//          : contentNotDownloaded();
//
//  void _saveCityName(String input) {
//    cityName = input;
//    print(cityName);
//  }
//
//  Widget _cityNameInput() {
//    return Row(
//      children: <Widget>[
//        Container(
//          width: MediaQuery.of(context).size.width - 10,
//          margin: EdgeInsets.all(5),
//          child: TextField(
//            decoration: InputDecoration(
//              border: OutlineInputBorder(),
//              hintText: 'Enter city name',
//            ),
//            keyboardType: TextInputType.streetAddress,
//            onChanged: _saveCityName,
//            onSubmitted: _saveCityName,
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget _buttons() {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Container(
//          margin: EdgeInsets.all(5),
//          child: FlatButton(
//            child: Text(
//              'Fetch Weather',
//              style: TextStyle(
//                color: Colors.white,
//              ),
//            ),
//            onPressed: queryWeather,
//            color: Colors.blue,
//          ),
//        ),
//        Container(
//          margin: EdgeInsets.all(5),
//          child: FlatButton(
//            child: Text(
//              'Fetch Forecast',
//              style: TextStyle(
//                color: Colors.white,
//              ),
//            ),
//            onPressed: queryForecast,
//            color: Colors.blue,
//          ),
//        ),
//      ],
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        resizeToAvoidBottomInset: false,
//        backgroundColor: Colors.white,
//        body: Column(
//          children: <Widget>[
//            _cityNameInput(),
//            _buttons(),
//            Text(
//              'Output',
//              style: TextStyle(
//                fontSize: 20,
//              ),
//            ),
//            Divider(
//              height: 20,
//              thickness: 2,
//            ),
//            //Container(
//            //    height: 600,
//            //    child: _weatherResultView(),
//            //),
//            Expanded(
//              child: _resultView(),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
