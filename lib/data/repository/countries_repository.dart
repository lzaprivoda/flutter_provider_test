import 'package:countries_test/data/api/graphql_api_client.dart';
import 'package:countries_test/data/model/countries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const String getCountriesQuery = r'''
  query Countries { 
          countries { 
            name
            native
            capital
            emoji
            currency
            languages {
              code
              name
            }
        }
  }
''';

abstract class CountriesRepository {
  Future<List<Country>> getCountries();
}

class CountriesRepositoryImpl implements CountriesRepository {

  final GraphQLApiClient _client;

  CountriesRepositoryImpl(this._client);

  @override
  Future<List<Country>> getCountries() async {
    final QueryResult result =
    await _client.query(getCountriesQuery);

    final countriesList = Countries.fromJson(result.data as Map<String, dynamic>);
    return countriesList.getCountries();
  }

}