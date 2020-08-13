import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clima/services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override

  void initState() {
    super.initState();
    getLocation();
    print('this line of code is triggered');
    getData();
  }

  void getLocation() async {
    Location location=Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);

  }

  void getData() async{
    http.Response response = await
    http.get('https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02');
    if (response.statusCode==200){
      String data = response.body;
      print(data);

      var decodeData = jsonDecode(data);

      var temperature = decodeData['main']['temp'];
      var condition = decodeData['weather'][0]['id'];
      var cityName = decodeData['name'];


    } else{
      print(response.statusCode);
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getLocation();
            //Get the current location
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
