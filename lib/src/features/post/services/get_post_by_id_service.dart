import '../errors/errors.dart';
import '../models/post_model.dart';
import '../repositories/post_repository.dart';

class GetPostByIDService {
  final IPostRepository _repository;

  GetPostByIDService(this._repository);

  Future<Post> call(int id) async {
    final post = await _repository.getByID(id);

    if (post == null) throw PostNotFoundException();

    return post;
  }
}
