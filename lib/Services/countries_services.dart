// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:covid_tracker/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class CountriesServices {
  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrls.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error Occured!");
    }
  }
}
