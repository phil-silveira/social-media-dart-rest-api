import 'package:shelf_modular/shelf_modular.dart';

import 'services/database/postgres/postgres_database.dart';
import 'services/database/remote_database.dart';
import 'services/dot_env/dot_env_service.dart';

class CoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.instance<DotEnvService>(
          DotEnvService.instance,
          export: true,
        ),
        Bind.singleton<RemoteDatabase>(
          (i) => PostgresDatabase(i()),
          export: true,
        ),
      ];
}
