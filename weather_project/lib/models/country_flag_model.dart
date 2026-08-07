class CountryFlagModel {
  final String flagUrl;

  const CountryFlagModel({
    required this.flagUrl,
  });

  factory CountryFlagModel.fromCountryCode(String countryCode) {
    return CountryFlagModel(
      flagUrl: 'https://flagsapi.com/flat/64.png',
    );
  }
}
