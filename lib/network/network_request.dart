import 'dart:convert';
import '../model/post.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkRequest {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  static List<Post> parsePost(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;
    List<Post> posts = list.map((model) => Post.fromJson(model)).toList();
    return posts;
  }

  static Future<List<Post>> findPosts({int page = 1}) async { 
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404){
      throw Exception('API not found');
    } else {
      throw Exception('Cant find posts');
    }
  }
}