import 'package:social_media_rest_api/core/services/dot_env/dot_env_service.dart';
import 'package:test/test.dart';

void main() {
  test('dot env service ...', () async {
    final service = DotEnvService.instance;

    expect(service['DATABASE_URL'], null);
    service.load('.env.example');
    expect(service['DATABASE_URL'], '<EXAMPLE-URL-HERE>');
  });
}
