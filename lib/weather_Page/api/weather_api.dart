import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:new_app/weather_Page/models/weather_forecast_daily.dart';
import 'package:new_app/weather_Page/utilities/constants.dart';
import 'package:new_app/weather_Page/utilities/location.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast(
      {String? cityName, bool? isCity}) async {
    LocationService location = LocationService();
    await location.getCurrentLocation();

    if (location.latitude == null || location.longitude == null) {
      throw Future.error("Location not available. Check permissions.");
    }

    Map<String, String?> parameters;

    if (isCity == true && cityName != null && cityName.isNotEmpty) {
      parameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': cityName,
      };
    } else {
      parameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
      };
    }

    var uri = Uri.https(
      Constants.WEATHER_BASE_URL_DOMAIN,
      Constants.WEATHER_FORECAST_PATH,
      parameters,
    );

    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      throw Future.error('Error response: ${response.body}');
    }
  }
}
