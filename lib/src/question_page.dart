import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new QuestionPageState();
}

class QuestionPageState extends State<StatefulWidget> {
  final int id = Random().nextInt(MyApp.questionsCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Question'),
        ),
        body: Column(
          children: createBody(),
        ));
  }

  List<Widget> createBody() {
    final descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 18,
      height: 2,
    );

    final questionList = DefaultTextStyle.merge(
      style: descTextStyle,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Question Text'),
            Column(
              children: createVariantsWidget(['first1', 'second2', 'third3']),
            )
          ],
        ),
      )
    );

    return <Widget>[
      questionList
    ];
  }

  List<Widget> createVariantsWidget(List<String> variants) {
    var result = new List<Widget>();
    if (variants.isNotEmpty) {
      variants.forEach((v) => {result.add(Text(v))});
    }

    return result;
  }
}
