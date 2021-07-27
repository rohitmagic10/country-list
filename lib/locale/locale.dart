import 'package:i18n_extension/i18n_extension.dart';

const appTitle = "appTitle";
const country = "country";
const yourCountry = "yourCountry";
const otherCountries = "otherCountries";
const search = 'search';

extension Localization on String {
  static final _t = Translations.from("en_us", {
    appTitle: {
      "en_us": "Closit",
      "es_es": "Closit",
    },
    country: {
      "en_us": "Country",
      "es_es": "País",
    },
    yourCountry: {
      "en_us": "YOUR COUNTRY",
      "es_es": "TU PAÍS",
    },
    otherCountries: {
      "en_us": "OTHER COUNTRIES",
      "es_es": "OTROS PAISES",
    },
    search: {
      "en_us": "Search",
      "es_es": "Búsqueda",
    },
  });

  String get i18n => localize(this, _t);
}
