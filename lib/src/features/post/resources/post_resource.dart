import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:social_media_rest_api/src/features/post/models/post_model.dart';

import '../errors/errors.dart';
import '../services/create_post_service.dart';
import '../services/delete_post_by_id_service.dart';
import '../services/get_all_posts_service.dart';
import '../services/get_post_by_id_service.dart';
import '../services/update_post_service.dart';

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
  final posts = await injector.get<GetAllPostService>()();

  return Response(
    HttpStatus.ok,
    body: jsonEncode(posts.map((e) => e.toMap()).toList()),
  );
}

FutureOr<Response> _getPostByID(
  ModularArguments args,
  Injector injector,
) async {
  try {
    final post = await injector.get<GetPostByIDService>()(
      int.parse(args.params['id']),
    );

    return Response(
      HttpStatus.ok,
      body: post.toJson(),
    );
  } on PostNotFoundException {
    return Response(HttpStatus.notFound);
  }
}

FutureOr<Response> _createPost(
  ModularArguments args,
  Injector injector,
) async {
  final post = await injector.get<CreatePostService>()(
    Post(
      text: args.data['text'],
    ),
  );

  return Response(
    HttpStatus.created,
    body: post.toJson(),
  );
}

FutureOr<Response> _updatePost(
  ModularArguments args,
  Injector injector,
) async {
  try {
    final post = await injector.get<UpdatePostService>()(
      Post(
        id: args.data['id'],
        text: args.data['text'],
      ),
    );

    return Response(
      HttpStatus.ok,
      body: post.toJson(),
    );
  } on PostNotFoundException {
    return Response(HttpStatus.notFound);
  }
}

FutureOr<Response> _deletePostByID(
  ModularArguments args,
  Injector injector,
) async {
  try {
    await injector.get<DeletePostByIDService>()(
      int.parse(args.params['id']),
    );

    return Response(
      HttpStatus.ok,
      body: "Post ID (${args.params['id']}) deleted",
    );
  } on PostNotFoundException {
    return Response(HttpStatus.notFound);
  }
}
