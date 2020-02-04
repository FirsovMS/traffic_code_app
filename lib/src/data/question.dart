class Question {
  String text;
  int answerId;
  List<int> variants;
  String imgPath;
  String answerText;

  Question({this.text, this.answerId, this.variants, this.imgPath});

  Question.fromJson(Map<String, dynamic> json) {
    this.imgPath = json['img_id'];
    this.text = json['question'];
    this.variants = json['variants'];
    this.answerId = json['answer_id'];
    this.answerText = json['answer_text'];
  }
}
