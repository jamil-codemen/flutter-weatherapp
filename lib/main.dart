import 'package:flutter/material.dart';
import 'widgets/main_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<WeatherInfo>fetchWeather() async{
  final zipCode ="60005";
  final apiKey="834e08bd896858b3921a1117ac7fecac";
  final requestUrl="http://api.openweathermap.org/data/2.5/weather?zip=${zipCode},us&appid=${apiKey}";

  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode==200){
    return WeatherInfo.fromJson(jsonDecode(response.body));
  }else{
    throw Exception("error laoding request URL info");
  }
}
class WeatherInfo {
    final String location;
    final double temp;
    final double tempMin;
    final double tempMax;
    final String weather;
    final int humidity;
    final double windspeed;
    WeatherInfo({
      required this.location,
      required this.temp,
      required this.tempMin,
      required this.tempMax,
      required this.weather,
      required this.humidity,
      required this.windspeed,

    });
  factory WeatherInfo.fromJson(Map<String, dynamic> json){
    return WeatherInfo(
      location: json['name'],
      temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      weather: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windspeed: json['wind']['speed'],
    );
  }  
  }
void main () => runApp(
  MaterialApp(
    title: "Weather App",
    home:MyApp()
  )
);

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget>createState(){
    return _MyApp();
  }
}

class _MyApp extends State <MyApp>{

late Future<WeatherInfo>futureWeather;

@override
void initState(){
  super.initState();
  futureWeather=fetchWeather();
}

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body:FutureBuilder<WeatherInfo>(
      future: futureWeather,
      builder:(context ,snapshot) {
        if(snapshot.hasData){
           return MainWidget(
             location: snapshot.data!.location,
             temp: snapshot.data!.temp,
             tempMin: snapshot.data!.tempMin,
             tempMax: snapshot.data!.tempMax,
             weather: snapshot.data!.weather,
             humidity: snapshot.data!.humidity,
             windSpeed: snapshot.data!.windspeed,
             );
          } else if (snapshot.hasError){
              return Center(
                child: Text("${snapshot.error}"),
            );
          }return CircularProgressIndicator();
      }
      )
    );
  }
}