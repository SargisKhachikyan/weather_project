class CountryFlagApi {
  String getFlagUrl(String countryCode) {
    return 'https://flagsapi.com/${countryCode.toUpperCase()}/flat/64.png';
  }
}
