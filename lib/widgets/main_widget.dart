
import 'package:flutter/material.dart';
import 'weather_tile.dart';

class MainWidget extends StatelessWidget{
  final String location;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int humidity;
  final double windSpeed;

  MainWidget({
    required this.location,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.humidity,
    required this.weather,
    required this.windSpeed
  });

  @override
  Widget build(BuildContext context){
    return Column(children: [
        Container(
          height: MediaQuery.of(context).size.height /2,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
              "${location.toString()}",
            style:TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w900),
              ),
              Padding(padding: EdgeInsets.only(top:10.0, bottom:10.0),
              child: Text(
                "${temp.toInt().toString()}",
                style:TextStyle(
                  color: Colors.purple,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w900
                )
              ),
              ),
              Text("high of ${tempMax.toInt().toString()}, low of ${tempMin.toInt().toString()}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w900
              ),
              )
          ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(children: [
              WeatherTile(icon: Icons.thermostat_auto_outlined, title: "${temp.toInt().toString()}", subtitle: "85"),
              WeatherTile(icon: Icons.filter_drama_outlined, title: "Weather", subtitle: "${weather.toString()}"),
              WeatherTile(icon: Icons.wb_sunny, title: "Humidity", subtitle: "${humidity.toString()}%"),
              WeatherTile(icon: Icons.waves_outlined, title: "Wind Speed", subtitle: "M${windSpeed.toInt().toString()}PH"),
            ],),
          ),
        )
      ],
      );
  }
}