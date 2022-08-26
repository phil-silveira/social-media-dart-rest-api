import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:social_media_rest_api/core/services/database/postgres/postgres_database.dart';
import 'package:social_media_rest_api/core/services/database/remote_database.dart';
import 'package:social_media_rest_api/core/services/dot_env/dot_env_service.dart';
import 'package:social_media_rest_api/post/post_resource.dart';

class ApiModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.instance<DotEnvService>(
          DotEnvService.instance,
        ),
        Bind.singleton<RemoteDatabase>(
          (i) => PostgresDatabase(i()),
        ),
      ];
  @override
  List<ModularRoute> get routes => [
        Route.get(
            "/", () => Response(200, body: "Welcome to Social Media API")),
        Route.resource(PostResource()),
      ];
}
