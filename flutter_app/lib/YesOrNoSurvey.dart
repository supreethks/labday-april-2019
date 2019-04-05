import 'package:flutter/material.dart';
import 'package:flutter_app/Styles.dart';
import 'package:flutter_app/main.dart';

class YesOrNoSurvey extends ThumbsUpDownSurvey {
  final String yesLabel;
  final String noLabel;

  YesOrNoSurvey(String question, this.yesLabel, this.noLabel) : super(question);

  bool answer;
}

class YesOrNoSurveyWidget extends StatefulWidget {
  final YesOrNoSurvey survey;

  YesOrNoSurveyWidget({Key key, @required this.survey}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _YesOrNoSurveyState();
  }
}

class _YesOrNoSurveyState extends State<YesOrNoSurveyWidget> {
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
                RaisedButton(
                    child: Text(widget.survey.yesLabel),
                    onPressed: () {
                      widget.survey.answer = true;
                      navigateToNextSurvey(context, widget.survey);
                    }),
                Spacer(),
                RaisedButton(
                    child: Text(widget.survey.noLabel),
                    onPressed: () {
                      widget.survey.answer = false;
                      navigateToNextSurvey(context, widget.survey);
                    }),
                Spacer()
              ],
            ))
      ],
    );
  }
}

class YesOrNoSurveyAnswerWidget extends StatelessWidget {
  final YesOrNoSurvey survey;

  const YesOrNoSurveyAnswerWidget({Key key, this.survey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Text(survey.question, style: TextStyle(fontSize: 20)),
        new Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: new Text(survey.answer.toString(),
                style: TextStyle(fontSize: Styles().textSize, color: Theme.of(context).accentColor))),
      ],
    );
  }
}
