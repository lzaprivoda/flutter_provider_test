import 'package:countries_test/data/repository/countries_repository.dart';
import 'package:countries_test/view/country_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:countries_test/data/model/countries.dart';
import 'package:provider/provider.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final CountriesRepository _countryRepository;

  HomeScreenViewModel(this._countryRepository) {
    getCountries();
  }

  List<Country> countries = [];

  Future<void> getCountries() async {
    try {
      countries = await _countryRepository.getCountries();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenViewModel>(
      create: (_) => HomeScreenViewModel(
        context.read(),
      ),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Countries'),
        ),
        body: _contents(context));
  }

  Widget _contents(BuildContext context) {
    final List<Country> countries =
        context.select((HomeScreenViewModel model) => model.countries);
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return _listItem(context, countries[index]);
      },
      itemCount: countries.length,
      separatorBuilder: (_, __) {
        return const Divider();
      },
    );
  }

  Widget _listItem(BuildContext context, Country country) {
    return ListTile(
      title: Text(
        country.name ?? "",
        style: Theme.of(context).textTheme.bodyText1,
      ),
      leading: Text(country.emoji ?? ""),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CountryScreen(country),
            ));
      },
    );
  }
}
