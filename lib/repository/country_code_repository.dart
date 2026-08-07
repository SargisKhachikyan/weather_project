import 'package:weather_project/models/country_code_model.dart';
import 'package:weather_project/service/country_code_api/country_code_api.dart';

class CountryCodeRepository {
  final CountryCodeApi countryCodeApi;

  CountryCodeRepository({required this.countryCodeApi});

  Future<CountryCodeModel> getCode(String country) async {
    return await countryCodeApi.getCode(country);
  }
}
