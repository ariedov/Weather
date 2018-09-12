import 'package:flutter/material.dart';
import 'package:weather/background_widget.dart';

class HeaderWidget extends StatelessWidget {
  final double headerHeight;
  final bool loading;
  final String currentLocation;
  final int currentTemperature;

  const HeaderWidget(
      this.headerHeight, {Key key, this.loading, this.currentLocation, this.currentTemperature})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackgroundWidget(headerHeight),
        loading
            ? SizedBox()
            : Center(
                child: Column(
                  children: <Widget>[
                    _buildLocationLabel(),
                    _buildTemperatureLabel(),
                  ],
                ),
              ),
      ],
    );
  }

  _buildLocationLabel() {
    return new Padding(
      padding: const EdgeInsets.only(top: 116.0, bottom: 8.0),
      child: new Text(
        currentLocation,
        style: new TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 24.0,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  _buildTemperatureLabel() {
    return new Text(
      '$currentTemperature',
      style: new TextStyle(
        color: Colors.white,
        fontSize: 112.0,
        decoration: TextDecoration.none,
      ),
    );
  }
}
