class CityNameIsCorrect {
    final String? cityName;
    CityNameIsCorrect({required this.cityName});

    factory CityNameIsCorrect.fromJson(Map<String, dynamic> json) {
        final cityName = json['query'];
        return CityNameIsCorrect(cityName: cityName);
    }
}