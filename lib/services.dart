import 'dart:convert';
import 'package:http/http.dart' as http;

import 'countrycases.dart';

class Services {
  static List<Countries> ser = [];
  static Future<List<Countries>> getCountries() async {
    try {
      final response = await http.get('https://api.covid19api.com/summary');
      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        List<Countries> list = [];

        for (int i = 0; i < 186; i++) {
          Countries movie = Countries(
              responseJson['Countries'][i]['Country'],
              responseJson['Countries'][i]['TotalConfirmed'],
              responseJson['Countries'][i]['TotalDeaths'],
              responseJson['Countries'][i]['NewDeaths'],
              responseJson['Countries'][i]['NewConfirmed'],
              responseJson['Countries'][i]['TotalRecovered'],
              responseJson['Countries'][i]['NewRecovered'],
              responseJson['Countries'][i]['Slug']);
          ser.add(movie);
          list.add(movie);
        }

        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw new Exception(e.toString());
    }
  }
}
