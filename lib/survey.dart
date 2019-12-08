import 'package:cloud_firestore/cloud_firestore.dart';

class  Survey {
  String name;
  List<int> votes;
  final DocumentReference reference;

  Survey({this.name, this.votes, this.reference});

  Survey.fromJson(Map<String, dynamic> json, {this.reference}) {
    name = json['name'];
    votes = List.from(json['votes'] != null ? json['votes'].cast<int>() : []);
  }

  Survey.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromJson(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['votes'] = this.votes;
    return data;
  }

  double get average => this.votes.length == 0 ? 0 : this.votes.reduce((a, b) => a + b) / this.votes.length;
}