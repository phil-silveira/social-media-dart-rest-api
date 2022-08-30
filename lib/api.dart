import 'package:shelf/shelf.dart';

Middleware jsonResponse() {
  return (handler) {
    return (request) async {
      final response = await handler(request);

      response.change(
        headers: {
          'content-type': 'application/json',
          ...response.headers,
        },
      );

      return response;
    };
  };
}
