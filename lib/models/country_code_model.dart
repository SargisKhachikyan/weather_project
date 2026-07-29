class CountryCodeModel {
  final String alphaCountryCode;

  CountryCodeModel({required this.alphaCountryCode});

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) {
    final objects = json['data']?['objects'];

    if (objects is! List || objects.isEmpty) {
      throw const FormatException('Objects list is empty');
    }
    final code = objects.first['codes']?['alpha_2']?.toString();

    if (code == null || code.isEmpty) {
      throw const FormatException('Country code is missing');
    }

    return CountryCodeModel(alphaCountryCode: code);
  }
}
