import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smilemeter/survey.dart';
import 'package:smilemeter/survey.page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SmileMeter')),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('surveys').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildListView(snapshot, context);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: _buildDialog,
          );
        },
      ),
    );
  }

  Widget _buildDialog(context) {
    final TextEditingController _textController = TextEditingController();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Give a name to the survey!',
              style: Theme.of(context).textTheme.title,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    final name = _textController.text;
                    Firestore.instance
                        .collection('surveys')
                        .add({'name': name, 'votes': []});
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  final emoticons = [
    '',
    '😫',
    '☹',
    '😐',
    '🙂',
    '😄',
  ];

  ListView _buildListView(
      AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    return ListView(
      children: snapshot.data.documents
          .map((doc) => Survey.fromSnapshot(doc))
          .map((survey) => ListTile(
                title: Text(survey.name),
                trailing: Text('${survey.average.toStringAsFixed(2)} ${emoticons[survey.average.round()]}'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SurveyPage(survey: survey);
                  }));
                },
              ))
          .toList(),
    );
  }
}
