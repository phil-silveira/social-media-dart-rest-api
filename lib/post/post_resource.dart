import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

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

FutureOr<Response> _getAllPosts() {
  return Response(200, body: "Get all posts");
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
