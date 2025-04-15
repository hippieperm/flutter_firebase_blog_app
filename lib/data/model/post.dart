// ignore_for_file: public_member_api_docs, sort_constructors_first
class Post {
  String title;
  String id;
  String content;
  String writer;
  String imageUrl;
  DateTime createdAt;

  Post({
    required this.title,
    required this.id,
    required this.content,
    required this.writer,
    required this.imageUrl,
    required this.createdAt,
  });

  Post.fromJson(Map<String, dynamic> map)
      : this(
          title: map['title'],
          id: map['id'],
          content: map['content'],
          writer: map['writer'],
          imageUrl: map['imageUrl'],
          createdAt: DateTime.parse(map['createdAt']),
        );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'content': content,
      'writer': writer,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
