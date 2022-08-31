import 'package:mocktail/mocktail.dart';
import 'package:social_media_rest_api/src/features/post/models/post_model.dart';
import 'package:social_media_rest_api/src/features/post/repositories/post_repository.dart';
import 'package:social_media_rest_api/src/features/post/services/get_all_posts_service.dart';
import 'package:test/test.dart';

class _Mock extends Mock implements IPostRepository {}

void main() {
  group('get all posts service ...', () {
    final mock = _Mock();
    test('should return a list wiht 1 post', () async {
      when(() => mock.getAll()).thenAnswer(
          (invocation) async => [Post(text: 'first post added', id: 42)]);

      final result = await GetAllPostService(mock).call();
      expect(result.length, 1);
      expect(result.first.id, 42);
      expect(result.first.text, 'first post added');
    });
  });
}
