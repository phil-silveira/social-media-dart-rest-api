import 'package:mocktail/mocktail.dart';
import 'package:social_media_rest_api/src/features/post/errors/errors.dart';
import 'package:social_media_rest_api/src/features/post/models/post_model.dart';
import 'package:social_media_rest_api/src/features/post/repositories/post_repository.dart';
import 'package:social_media_rest_api/src/features/post/services/get_post_by_id_service.dart';
import 'package:test/test.dart';

class _Mock extends Mock implements IPostRepository {}

void main() {
  group('get post by id service ...', () {
    final mock = _Mock();
    test('should return post of id 32', () async {
      when(() => mock.getByID(any())).thenAnswer(
          (invocation) async => Post(text: 'the special post', id: 32));

      final result = await GetPostByIDService(mock).call(32);

      expect(result.id, 32);
      expect(result.text, 'the special post');
    });

    test('should raise post not found error', () async {
      when(() => mock.getByID(any())).thenAnswer((invocation) async => null);

      expect(
        () async => await GetPostByIDService(mock).call(32),
        throwsA(isA<PostNotFoundException>()),
      );
    });
  });
}
