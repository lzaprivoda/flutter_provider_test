import 'package:countries_test/data/api/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLApiClient {
  final ValueNotifier<GraphQLClient> client;

  GraphQLApiClient(AppConfig config)
      : client = ValueNotifier<GraphQLClient>(GraphQLClient(
            cache: GraphQLCache(), link: HttpLink(config.baseUrl)));

  Future<QueryResult> query(
    String queryString, {
    Map<String, dynamic>? variables,
  }) async {
    final query = gql(queryString);

    final QueryOptions options =
        QueryOptions(document: query, variables: variables ?? {});

    final QueryResult result = await client.value.query(options);

    if (result.exception != null) {
      if (kDebugMode) {
        print(result.exception);
      }

      if (result.exception?.graphqlErrors != null) {
        for (final GraphQLError error in result.exception!.graphqlErrors) {
          if (kDebugMode) {
            print(error.message);
          }
        }
      }
    }
    return result;
  }
}
