import 'package:flutter/material.dart';
import 'package:flutter_app/FreeFormSurvey.dart';
import 'package:flutter_app/StarRatingSurvey.dart';
import 'package:flutter_app/Styles.dart';
import 'package:flutter_app/YesOrNoSurvey.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Survey Baboon',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
//      home: new MyHomePage(title: 'Survey Baboon'),
      home: new SurveyListPage(),
    );
  }
}

final List<String> surveyTypes = [
  "Thumbs up down",
  "Yes or No",
  "Single Choice",
  "Multiple Choice",
  "Star Rating 1-5",
  "Free Form",
//  "Promoter Score Rating",
//  "Happy Sad Meter",
//  "Matrix of choices",
];

int currentPage = 0;
Set<Survey> answers = {};

void navigateToNextSurvey(BuildContext context, Survey survey) {
  answers.remove(survey);
  answers.add(survey);
  if (++currentPage == surveyTypes.length) {
    currentPage = 0;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AnswersPage(answers: answers.toList(growable: false))));
    return;
  }
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SurveyDetailPage(selectedSurveyType: surveyTypes[currentPage])));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _textToShow = "This is awesome";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    _setText();
  }

  void _setText() {
    setState(() {
      _textToShow = _counter % 2 == 0 ? "Number is even" : "Number is odd";
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              _textToShow,
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SurveyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Survey Baboon"),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: surveyTypes.length,
            itemBuilder: (BuildContext context, int position) {
              return Padding (
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: getRow(context, position)
              );
            }));
  }

  Widget getRow(BuildContext context, int position) {
    return GestureDetector(
        child: RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: new Text(surveyTypes[position], style: TextStyle(fontSize: 18)),
      onPressed: () {
        currentPage = position;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SurveyDetailPage(
                    selectedSurveyType: surveyTypes[position])));
      },
    ));
  }
}

class SurveyDetailPage extends StatelessWidget {
  final String selectedSurveyType;

  SurveyDetailPage({Key key, @required this.selectedSurveyType})
      : super(key: key);

  final Map<String, Widget> surveyMapping = {
    surveyTypes[0]: ThumbsUpDownSurveyWidget(
        survey:
            ThumbsUpDownSurvey("Are you enjoying your premium subscription?")),
    surveyTypes[1]: YesOrNoSurveyWidget(
        survey: YesOrNoSurvey(
            "Did you know you can pay mobile bills using Truecaller?",
            "Yes",
            "No")),
    surveyTypes[2]: SingleChoiceSurveyWidget(
      survey: SingleChoiceSurvey("How many spam calls do you get in a week?", [
        "None at all",
        "Just 1 or 2",
        "Not more than one per day",
        "About 10",
        "More than 20",
        "I don't know"
      ]),
    ),
    surveyTypes[3]: MultipleChoiceSurveyWidget(
      survey: MultipleChoiceSurvey(
          "What do you think Truecaller helps you to do?", [
        "Block Spammers",
        "See who is calling",
        "Take Photo",
        "Send money",
        "Pay bills",
        "Play games"
      ]),
    ),
    surveyTypes[4]: StarRatingSurveyWidget(
        survey: StarRatingSurvey(
            "How do rate your experience with call recording?")),
    surveyTypes[5]: FreeFormSurveyWidget(
      survey:
          FreeFormSurvey("Tell us what can make you pay to be a premium user?"),
    )
  };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(selectedSurveyType),
        ),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(child: surveyMapping[selectedSurveyType]),
              ],
            )));
  }
}

class AnswersPage extends StatelessWidget {
  final List<Survey> answers;

  const AnswersPage({Key key, this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Surveys Answers"),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: answers.length,
            itemBuilder: (BuildContext context, int position) {
              return getRow(context, position);
            }));
  }

  Widget getRow(BuildContext context, int position) {
    return AnswerWidgetProvider.widgetForAnswer(context, answers[position]);
  }
}

class AnswerWidgetProvider {
  static Widget widgetForAnswer(BuildContext context, Survey survey) {
    if (survey.runtimeType == ThumbsUpDownSurvey) {
      return new Column(
        children: <Widget>[
          new Text(survey.question, style: TextStyle(fontSize: 20)),
          new Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: new Text((survey as ThumbsUpDownSurvey).answer.toString(),
                  style: TextStyle(fontSize: Styles().textSize, color: Theme.of(context).accentColor))),
        ],
      );
    }

    if(survey.runtimeType == YesOrNoSurvey) {
       return YesOrNoSurveyAnswerWidget(survey: survey);
    }

    if (survey is SingleChoiceSurvey) {
      return new Column(
        children: <Widget>[
          Text(survey.question, style: TextStyle(fontSize: 20)),
          Padding(
            padding: EdgeInsets.only(bottom: 30, top: 10),
            child: Text(survey.answer,
                style: TextStyle(fontSize: Styles().textSize, color: Theme.of(context).accentColor)),
          )
        ],
      );
    }

