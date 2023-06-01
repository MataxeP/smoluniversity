import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smol_university/model/todo_model.dart';
import 'package:smol_university/services/todo_service.dart';

import '../model/lesson_model.dart';
import '../services/lesson_service.dart';

final todoServiceProvider = StateProvider<TodoService>((ref) {
  return TodoService();
});

final fetchToDoStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('todoApp')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('mytasks')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => TodoModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});

final lessonServiceProvider = StateProvider<LessonsService>((ref) {
  return LessonsService();
});

final fetchLessonStreamProvider =
    StreamProvider<List<LessonModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('timetable')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('lessons')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => LessonModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});
