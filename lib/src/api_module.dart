import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import 'core/services/database/postgres/postgres_database.dart';
import 'core/services/database/remote_database.dart';
import 'core/services/dot_env/dot_env_service.dart';
import 'features/post/post_resource.dart';
import 'features/swagger/swagger_handler.dart';

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
        Route.get("/", () => Response.ok("Welcome to Social Media API")),
        Route.get("/docs/**", swaggerHandler),
        Route.resource(PostResource()),
      ];
}
