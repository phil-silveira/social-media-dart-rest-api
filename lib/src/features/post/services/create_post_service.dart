import '../models/post_model.dart';
import '../repositories/post_repository.dart';

class CreatePostService {
  final IPostRepository _repository;

  CreatePostService(this._repository);

  Future<Post> call(Post post) async {
    final newPost = await _repository.create(post);

    return newPost;
  }
}
