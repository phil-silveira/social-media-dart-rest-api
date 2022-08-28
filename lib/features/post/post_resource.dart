import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:social_media_rest_api/core/services/database/remote_database.dart';

class PostResource extends Resource {
  static final path = "/posts";
  @override
  List<Route> get routes => [
        Route.get(path, _getAllPosts),
        Route.get("$path/:id", _getPostByID),
        Route.post(path, _createPost),
        Route.put("$path/:id", _updatePost),
        Route.delete("$path/:id", _deletePostByID),
      ];
}

FutureOr<Response> _getAllPosts(Injector injector) async {
  final result = await injector
      .get<RemoteDatabase>()
      .query('SELECT * FROM "post" ORDER BY "createdAt" DESC;');

  final posts = result.map((i) {
    final item = i['post'];
    item?.remove('createdAt');
    return item;
  }).toList();

  return Response(200, body: jsonEncode(posts));
}

FutureOr<Response> _getPostByID(
  ModularArguments args,
  Injector injector,
) async {
  final result = await injector.get<RemoteDatabase>().query(
    'SELECT * FROM "post" WHERE id=@id;',
    variables: {'id': args.params['id']},
  );

  if (result.isEmpty) return Response(404);

  final post = result.first['post'];
  post?.remove('createdAt');

  return Response(200, body: jsonEncode(post));
}

FutureOr<Response> _createPost(
  ModularArguments args,
  Injector injector,
) async {
  await injector.get<RemoteDatabase>().query(
    'INSERT INTO public.post(text) VALUES (@text);',
    variables: {'text': args.data['text']},
  );
  return Response(201, body: "New post added");
}

FutureOr<Response> _updatePost(
  ModularArguments args,
  Injector injector,
) async {
  await injector.get<RemoteDatabase>().query(
    'UPDATE "post" SET text=@text WHERE id=@id;',
    variables: {
      'id': args.params['id'],
      'text': args.data['text'],
    },
  );

  return Response(200, body: "Post updated");
}

FutureOr<Response> _deletePostByID(
  ModularArguments args,
  Injector injector,
) async {
  await injector.get<RemoteDatabase>().query(
    ' DELETE FROM "post" WHERE id=@id;',
    variables: {'id': args.params['id']},
  );

  return Response(200, body: "Post ID (${args.params['id']}) deleted");
}
