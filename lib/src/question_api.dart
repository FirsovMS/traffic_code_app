import 'dart:convert';

import 'package:http/http.dart.' as http;

import '../env.dart';

class QuestionApi {
  static final String _host = environment['baseUrl'];

  static Future<Map<String, dynamic>> getQuestionJson(int id) async {
    final client = http.Client();
    try {
      var response = await client.get('$_host/api/question/$id');
      Map<String, dynamic> result = jsonDecode(response.body);
      return result;
    } finally {
      client.close();
    }
  }

  static String getImageURL(String name) {
    return '$_host/images/$name';
  }

  static Future<int> getQuestionsCount() async {
    final client = http.Client();
    try {
      var url = '$_host/api/questions/count';
      var response = await client.get(url);
      return int.parse(response.body);
    } finally {
      client.close();
    }
  }
}
