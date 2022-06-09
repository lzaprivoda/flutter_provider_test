import 'package:countries_test/data/api/app_config.dart';
import 'package:countries_test/data/api/graphql_api_client.dart';
import 'package:countries_test/data/repository/countries_repository.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'view/home_screen.dart';

void main() {
  const AppConfig config = AppConfig(baseUrl: 'https://countries.trevorblades.com/');
  runApp(app(config));
}

Widget app(AppConfig config) {
  return MultiProvider(
    providers: [
      Provider<AppConfig>(
        create: (BuildContext context) => config,
      ),
      Provider<GraphQLApiClient>(
        create: (BuildContext context) => GraphQLApiClient(
          context.read(),
        ),
      ),
      Provider<CountriesRepository>(
        create: (BuildContext context) => CountriesRepositoryImpl(
          context.read(),
        ),
      ),
    ],
    child: MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: context.select((GraphQLApiClient value) => value.client),
      child: MaterialApp(
        title: 'Countries',
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (_) => const HomeScreen(),

        },
      ),
    );
  }
}
