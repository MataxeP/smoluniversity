import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/lesson_model.dart';

class LessonsService {
  final lessonCollection = FirebaseFirestore.instance
      .collection('timetable')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('lessons');

  void addNewTask(LessonModel model) {
    lessonCollection.add(model.toMap());
  }

  void deleteTask(String? docID) {
    lessonCollection.doc(docID).delete();
  }
}
