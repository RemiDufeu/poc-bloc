import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poc_blocs/model/post.dart';

class HttpApiHelper {
  final authority = 'dummyjson.com';
  final postPath = "posts";
  final postSearchPath = "posts/search";
  final postAddPath = "posts/add";

  Future<List<Post>> getPostsLists(String query) async {
    Map<String,dynamic> parameters = { 'q' : query };
    final uri = Uri.https(authority, postSearchPath, parameters);
    var result = await http.get(uri);
    
    if (result.statusCode < 200 || result.statusCode > 299 ) {
      throw Exception('Failed to load posts');
    }

    var jsonResponse = json.decode(result.body);
    List<dynamic> dataList = jsonResponse['posts'];
    List<Post> posts = [];
    for (var data in dataList) {
      posts.add(Post.fromJson(data));
    }
    return posts;
  }

  Future<Post> createPost(Post post) async {
    final uri = Uri.https(authority, postAddPath);

    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(post.toJson()); // Encode le corps de la requête en JSON

    var result = await http.post(uri, headers: headers, body: body);
    
    if (result.statusCode < 200 || result.statusCode > 299 ) {
      throw Exception('Failed to create post');
    }
    
    Map<String,dynamic> data = json.decode(result.body);
    var newPost = Post.fromJson(data);
    return newPost;
  }

  Future<Post> getPost(int id) async {
    final uri = Uri.https(authority, '$postPath/$id');
    var result = await http.get(uri);
    
    if (result.statusCode < 200 || result.statusCode > 299 ) {
      throw Exception('Failed to load post');
    }
    
    Map<String,dynamic> data = json.decode(result.body);
    var post = Post.fromJson(data);
    return post;
  }
}