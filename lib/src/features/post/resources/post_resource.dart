import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:social_media_rest_api/src/features/post/models/post_model.dart';
import 'package:social_media_rest_api/src/features/post/repositories/post_repository.dart';

class PostResource extends Resource {
  static final path = "/posts";
  @override
  List<Route> get routes => [
        Route.get(path, _getAllPosts),
        Route.get("$path/:id", _getPostByID),
        Route.delete("$path/:id", _deletePostByID),
        Route.post(path, _createPost),
        Route.put(path, _updatePost),
      ];
}

FutureOr<Response> _getAllPosts(Injector injector) async {
  final posts = await injector.get<IPostRepository>().getAll();

  return Response(
    200,
    body: jsonEncode(posts.map((e) => e.toMap()).toList()),
  );
}

FutureOr<Response> _getPostByID(
  ModularArguments args,
  Injector injector,
) async {
  final post = await injector.get<IPostRepository>().getByID(
        int.parse(args.params['id']),
      );

  if (post == null) return Response(404);

  return Response(200, body: post.toJson());
}

FutureOr<Response> _createPost(
  ModularArguments args,
  Injector injector,
) async {
  final post = await injector.get<IPostRepository>().create(
        Post(
          text: args.data['text'],
        ),
      );

  return Response(201, body: post.toJson());
}

FutureOr<Response> _updatePost(
  ModularArguments args,
  Injector injector,
) async {
  final post = await injector.get<IPostRepository>().update(
        Post(
          id: args.data['id'],
          text: args.data['text'],
        ),
      );

  return Response(200, body: post.toJson());
}

FutureOr<Response> _deletePostByID(
  ModularArguments args,
  Injector injector,
) async {
  await injector.get<IPostRepository>().deleteByID(
        int.parse(args.params['id']),
      );

  return Response(200, body: "Post ID (${args.params['id']}) deleted");
}
