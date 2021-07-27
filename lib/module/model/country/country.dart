// Represents individual country
class Country {
  final String isoCode;
  final String name;
  final String phoneCode;
  final num currencyMultiplier;

  const Country(
      this.isoCode, this.name, this.phoneCode, this.currencyMultiplier);
}
