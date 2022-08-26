import 'dart:io';

class DotEnvService {
  final Map<String, String> _map = {};

  static DotEnvService instance = DotEnvService._();

  DotEnvService._();

  load([String filename = '.env']) {
    final file = File(filename);
    final text = file.readAsStringSync();

    for (var line in text.split('\n')) {
      final lineBreak = line.split('=');

      _map[lineBreak.first] = lineBreak.last;
    }
  }

  String? operator [](String key) {
    return _map[key];
  }
}
