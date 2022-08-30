import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_modular/shelf_modular.dart';
import 'package:social_media_rest_api/api.dart';
import 'package:social_media_rest_api/src/api_module.dart';
import 'package:social_media_rest_api/src/core/services/dot_env/dot_env_service.dart';

void main(List<String> arguments) async {
  DotEnvService.instance.load();

  await io.serve(
    _modularHandler,
    "0.0.0.0",
    8080,
  );

  print("Server running on port 8080");
}

final _modularHandler = Modular(
  module: ApiModule(),
  middlewares: [
    logRequests(),
    jsonResponse(),
  ],
);
