import 'dart:async';

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
        Route.put(path, _updatePost),
        Route.delete("$path/:id", _deletePostByID),
      ];
}

FutureOr<Response> _getAllPosts(Injector injector) async {
  final result = await injector
      .get<RemoteDatabase>()
      .query('SELECT * FROM "Post" ORDER BY "createdAt" DESC;');

  final posts = result.map((i) => Post.fromJson(i['Post']!)).toList();

  return Response(200, body: posts.toString());
}

class Post {
  final int id;
  final String text;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        createdAt = json['createdAt'];
}

FutureOr<Response> _getPostByID(ModularArguments args) {
  return Response(200, body: "Get post ID (${args.params['id']})");
}

FutureOr<Response> _createPost() {
  return Response(200, body: "New post added");
}

FutureOr<Response> _updatePost() {
  return Response(200, body: "Post updated");
}

FutureOr<Response> _deletePostByID(ModularArguments args) {
  return Response(200, body: "Post ID (${args.params['id']}) deleted");
}
