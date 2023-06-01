import 'package:cloud_firestore/cloud_firestore.dart';

class LessonModel {
  String? docID;
  final String id;
  final String title;
  final String location;
  final String startTime;
  final String endTime;
  final String teacher;
  final String day;

  LessonModel(
      {this.docID,
      required this.id,
      required this.title,
      required this.location,
      required this.startTime,
      required this.endTime,
      required this.teacher,
      required this.day});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      'location': location,
      'startTime': startTime,
      'endTime': endTime,
      'teacher': teacher,
      'day': day,
      'docID': docID
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      id: map['id'] as String,
      title: map['title'] as String,
      location: map['location'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      teacher: map['teacher'] as String,
      day: map['day'] as String,
    );
  }

  factory LessonModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return LessonModel(
      docID: doc.id,
      id: doc['id'],
      title: doc['title'],
      location: doc['location'],
      startTime: doc['startTime'],
      endTime: doc['endTime'],
      teacher: doc['teacher'],
      day: doc['day'],
    );
  }
}
