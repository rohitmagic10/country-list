import 'package:country_picker/locale/locale.dart';
import 'package:country_picker/module/model/country/country.dart';
import 'package:country_picker/module/store/country_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// Receiver will get the callback when a country is selected
typedef SelectCountry = Function(Country country);

class CountryListPage extends StatefulWidget {
  CountryListPage({Key? key, required this.didSelectCountry}) : super(key: key);
  final SelectCountry didSelectCountry;

  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  late CountryStore _countryStore;

  @override
  void initState() {
    super.initState();
    _countryStore = CountryStore();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFF2F7FF),
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        anchor: 0.03,
        slivers: [
          _buildNavigationBar(context),
          _buildSearchBar(),
          Observer(builder: (context) {
            return _countryStore.isReady
                ? _buildCountryList()
                : SliverToBoxAdapter(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  );
          }),
        ],
      ),
    );
  }

  // List of countries
  SliverList _buildCountryList() => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final country = index == 0
              ? _countryStore.userCountry
              : _countryStore.countryDatasource?[index - 1];
          return index < 2
              ? _buildCombinedWidget(
                  context: context, index: index, country: country)
              : _buildCountryView(
                  context: context,
                  index: index,
                  indent: 32.0,
                  country: country);
        }, childCount: (_countryStore.countryDatasource?.length ?? 0) + 1),
      );

// Search Bar
  SliverToBoxAdapter _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.only(left: 16, right: 16),
          height: 47,
          child: Row(
            children: [
              Icon(
                Icons.search_outlined,
                color: Colors.blueGrey.shade500,
              ),
              _buildSearchInputTextField()
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade100.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

// Search Text Field
  Expanded _buildSearchInputTextField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: TextField(
          onChanged: (text) {
            _searchCountry(text: text);
          },
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              hintText: search.i18n,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none),
        ),
      ),
    );
  }

  // iOS Style Navigation Bar
  CupertinoSliverNavigationBar _buildNavigationBar(BuildContext context) {
    return CupertinoSliverNavigationBar(
      // trailing: CupertinoButton(
      //     onPressed: _dismiss,
      //     child: Icon(
      //       Icons.close,
      //       color: Colors.black,
      //     )),
      automaticallyImplyLeading: false,
      largeTitle: Text(
        country.i18n,
      ),
    );
  }
}

// Widgets
extension ListViewCells on _CountryListPageState {
  Widget _buildCombinedWidget(
      {required BuildContext context,
      required int index,
      required Country country}) {
    final sectionTitle = index == 0 ? yourCountry.i18n : otherCountries.i18n;
    final indent = index == 0 ? 0.0 : 32.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(context: context, sectionTitle: sectionTitle),
        _buildCountryView(
            context: context, index: index, indent: indent, country: country),
      ],
    );
  }

  Widget _buildSectionLabel(
          {required BuildContext context, required String sectionTitle}) =>
      Material(
        child: Container(
          height: 50,
          padding: const EdgeInsets.only(top: 30.0, left: 16.0),
          child: Text(sectionTitle),
        ),
      );

  Widget divider({double indent = 0}) => Divider(
        height: 1,
        indent: indent,
        color: Colors.grey,
      );

  Widget _buildCountryView(
      {required BuildContext context,
      required int index,
      required Country country,
      double indent = 0}) {
    final imageURL = 'assets/images/country-flags/${country.isoCode}.png';
    return Material(
      child: InkWell(
        onTap: () {
          widget.didSelectCountry(country);
          // this._dismiss();
        },
        child: Container(
          height: 90,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(visible: index < 2, child: divider()),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Image.asset(
                      imageURL,
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      width: 60,
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(country.phoneCode),
                    ),
                    Container(
                      margin: const EdgeInsets.all(12.0),
                      color: Colors.grey,
                      width: 0.5,
                      height: 30,
                    ),
                    Expanded(child: Text(country.name)),
                  ],
                ),
              ),
              divider(indent: indent),
            ],
          ),
        ),
      ),
    );
  }
}

extension ButtonAction on _CountryListPageState {
  // Close the Country Picker
  void _dismiss() {
    Navigator.pop(context);
  }

  void _searchCountry({String? text}) {
    final searchText = text ?? '';
    _countryStore.searchCountry(text: searchText);
  }
}
