import 'dart:convert';

class Post {
  final int id;
  final String text;

  Post({
    this.id = 0,
    required this.text,
  });

  Post.fromMap(Map<String, dynamic> json)
      : id = json['id'] as int,
        text = json['text'] as String;

  Map<String, dynamic> toMap() => {
        'id': id,
        'text': text,
      };

  String toJson() => jsonEncode(toMap());
}
