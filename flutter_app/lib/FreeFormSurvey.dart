import 'package:flutter/material.dart';
import 'package:flutter_app/Styles.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_app/main.dart';

class FreeFormSurvey extends Survey {
  FreeFormSurvey(String question) : super(question);

  String answer = "";
}

class FreeFormSurveyWidget extends StatefulWidget {
  final FreeFormSurvey survey;

  const FreeFormSurveyWidget({Key key, this.survey}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FreeFormSurveyState();
  }
}

class _FreeFormSurveyState extends State<FreeFormSurveyWidget> {
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
            child: TextField(
              onChanged: (String formText) {
                setState(() {
                  widget.survey.answer = formText;
                });
              },
            )),
        RaisedButton(
            child: Text("Done"),
            onPressed: () {
              navigateToNextSurvey(context, widget.survey);
            })
      ],
    );
  }
}

class FreeFormAnswerWidget extends StatelessWidget{
  final FreeFormSurvey survey;

  const FreeFormAnswerWidget({Key key, this.survey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Text(survey.question, style: TextStyle(fontSize: 20)),
        Padding(
          padding: EdgeInsets.only(bottom: 30, top: 10),
          child: Text(survey.answer, style: TextStyle(fontSize: Styles().textSize, color: Theme.of(context).accentColor)),
        )
      ],
    );
  }
}
