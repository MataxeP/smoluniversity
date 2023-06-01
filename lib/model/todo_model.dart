import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docID;
  final String title;
  final String id;
  final String description;
  final String category;
  final String date;
  final String time;
  final bool isDone;

  TodoModel({
    this.docID,
    required this.title,
    required this.id,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'time': time,
      'isDone': isDone,
      'id': id,
      'docID': docID
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      title: map['title'] as String,
      description: map['desciption'] as String,
      category: map['category'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      id: map['id'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
      docID: doc.id,
      id: doc['id'],
      title: doc['title'],
      description: doc['description'],
      category: doc['category'],
      date: doc['date'],
      time: doc['time'],
      isDone: doc['isDone'],
    );
  }
}
