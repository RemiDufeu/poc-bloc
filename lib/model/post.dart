class Post {
  int id = 0;
  String title = '';
  String body = '';
  List<String> tags = [];

  Post(this.id, this.title, this.body, this.tags);

  Post.defaultPost();

  Post.fromJson(Map<String,dynamic> postMap) {
    id = postMap['id'];
    title = postMap['title'];
    body = postMap['body'];
     if (postMap['tags'] != null && postMap['tags'] is List) {
      tags = List<String>.from(postMap['tags'].map((tag) => tag.toString()));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'tags': tags,
      'userId' : 5
    };
  }

  Post copyWith({int? id, String? title, String? body, List<String>? tags}) {
    return Post(
      id ?? this.id,
      title ?? this.title,
      body ?? this.body,
      tags ?? this.tags
    );
  }
}