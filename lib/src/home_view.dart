import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import 'data/QuestionArguments.dart';
import 'question_view.dart';

class AppHomePage extends StatefulWidget {
  static const routeName = 'home';
  final String title;

  AppHomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new AppHomePageState();
}

class AppHomePageState extends State<AppHomePage> {
  final int _randomQuestionsCount = 40;

  bool _canStartQuiz = false;
  int _count;

  void fetchData() {
    MyApp.questionsCount.then((count) => {
          setState(() {
            _canStartQuiz = count != 0;
            _count = count;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final Widget body = _createBody(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body,
    );
  }

  Widget _createButtonsBar(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: <Widget>[
            _createButtonByType(context, QuizType.RandomQuestion),
            _createButtonByType(context, QuizType.TestQuestions),
          ],
        )
      ],
    );
  }

  Widget _createBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _canStartQuiz
              ? _createButtonsBar(context)
              : _createPreLoader(),
        ],
      ),
    );
  }

  Widget _createPreLoader() {
    return Visibility(
      visible: !_canStartQuiz,
      child: Center(child: CircularProgressIndicator())
    );

    // Text("Can't load questions!")
  }

  List<int> _generateRandomIds() {
    var random = new Random();
    return new List.generate(
        _randomQuestionsCount, (i) => random.nextInt(_count));
  }

  QuestionArguments _generateArguments(QuizType quizType) {
    switch (quizType) {
      case QuizType.RandomQuestion:
        return QuestionArguments(
          header: "Random Questions",
          ids: _generateRandomIds(),
          quizType: quizType
        );
        break;
      case QuizType.TestQuestions:
        return QuestionArguments(
          header: "Test Questions",
          ids: _generateRandomIds(),
          quizType: quizType
        );
    }
    return null;
  }

  Widget _createButtonByType(BuildContext context, QuizType quizType) {
    final args = _generateArguments(quizType);

    return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, QuestionPage.routeName, arguments: args);
      },
      child: Text('Start ${args.header}'),
    );
  }
}