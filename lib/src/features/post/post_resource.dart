import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../../core/services/database/remote_database.dart';

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
  final result = await injector.get<RemoteDatabase>().query(
    'INSERT INTO public.post(text) VALUES (@text) RETURNING id, text;',
    variables: {'text': args.data['text']},
  );
  final post = result.map((e) => e['post']).first;
  return Response(201, body: jsonEncode(post));
}

FutureOr<Response> _updatePost(
  ModularArguments args,
  Injector injector,
) async {
  final result = await injector.get<RemoteDatabase>().query(
    'UPDATE "post" SET text=@text WHERE id=@id RETURNING id, text;',
    variables: {
      'id': args.data['id'],
      'text': args.data['text'],
    },
  );
  final post = result.map((e) => e['post']).first;

  return Response(200, body: jsonEncode(post));
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
