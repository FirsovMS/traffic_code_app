import 'package:flutter/material.dart';
import 'package:traffic_code_app/src/question_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppHomePage(title: 'Traffic Code App'),
      routes: {
        '/': (context) => AppHomePage(title: 'Traffic Code App'),
        '/question': (context) => QuestionPage(),
      },
    );
  }
}

class AppHomePage extends StatefulWidget {
  AppHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  void _buttonStartPressed() {
    Navigator.pushNamed(context, '/question');
  }

  Widget _buttonsBarStart() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        RaisedButton(
          onPressed: _buttonStartPressed,
          child: Text('Start'),
        )
      ],
    );
  }

  Widget _createBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buttonsBarStart(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var body = _createBody();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body,
    );
  }
}
