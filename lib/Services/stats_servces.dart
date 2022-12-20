import 'dart:convert';
import 'package:covid_tracker/Models/world_stats_model.dart';
import 'package:covid_tracker/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<WorldStatsModel> fetchWorldStatsRecords() async {
    final response = await http.get(Uri.parse(AppUrls.worldStatsApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception("Error Occured!");
    }
  }
}
