class WeatherModel {
  final String type;
  final String query;
  final String language;
  final String unit;
  final String name;
  final String country;
  final String region;
  final String timezoneId;
  final int temperature;
  final int feelsLike;
  final int windSpeed;

  WeatherModel(
      {required this.type,
      required this.query,
      required this.language,
      required this.unit,
      required this.name,
      required this.country,
      required this.region,
      required this.timezoneId,
      required this.temperature,
      required this.feelsLike,
      required this.windSpeed});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      type: json['request']['type'],
      query: json['request']['query'],
      language: json['request']['language'],
      unit: json['request']['unit'],
      name: json['location']['name'],
      country: json['location']['country'],
      region: json['location']['region'],
      timezoneId: json['location']['timezone_id'],
      temperature: json['current']['temperature'],
      feelsLike: json['current']['feelslike'],
      windSpeed: json['current']['wind_speed'],
    );
  }
}
