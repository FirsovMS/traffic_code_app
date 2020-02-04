import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traffic_code_app/src/data/Question.dart';
import 'package:traffic_code_app/src/question_provider.dart';

class QuestionPage extends StatefulWidget {
  int id;

  QuestionPage() {
    this.id = Random().nextInt(1000);
  }

  QuestionPage.byId(int id) {
    this.id = id;
  }

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    Question question;
    getQuestionById(widget.id).then((val) => {question = val});

    return Scaffold(
      appBar: AppBar(
        title: Text('Question'),
      ),
      body: Column(
        children: createBody(question),
      ),
    );
  }

  createBody(Question question) {
    return Column(
      children: <Widget>[],
    );
  }

  Future<Question> getQuestionById(int id) async {
    final db = await QuestionProvider.instance.database;
    var result = await db.query(QuestionProvider.table,
        columns: [QuestionProvider.columnJson],
        where: '${QuestionProvider.columnId} = ?',
        whereArgs: [id]);

    return Question.fromJson(result.first);
  }
}
