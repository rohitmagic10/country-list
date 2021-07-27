import 'package:country_picker/module/page/country_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', "US"),
        const Locale('es', "ES"),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: I18n(child: CountryListPage(didSelectCountry: (country) {})),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
          onPressed: () {
            showDialog(context);
          },
          child: Text('Show Dialog')),
    );
  }

  void showDialog(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      closeProgressThreshold: 0.4,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CountryListPage(
        didSelectCountry: (country) {
          print('Selected country: ${country.name}');
        },
      ),
    );
  }
}
