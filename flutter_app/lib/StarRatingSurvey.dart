import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_app/main.dart';

class StarRatingSurvey extends Survey {
  StarRatingSurvey(String question) : super(question);

  int answer = 0;
}

class StarRatingSurveyWidget extends StatefulWidget {
  final StarRatingSurvey survey;

  const StarRatingSurveyWidget({Key key, this.survey}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StarRatingSurveyState();
  }
}

class _StarRatingSurveyState extends State<StarRatingSurveyWidget> {
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
            child: SmoothStarRating(
              allowHalfRating: false,
              rating: widget.survey.answer.toDouble(),
              size: 60,
              onRatingChanged: (double v) async {
                setState(() {
                  widget.survey.answer = v.floor();
                });
                await new Future.delayed(const Duration(seconds: 1));
                navigateToNextSurvey(context, widget.survey);
              },
            ))
      ],
    );
  }
}

class StarRatingAnswerWidget extends StatelessWidget{
  final StarRatingSurvey survey;

  const StarRatingAnswerWidget({Key key, this.survey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Text(survey.question, style: TextStyle(fontSize: 20)),
        Padding(
          padding: EdgeInsets.only(bottom: 30, top: 10),
          child: SmoothStarRating(
            size: 30,
            rating: survey.answer.toDouble(),
          ),
        )
      ],
    );
  }
}
