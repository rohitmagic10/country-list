// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CountryStore on _CountryStore, Store {
  final _$countryDatasourceAtom = Atom(name: '_CountryStore.countryDatasource');

  @override
  ObservableList<dynamic>? get countryDatasource {
    _$countryDatasourceAtom.reportRead();
    return super.countryDatasource;
  }

  @override
  set countryDatasource(ObservableList<dynamic>? value) {
    _$countryDatasourceAtom.reportWrite(value, super.countryDatasource, () {
      super.countryDatasource = value;
    });
  }

  final _$userCountryAtom = Atom(name: '_CountryStore.userCountry');

  @override
  Country? get userCountry {
    _$userCountryAtom.reportRead();
    return super.userCountry;
  }

  @override
  set userCountry(Country? value) {
    _$userCountryAtom.reportWrite(value, super.userCountry, () {
      super.userCountry = value;
    });
  }

  final _$isReadyAtom = Atom(name: '_CountryStore.isReady');

  @override
  bool get isReady {
    _$isReadyAtom.reportRead();
    return super.isReady;
  }

  @override
  set isReady(bool value) {
    _$isReadyAtom.reportWrite(value, super.isReady, () {
      super.isReady = value;
    });
  }

  final _$_CountryStoreActionController =
      ActionController(name: '_CountryStore');

  @override
  void searchCountry({required String text}) {
    final _$actionInfo = _$_CountryStoreActionController.startAction(
        name: '_CountryStore.searchCountry');
    try {
      return super.searchCountry(text: text);
    } finally {
      _$_CountryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
countryDatasource: ${countryDatasource},
userCountry: ${userCountry},
isReady: ${isReady}
    ''';
  }
}
