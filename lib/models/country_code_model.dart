class CountryCodeModel {
  final String alphaCountryCode;

  CountryCodeModel({required this.alphaCountryCode});

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) {
    return CountryCodeModel(alphaCountryCode: '');
  }
}
