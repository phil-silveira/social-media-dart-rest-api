import 'package:social_media_rest_api/src/core/services/database/remote_database.dart';

import '../models/post_model.dart';

abstract class IPostRepository {
  Future<List<Post>> getAll();
  Future<Post?> getByID(int id);
  Future<void> deleteByID(int id);
  Future<Post> create(Post newPost);
  Future<Post> update(Post post);
}

class PostRepository implements IPostRepository {
  final RemoteDatabase database;

  PostRepository(this.database);

  @override
  Future<List<Post>> getAll() async {
    final result = await database.query(
      'SELECT * FROM "post" ORDER BY "createdAt" DESC;',
    );

    final posts = <Post>[];
    for (var i in result) {
      final data = i['post'];

      if (data != null) {
        posts.add(Post.fromMap(data));
      }
    }

    return posts;
  }

  @override
  Future<Post?> getByID(int id) async {
    final result = await database.query(
      'SELECT * FROM "post" WHERE id=@id;',
      variables: {
        'id': id.toString(),
      },
    );

    if (result.isEmpty) return null;

    final data = result.first['post'];
    if (data == null) return null;

    final post = Post.fromMap(data);

    return post;
  }

  @override
  Future<void> deleteByID(int id) async {
    await database.query(
      'DELETE FROM "post" WHERE id=@id;',
      variables: {'id': id.toString()},
    );
  }

  @override
  Future<Post> create(Post newPost) async {
    final result = await database.query(
      'INSERT INTO public.post(text) VALUES (@text) RETURNING id, text;',
      variables: {
        'text': newPost.text,
      },
    );
    // TODO: validate nullable
    final post = Post.fromMap(result.first['post']!);

    return post;
  }

  @override
  Future<Post> update(Post post) async {
    final result = await database.query(
      'UPDATE "post" SET text=@text WHERE id=@id RETURNING id, text;',
      variables: {
        'id': post.id.toString(),
        'text': post.text,
      },
    );
    // TODO: validate nullable
    final updatedPost = Post.fromMap(result.first['post']!);

    return updatedPost;
  }
}
