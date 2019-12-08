import 'package:flutter/material.dart';
import 'package:smilemeter/survey.dart';
import 'dart:math';

class SurveyPage extends StatelessWidget {
  final Survey survey;

  const SurveyPage({Key key, this.survey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(textTheme: TextTheme(button: TextStyle(fontSize: 40))),
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MaterialButton(
              child: Transform.rotate(
                angle: pi / 2,
                child: Text('😫'),
              ),
              onPressed: () => vote(-2),
            ),
            MaterialButton(
              child: Transform.rotate(
                angle: pi / 2,
                child: Text('☹'),
              ),
              onPressed: () => vote(-1),
            ),
            MaterialButton(
              child: Transform.rotate(
                angle: pi / 2,
                child: Text('😐'),
              ),
              onPressed: () => vote(0),
            ),
            MaterialButton(
              child: Transform.rotate(
                angle: pi / 2,
                child: Text('🙂'),
              ),
              onPressed: () => vote(1),
            ),
            MaterialButton(
              child: Transform.rotate(
                angle: pi / 2,
                child: Text('😄'),
              ),
              onPressed: () => vote(2),
            ),
          ],
        ),
      ),
    );
  }

  vote(int value) {
    this.survey.votes.add(value);
    this.survey.reference.updateData({'votes': this.survey.votes});
  }
}