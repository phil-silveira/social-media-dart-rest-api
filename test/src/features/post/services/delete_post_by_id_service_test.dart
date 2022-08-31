import 'package:mocktail/mocktail.dart';
import 'package:social_media_rest_api/src/features/post/errors/errors.dart';
import 'package:social_media_rest_api/src/features/post/models/post_model.dart';
import 'package:social_media_rest_api/src/features/post/repositories/post_repository.dart';
import 'package:social_media_rest_api/src/features/post/services/delete_post_by_id_service.dart';
import 'package:test/test.dart';

class _Mock extends Mock implements IPostRepository {}

void main() {
  group('delete post by id service ...', () {
    final mock = _Mock();

    test('should delete post', () async {
      when(() => mock.getByID(any())).thenAnswer(
          (invocation) async => Post(text: 'the special post', id: 32));
      // ignore: avoid_returning_null_for_void
      when(() => mock.deleteByID(any())).thenAnswer((invocation) async => null);

      await DeletePostByIDService(mock).call(32);
    });

    test('should raise post not found error', () async {
      when(() => mock.getByID(any())).thenAnswer((invocation) async => null);

      expect(
        () async => await DeletePostByIDService(mock).call(32),
        throwsA(isA<PostNotFoundException>()),
      );
    });
  });
}
