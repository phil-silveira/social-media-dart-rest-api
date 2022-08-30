import 'dart:async';

import 'package:postgres/postgres.dart';

import '../../dot_env/dot_env_service.dart';
import '../remote_database.dart';

class PostgresDatabase implements RemoteDatabase {
  final completer = Completer<PostgreSQLConnection>();
  final DotEnvService _dotEnv;

  PostgresDatabase(this._dotEnv) {
    _init();
  }

  _init() async {
    final uri = Uri.parse(_dotEnv['DATABASE_URL'] ?? '');

    final connection = PostgreSQLConnection(
      uri.host,
      uri.port,
      uri.pathSegments.first,
      username: uri.userInfo.split(':').first,
      password: uri.userInfo.split(':').last,
    );
    await connection.open();
    completer.complete(connection);
  }

  @override
  Future<List<Map<String, Map<String, dynamic>>>> query(
    String queryText, {
    Map<String, String> variables = const {},
  }) async {
    final connection = await completer.future;

    return await connection.mappedResultsQuery(
      queryText,
      substitutionValues: variables,
    );
  }
}
