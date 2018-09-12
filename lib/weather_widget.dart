import 'package:flutter/material.dart';
import 'package:weather/daily_forecast.dart';

class WeatherWidget extends SliverList {
  final bool loading;
  final int days;
  final List<String> weekdaysData;
  final List<DailyForecast> weatherForecast;

  WeatherWidget(
      {Key key,
      this.loading,
      this.days,
      this.weekdaysData,
      this.weatherForecast})
      : super(key: key, delegate: SliverChildBuilderDelegate((context, index) {
      return _buildDailyWeatherRow(
          weekdaysData[index],
          weatherForecast[index].temperature,
          weatherForecast[index].getWeatherIcon(),
          index,
        );
      }, childCount: days));

  static _buildDailyWeatherRow(String day, int temp, IconData icon, int index) {
    var color = (index == 0) ? Colors.black : Colors.grey.withOpacity(0.8);
    return new Padding(
      padding: const EdgeInsets.only(bottom: 40.0, left: 48.0, right: 48.0),
      child: new Row(
        children: <Widget>[
          new Expanded(child: _buildWeatherLabel(day, color)),
          _buildWeatherLabel('$tempº', color),
          _buildWeatherIcon(icon, color),
        ],
      ),
    );
  }

  static _buildWeatherLabel(String string, Color color) {
    return new Text(
      string,
      style: new TextStyle(
        color: color,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
      ),
    );
  }

  static _buildWeatherIcon(IconData icon, Color color) {
    return new Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 20.0),
      child: new Icon(icon, color: color),
    );
  }
}