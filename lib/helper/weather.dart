import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;







const String openWeatherURL = 'api.openweathermap.org';
const String weatherURL = '/data/2.5/weather';
const String weatherApi = "bd8dd00eb85ff2a5dfcbea722ae466b6";

class weather {
  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future getWeatherByLocation() async {
    Weather weather;
    Position position = await getLocation();

    final queryParameters = {
      'lat': position.latitude.toString(),
      'lon': position.longitude.toString(),
      'units': 'metric',
      'appid': weatherApi,
    };

    final uri = Uri.https(openWeatherURL, weatherURL, queryParameters);

    final response = await http.get(uri);

    final json = jsonDecode(response.body);
    weather = Weather(
      location: json["name"],
      temperature: (json["main"]["temp"]).toInt(),
    );
    return weather;
  }
}

class Weather {
  final String location;
  final int temperature;
  Weather({
    required this.location,
    required this.temperature,
  });
}
