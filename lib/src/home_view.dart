import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

class AppHomePage extends StatefulWidget {
  final String title;

  AppHomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new AppHomePageState();
}

class AppHomePageState extends State<AppHomePage> {
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
        _createStartRandomButton(context),
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
              : Text("Can't load questions!"),
        ],
      ),
    );
  }

  int _randomQuestionsCount = 40;

  List<int> _generateRandomIds() {
    var random = new Random();
    return new List.generate(
        _randomQuestionsCount, (i) => random.nextInt(_count));
  }

  Widget _createStartRandomButton(BuildContext context) {
    final randomIds = new Map<String, dynamic>();
    randomIds["ids"] = _generateRandomIds();

    return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/question', arguments: randomIds);
      },
      child: Text('Start'),
    );
  }
}