    if (survey is MultipleChoiceSurvey) {
      List<Widget> widgets = [];
      widgets.add(Text(survey.question, style: TextStyle(fontSize: 20)));
      survey.answer.forEach((String answer) {
        widgets.add(
            Text(answer, style: TextStyle(fontSize: Styles().textSize, color: Theme.of(context).accentColor)));
      });
      return new Column(
        children: widgets,
      );
    }

    if (survey is StarRatingSurvey) {
      return StarRatingAnswerWidget(survey: survey);
    }

    if (survey is FreeFormSurvey) {
      return FreeFormAnswerWidget(survey: survey);
    }

    return new Column(
      children: <Widget>[new Text("Not implemented")],
    );
  }
}

abstract class Survey {
  @protected
  String type;
  final String question;

  Survey(this.question);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Survey &&
          runtimeType == other.runtimeType &&
          question == other.question;

  @override
  int get hashCode => question.hashCode;
}

abstract class SurveyWidget extends StatefulWidget {}

class ThumbsUpDownSurvey extends Survey {
  ThumbsUpDownSurvey(String question) : super(question);

  bool answer;
}

class ThumbsUpDownSurveyWidget extends StatefulWidget {
  final ThumbsUpDownSurvey survey;

  ThumbsUpDownSurveyWidget({Key key, @required this.survey}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ThumbsUpDownSurveyState();
  }
}

class _ThumbsUpDownSurveyState extends State<ThumbsUpDownSurveyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          widget.survey.question,
          style: TextStyle(fontSize: 20),
        ),
        new Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                GestureDetector(
                  child: Image.asset('assets/images/thumbs_down.png'),
                  onTap: () {
                    widget.survey.answer = false;
                    navigateToNextSurvey(context, widget.survey);
                  },
                ),
                Spacer(),
                GestureDetector(
                  child: Image.asset('assets/images/thumbs_up.png'),
                  onTap: () {
                    widget.survey.answer = true;
                    navigateToNextSurvey(context, widget.survey);
                  },
                ),
                Spacer()
              ],
            ))
      ],
    );
  }
}

class SingleChoiceSurvey extends Survey {
  final List<String> choices;

  SingleChoiceSurvey(String question, this.choices) : super(question);

  String answer;
}

class SingleChoiceSurveyWidget extends StatefulWidget {
  final SingleChoiceSurvey survey;

  const SingleChoiceSurveyWidget({Key key, this.survey}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SingleChoiceSurveyState();
  }
}

class _SingleChoiceSurveyState extends State<SingleChoiceSurveyWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20),
          child: Text(widget.survey.question, style: TextStyle(fontSize: 20))),
    ];
    widgets.addAll(getChoicesWidgets(widget.survey));
    widgets.add(Container(
        alignment: AlignmentDirectional.centerEnd,
        child: RaisedButton(
            child: Text("Done"),
            onPressed: () {
              navigateToNextSurvey(context, widget.survey);
            })));
    return Column(
        mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }

  List<Widget> getChoicesWidgets(SingleChoiceSurvey survey) {
    return List.generate(survey.choices.length, (position) {
      return new RadioListTile(
          title: Text(survey.choices[position]),
          value: survey.choices[position],
          groupValue: survey.answer,
          onChanged: (String choice) {
            setState(() {
              survey.answer = choice;
            });
          });
    });
  }
}

class MultipleChoiceSurvey extends Survey {
  final List<String> choices;

  MultipleChoiceSurvey(String question, this.choices) : super(question);

  List<String> answer = [];
}

class MultipleChoiceSurveyWidget extends StatefulWidget {
  final MultipleChoiceSurvey survey;

  const MultipleChoiceSurveyWidget({Key key, this.survey}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MutlipleChoiceSurveyState();
  }
}

class _MutlipleChoiceSurveyState extends State<MultipleChoiceSurveyWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20),
          child: Text(widget.survey.question, style: TextStyle(fontSize: 20))),
    ];
    widgets.addAll(getChoicesWidgets(widget.survey));
    widgets.add(Container(
        alignment: AlignmentDirectional.centerEnd,
        child: RaisedButton(
            child: Text("Done"),
            onPressed: () {
              navigateToNextSurvey(context, widget.survey);
            })));
    return Column(
        mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }

  List<Widget> getChoicesWidgets(MultipleChoiceSurvey survey) {
    return List.generate(survey.choices.length, (position) {
      return CheckboxListTile(
          title: Text(survey.choices[position]),
          controlAffinity: ListTileControlAffinity.leading,
          value: survey.answer.contains(survey.choices[position]),
          onChanged: (bool checked) {
            setState(() {
              checked
                  ? survey.answer.add(survey.choices[position])
                  : survey.answer.remove(survey.choices[position]);
            });
          });
    });
  }
}

class PromoterScoreSurvey extends Survey {
  PromoterScoreSurvey(String question) : super(question);

  int answer;
}

class HappySadMeterSurvey extends Survey {
  HappySadMeterSurvey(String question) : super(question);

  int answer;
}

class MatrixOfChoicesSurvey extends Survey {
  final List<String> rows;
  final List<String> optionColumns;

  MatrixOfChoicesSurvey(String question, this.rows, this.optionColumns)
      : super(question);
  Map<String, String> answer;
}