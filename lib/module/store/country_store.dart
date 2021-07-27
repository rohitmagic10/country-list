import 'dart:convert';

import 'package:country_picker/module/model/country/country.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

part 'country_store.g.dart';

class CountryStore = _CountryStore with _$CountryStore;

abstract class _CountryStore with Store {
  // List of  countries
  List<Country>? countries;

  @observable
  ObservableList? countryDatasource;

  @observable
  Country? userCountry;

  @observable
  var isReady = false;

  _CountryStore() {
    _intializeCoutryList();
  }

  _intializeCoutryList() async {
    final jsonText = await rootBundle.loadString('assets/file/country.json');
    final countryInfo = jsonDecode(jsonText) as List<dynamic>;

    this.countries = countryInfo
        .map((e) => Country(e['code'], e['name'], e['dial_code'],
            e['currency_multiplier'] ?? 1))
        .toList();

    Locale? locale = await Devicelocale.currentAsLocale;
    final currentCountryCode = locale?.countryCode ?? 'US';
    this.userCountry = countries!
        .firstWhere((element) => element.isoCode == currentCountryCode);
    countries!.remove(this.userCountry);
    this.countryDatasource = ObservableList.of(countries!);
    this.isReady = true;
  }

  @action
  void searchCountry({required String text}) {
    if (text.isEmpty) {
      this.countryDatasource = ObservableList.of(countries!);
    } else {
      print('Search text $text');
      final searchResult = countries!.where((element) =>
          element.name.toLowerCase().startsWith(text.toLowerCase()));
      this.countryDatasource = ObservableList.of(searchResult);
    }
  }
}
