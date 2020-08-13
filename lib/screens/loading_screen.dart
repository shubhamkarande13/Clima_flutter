import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clima/services/location.dart';


const apiKey = '3a7a9635239e20eb9689454823539451';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override

  double latitude;
  double longitude;

  void initState() {
    super.initState();
    getLocation();
    print('this line of code is triggered');
    getData();
  }

  void getLocation() async {
    Location location=Location();
    await location.getCurrentLocation();
    latitude=location.latitude;
    longitude=location.longitude;
    getData();

  }

  void getData() async{
    http.Response response = await
    http.get('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    if (response.statusCode==200){
      String data = response.body;
      //print(data);

      var decodeData = jsonDecode(data);

      var temperature = decodeData['main']['temp'];
      var condition = decodeData['weather'][0]['id'];
      var cityName = decodeData['name'];

      print (temperature);
      print (condition);
      print(cityName);

    } else{
      print(response.statusCode);
    }
  }


  Widget build(BuildContext context) {
    return Scaffold();
  }
}
