
enum QuizType { RandomQuestion, TestQuestions }

class QuestionArguments {
  final List<int> ids;
  final String header;
  final QuizType quizType;

  QuestionArguments({this.ids, this.header, this.quizType});
}