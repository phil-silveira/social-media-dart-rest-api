import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:social_media_rest_api/src/core/core_module.dart';
import 'package:social_media_rest_api/src/features/post/repositories/post_repository.dart';
import 'package:social_media_rest_api/src/features/post/services/create_post_service.dart';
import 'package:social_media_rest_api/src/features/post/services/delete_post_by_id_service.dart';
import 'package:social_media_rest_api/src/features/post/services/get_all_posts_service.dart';
import 'package:social_media_rest_api/src/features/post/services/get_post_by_id_service.dart';
import 'package:social_media_rest_api/src/features/post/services/update_post_service.dart';

import 'features/post/resources/post_resource.dart';
import 'features/swagger/swagger_handler.dart';

class ApiModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<IPostRepository>((i) => PostRepository(i())),
        Bind.factory((i) => GetAllPostService(i())),
        Bind.factory((i) => GetPostByIDService(i())),
        Bind.factory((i) => CreatePostService(i())),
        Bind.factory((i) => UpdatePostService(i())),
        Bind.factory((i) => DeletePostByIDService(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.get("/", () => Response.ok("Welcome to Social Media API")),
        Route.get("/docs/**", swaggerHandler),
        Route.resource(PostResource()),
      ];
}
