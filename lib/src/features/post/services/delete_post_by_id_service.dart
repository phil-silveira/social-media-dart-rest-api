import 'package:social_media_rest_api/src/features/post/errors/errors.dart';

import '../repositories/post_repository.dart';

class DeletePostByIDService {
  final IPostRepository _repository;

  DeletePostByIDService(this._repository);

  Future<void> call(int id) async {
    final result = await _repository.getByID(id);

    if (result == null) throw PostNotFoundException();

    await _repository.deleteByID(id);
  }
}
