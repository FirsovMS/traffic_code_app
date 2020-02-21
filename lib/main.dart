import 'package:flutter/material.dart';

import 'src/home_view.dart';
import 'src/question_api.dart';
import 'src/question_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static int _questionsCount;

  static Future<int> get questionsCount async {
    if(_questionsCount == null){
      _questionsCount = await QuestionApi.getQuestionsCount();
    }

    return _questionsCount;
  }

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traffic Code App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AppHomePage(title: 'Traffic Code App'),
        '/question': (context) => QuestionPage(),
      },
    );
  }
}