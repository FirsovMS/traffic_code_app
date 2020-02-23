import 'package:flutter/widgets.dart';
import 'package:traffic_code_app/src/question_api.dart';

class QuestionModel extends ChangeNotifier {
  String imageUrl;
  String text;
  int answerId;
  List<String> variants;
  String answerText;

  QuestionModel(
      {this.text,
      this.answerId,
      this.imageUrl,
      this.variants,
      this.answerText});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    final String imgId = json['img_id'];
    this.imageUrl = imgId != "null" ? QuestionApi.getImageURL(imgId) : null;
    this.text = json['question'];
    this.variants = json['variants'].cast<String>();
    this.answerId = json['answer_id'];
    this.answerText = json['answer_text'];
  }
}
