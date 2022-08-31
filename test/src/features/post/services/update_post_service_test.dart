import 'package:mocktail/mocktail.dart';
import 'package:social_media_rest_api/src/features/post/errors/errors.dart';
import 'package:social_media_rest_api/src/features/post/models/post_model.dart';
import 'package:social_media_rest_api/src/features/post/repositories/post_repository.dart';
import 'package:social_media_rest_api/src/features/post/services/update_post_service.dart';
import 'package:test/test.dart';

class _Mock extends Mock implements IPostRepository {}

void main() {
  group('update post service ...', () {
    final mock = _Mock();

    test('should return updated post', () async {
      final post = Post(id: 5, text: 'testing v2');

      when(() => mock.getByID(5))
          .thenAnswer((invocation) async => Post(id: 5, text: 'testing'));
      when(() => mock.update(post)).thenAnswer((invocation) async => post);

      final result = await UpdatePostService(mock)(post);

      expect(result.id, 5);
      expect(result.text, 'testing v2');
    });
    test('should raise post not found error', () async {
      final post = Post(id: 5, text: 'testing v2');

      when(() => mock.getByID(5)).thenAnswer((invocation) async => null);

      expect(
        () async => await UpdatePostService(mock)(post),
        throwsA(isA<PostNotFoundException>()),
      );
    });
  });
}
