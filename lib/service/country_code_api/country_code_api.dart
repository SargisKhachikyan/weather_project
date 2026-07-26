import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_project/models/country_code_model.dart';

class CountryCodeApi {
  static const String _baseUrl =
      'https://api.restcountries.com/countries/v5/codes.alpha_2/ca?pretty=1';
  static const String _apiKey = 'rc_live_afe0c8ad744f4b03a64dc85b3349e274';

  Future<CountryCodeModel> getCode(String country) async {
    final response = await http
        .get(Uri.parse('$_baseUrl?access_key=$_apiKey&query=$country'));

    return CountryCodeModel.fromJson(jsonDecode(response.body));
  }
}
