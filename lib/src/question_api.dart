import 'dart:convert';

import 'package:http/http.dart' as http;

class QuestionApi {
  static final host =
      'https://trafficcodeappwebapi20200208102452.azurewebsites.net/';

  static Future<Map<String, dynamic>> getQuestionJson(int id) async {
    var client = http.Client();
    try {
      var response = await client.get('$host/api/question/$id');
      Map<String, dynamic> result = jsonDecode(response.body);
      return result;
    } finally {
      client.close();
    }
  }

  static String getImageURL(String name) {
    return '$host/images/$name';
  }

  static Future<int> getQuestionsCount() async {
    var client = http.Client();
    try {
      var response = await client.get('$host/api/questions/count');
      return int.parse(response.body);
    } finally {
      client.close();
    }
  }
}
