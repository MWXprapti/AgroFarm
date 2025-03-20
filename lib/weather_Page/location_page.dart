import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_app/weather_Page/api/weather_api.dart';
import 'package:new_app/weather_Page/weather_home.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String errorMessage = "";

  void getLocationData() async {
    try {
      var weatherInfo = await WeatherApi().fetchWeatherForecast();
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WeatherHome(locationWeather: weatherInfo);
      }));
    } catch (e) {
      log('Something went wrong: $e');
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030317),
      body: Center(
        child: errorMessage.isEmpty
            ? const SpinKitDoubleBounce(color: Color(0xff4bc0ef), size: 100.0)
            : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
