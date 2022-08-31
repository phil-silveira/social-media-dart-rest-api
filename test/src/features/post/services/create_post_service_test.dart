import 'package:mocktail/mocktail.dart';
import 'package:social_media_rest_api/src/features/post/models/post_model.dart';
import 'package:social_media_rest_api/src/features/post/repositories/post_repository.dart';
import 'package:social_media_rest_api/src/features/post/services/create_post_service.dart';
import 'package:test/test.dart';

class _Mock extends Mock implements IPostRepository {}

void main() {
  group('create post service ...', () {
    final mock = _Mock();

    test('should return created post', () async {
      final post = Post(text: 'testing');

      when(() => mock.create(post))
          .thenAnswer((invocation) async => Post(id: 5, text: 'testing'));

      final result = await CreatePostService(mock)(post);

      expect(result.id, 5);
      expect(result.text, 'testing');
    });
  });
}
