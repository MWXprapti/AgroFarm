import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app/weather_Page/api/weather_api.dart';
import 'package:new_app/weather_Page/models/weather_forecast_daily.dart';
import 'package:new_app/weather_Page/search_page.dart';
import 'package:new_app/weather_Page/widgets/bottomListView.dart';
import 'package:new_app/weather_Page/widgets/current_dart.dart';

class WeatherHome extends StatefulWidget {
  final WeatherForecast? locationWeather;

  const WeatherHome({Key? key, required this.locationWeather}) : super(key: key);

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  Future<WeatherForecast>? weatherObj;
  String? _cityName;

  @override
  void initState() {
    super.initState();
    weatherObj = widget.locationWeather != null
        ? Future.value(widget.locationWeather!)
        : WeatherApi().fetchWeatherForecast();
  }

  /// Fetches the latest weather data
  Future<void> _refreshWeather() async {
    setState(() {
      weatherObj = WeatherApi().fetchWeatherForecast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xff030317),
      backgroundColor: Colors.grey[250],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff4bc0ef),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: _refreshWeather,
              child: const Icon(
                CupertinoIcons.location_solid,
                color: Colors.white,
                size: 30,
              ),
            ),
            // Row(
            //   children: const [
            //     Icon(CupertinoIcons.map_fill, color: Colors.white),
            //     // SizedBox(width: 5),
            //     // Text(
            //     //   'openweathermap.org',
            //     //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            //     // )
            //   ],
            // ),
            GestureDetector(
              child: const Icon(
                Icons.search_outlined,
                color: Colors.white,
                size: 30,
              ),
              onTap: () async {
                var tappedName = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
                if (tappedName != null) {
                  setState(() {
                    _cityName = tappedName;
                    weatherObj = WeatherApi().fetchWeatherForecast(
                      cityName: _cityName!,
                      isCity: true,
                    );
                  });
                }
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder<WeatherForecast>(
            future: weatherObj,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || !snapshot.hasData) {
                return const Center(
                  child: Text(
                    'City not found\n Please enter a correct city name',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return Column(
                  children: [
                    CurrentWeather(snapshot: snapshot),
                    ButtomListView(snapshot: snapshot),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
