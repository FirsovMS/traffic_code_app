import 'package:flutter/material.dart';
import 'src/question_page.dart';
import 'src/question_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static int _questionsCount;

  static int get questionsCount => _questionsCount;

  MyApp({Key key}) : super(key: key) {
    QuestionApi.getQuestionsCount().then((val) => _questionsCount = val);
  }

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

class AppHomePage extends StatefulWidget {
  final String title;

  AppHomePage({Key key, this.title}) : super(key: key);  

  @override
  State<StatefulWidget> createState() => new AppHomePageState();
}

class AppHomePageState extends State<AppHomePage> {
  @override
  Widget build(BuildContext context) {
    var body = _createBody(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body,
    );
  }

   Widget _buttonsBarStart(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/question');
          },
          child: Text('Start'),
        )
      ],
    );
  }

  Widget _createBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buttonsBarStart(context),
        ],
      ),
    );
  }
}
