import 'package:flutter/material.dart';
import 'package:weather/daily_forecast.dart';
import 'package:weather/header_widget.dart';
import 'package:weather/openweather_api.dart';
import 'package:weather/utils.dart';
import 'package:weather/weather_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const double headerHeight = 345.0;

  bool _loading = true;
  int _days = 14;
  List<DailyForecast> _weatherForecast;
  List<String> _weekdaysData;
  String _currentLocation;
  int _currentTemperature;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var openWeatherAPI = new OpenWeatherAPI();
    var weekdaysData = getWeekdaysList(_days);
    var currentCoord = await getCoordinates();
    var lat = currentCoord[0];
    var lon = currentCoord[1];
    var currentLocation = await getLocation(lat, lon);
    var currentTemperature =
        await openWeatherAPI.getCurrentTemperature(lat, lon);
    var weatherForecast =
        await openWeatherAPI.getWeatherForecast(lat, lon, _days);
    setState(() {
      _weekdaysData = weekdaysData;
      _currentLocation = currentLocation;
      _currentTemperature = currentTemperature;
      _weatherForecast = weatherForecast;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: headerHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: HeaderWidget(
                headerHeight,
                loading: _loading,
                currentLocation: _currentLocation,
                currentTemperature: _currentTemperature,
              ),
            ),
          ),
          WeatherWidget(
            loading: _loading,
            days: _days,
            weekdaysData: _weekdaysData,
            weatherForecast: _weatherForecast,
          ),
        ],
      ),
    );
  }
}
