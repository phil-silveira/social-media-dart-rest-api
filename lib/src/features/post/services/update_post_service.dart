import 'package:social_media_rest_api/src/features/post/errors/errors.dart';

import '../models/post_model.dart';
import '../repositories/post_repository.dart';

class UpdatePostService {
  final IPostRepository _repository;

  UpdatePostService(this._repository);

  Future<Post> call(Post post) async {
    final result = await _repository.getByID(post.id);

    if (result == null) throw PostNotFoundException();

    final updated = await _repository.update(post);

    return updated;
  }
}
