import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traffic_code_app/src/data/question_model.dart';
import 'package:traffic_code_app/src/question_api.dart';
import 'package:transparent_image/transparent_image.dart';

import '../main.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new QuestionPageState();
}

class QuestionPageState extends State<StatefulWidget> {
  bool _isAnswerVisible = false;
  bool _isProgressIndicatorVisible = true;

  QuestionModel _questionModel;

  //  = new QuestionModel(
  //     text: 'Question Text',
  //     answerId: 3,
  //     imageUrl: "1.jpg",
  //     variants: [
  //       'first_first_first_first_first_first_first_first_first_first_first_first_first_first_first_first_first_',
  //       'second_second_second_second_second_second_second_second_second_second_second_second_second_second_second_second_',
  //       'third_third_third_third_third_third_third_third_third_third_third_third_third_third_third_third_third_third_third_'
  //     ],
  //     answerText:
  //         "Some_answer_text_Some_answer_text_Some_answer_text_Some_answer_text_Some_answer_text_Some_answer_text_Some_answer_text_Some_answer_text_Some_answer_text_Some_answer_text");

  void fetchData() {
    MyApp.questionsCount.then((count) => {
          QuestionApi.getQuestionJson(Random().nextInt(count)).then((json) => {
                setState(() {
                  _isProgressIndicatorVisible = false;
                  _questionModel = QuestionModel.fromJson(json);
                })
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
    final bool questionLoaded = _questionModel != null;

    return Scaffold(
        appBar: AppBar(
          title: Text('Question'),
        ),
        body: Stack(
          children: <Widget>[
            Visibility(
                visible: _isProgressIndicatorVisible,
                child: Center(child: CircularProgressIndicator())),
            Column(
              children:
                  questionLoaded ? _createBody(_questionModel) : <Widget>[],
            )
          ],
        ));
  }

  List<Widget> _createBody(QuestionModel question) {
    final descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 14,
      height: 1.4,
    );

    final _questionVariantButtons = _createQuestionVariants(question.variants);

    final questionList = DefaultTextStyle.merge(
        style: descTextStyle,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: Text(question.text, overflow: TextOverflow.clip),
              ),
              question.imageUrl != null
                  ? Container(
                      child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: question.imageUrl,
                    ))
                  : Container(),
              Column(
                children: _questionVariantButtons,
              ),
              Visibility(
                visible: _isAnswerVisible,
                child: Container(
                  child: Text(
                    question.answerText,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ],
          ),
        ));

    return <Widget>[questionList];
  }

  void _handleSelectedId(int id) {
    if(_isAnswerVisible){
      return;
    }

    setState(() {
      _isAnswerVisible = true;
    });
  }

  List<RaisedButton> _createQuestionVariants(List<String> variants) {
    var list = new List<RaisedButton>();
    for (var index = 0; index < variants.length; index++) {
      final id = index + 1;
      final selectedColor = _isAnswerVisible
          ? (id == _questionModel.answerId ? Colors.green : Colors.red)
          : Colors.black;

      final textWidget = Text(
        variants[index],
        overflow: TextOverflow.clip,
        textAlign: TextAlign.start,
        style: TextStyle(fontWeight: FontWeight.normal, color: selectedColor),
      );

      list.add(RaisedButton(
        onPressed: () => _handleSelectedId(id),
        child: textWidget,
      ));
    }

    return list;
  }
}
