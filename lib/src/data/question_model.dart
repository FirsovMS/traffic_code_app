
import 'package:flutter/widgets.dart';

class QuestionModel extends ChangeNotifier {
  String text;
  int answerId;
  List<String> variants;
  String imgPath;
  String answerText;

  QuestionModel({this.text, this.answerId, this.variants, this.imgPath});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    this.imgPath = json['img_id'];
    this.text = json['question'];
    this.variants = json['variants'].cast<String>();
    this.answerId = json['answer_id'];
    this.answerText = json['answer_text'];
  }
}
