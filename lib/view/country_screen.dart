import 'package:flutter/material.dart';
import 'package:countries_test/data/model/countries.dart';
import 'package:provider/provider.dart';

class CountryScreenViewModel extends ChangeNotifier {
  final Country _country;
  bool _expanded = false;

  bool get isExpanded => _expanded;

  Country get country => _country;

  CountryScreenViewModel(this._country);

  void switchExpanded() {
    _expanded = !_expanded;
    notifyListeners();
  }
}

class CountryScreen extends StatefulWidget {
  final Country _country;

  const CountryScreen(this._country, {Key? key}) : super(key: key);

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CountryScreenViewModel>(
      create: (_) => CountryScreenViewModel(widget._country),
      builder: (context, child) {
        return _Body(context.watch<CountryScreenViewModel>());
      },
    );
  }
}

class _Body extends StatelessWidget {
  final CountryScreenViewModel _model;

  const _Body(this._model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Country country =
        context.select((CountryScreenViewModel model) => model.country);
    return Scaffold(
        appBar: AppBar(
          title: Text(country.name ?? "Unknown country"),
        ),
        body: _contents(context, _model));
  }

  Widget _contents(BuildContext context, CountryScreenViewModel model) {
    final bool isExpanded = model.isExpanded;
    final Country country = model.country;
    return Column(
      children: [
        _listItem(context, "Capital: ${country.capital ?? "-"}"),
        _listItem(context, "Currency: ${country.currency ?? "-"}"),
        _listItem(context, "Flag: ${country.emoji ?? "-"}"),
        if (isExpanded) _listItem(context, "Languages: "),
        Row(
          children: [
            Expanded(
              child:
                  _languagesList(isExpanded ? country.languages : List.empty()),
            ),
          ],
        ),
        _buildButton(context)
      ],
    );
  }

  Widget _listItem(BuildContext context, String text) {
    return ListTile(
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      leading: const Text("•"),
    );
  }

  Widget _buildButton(BuildContext context) {
    final bool isExpanded =
        context.select((CountryScreenViewModel model) => model.isExpanded);
    return OutlinedButton.icon(
        onPressed: () =>
            Provider.of<CountryScreenViewModel>(context, listen: false)
                .switchExpanded(),
        icon: Icon(
          isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          size: 24.0,
        ),
        label: Text(isExpanded ? "Collapse" : "Expand"));
  }

  Widget _languagesList(List<Language> languages) {
    if (languages.isEmpty) {
      return const Divider();
    }
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: _listItem(context, languages[index].name ?? ""),
        );
      },
      itemCount: languages.length,
      separatorBuilder: (_, __) {
        return const Divider();
      },
    );
  }
}
