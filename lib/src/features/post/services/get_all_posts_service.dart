import '../models/post_model.dart';
import '../repositories/post_repository.dart';

class GetAllPostService {
  final IPostRepository _repository;

  GetAllPostService(this._repository);

  Future<List<Post>> call() async {
    final posts = await _repository.getAll();

    return posts;
  }
}
