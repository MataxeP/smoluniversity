// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smol_university/provider/service_provider.dart';
import 'package:smol_university/screens/components/date_picker_widget.dart';

import '../../services/notification_service.dart';
import '../components/new_lesson_model.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  String _selectedDate = DateFormat("E").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                height: MediaQuery.of(context).size.height * 0.2,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        bottom: 20,
                      ),
                      height: MediaQuery.of(context).size.height * 0.2 - 27,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0C9869),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Ваше расписание",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            builder: (context) => const AddNewLessonModel()),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          height: 54,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 50,
                                color: Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(0.23),
                              ),
                            ],
                          ),
                          child: const Text("+ Добавить занятие",
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DatePicker(DateTime.now(), onDateChange: (date) {
                  setState(() {
                    _selectedDate = DateFormat("E").format(date);
                  });
                },
                    initialSelectedDate: DateTime.now(),
                    height: 100,
                    width: 80,
                    selectedTextColor: Colors.white,
                    selectionColor: const Color(0xFF0C9869)),
              ),
              LessonWidget(date: _selectedDate)
            ]));
  }
}

class LessonWidget extends ConsumerWidget {
  String date;
  LessonWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonData = ref.watch(fetchLessonStreamProvider);
    int count = 0;
    if (lessonData.value != null) {
      count = lessonData.value!.where((e) => e.day == date).toList().length;
    }

    return Container(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15, top: 15),
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: count != 0
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: count,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return lessonData.when(
                        // ignore: avoid_types_as_parameter_names
                        error: (error, StackTrace) =>
                            Center(child: Text(StackTrace.toString())),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        data: (lessonData) {
                          lessonData.sort(
                              (a, b) => a.startTime.compareTo(b.startTime));
                          return GestureDetector(
                            onTap: () {
                              Get.bottomSheet(Container(
                                color: Colors.white,
                                padding: const EdgeInsets.only(top: 4),
                                height:
                                    MediaQuery.of(context).size.height * 0.24,
                                child: Column(children: [
                                  Container(
                                    height: 6,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade300),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      cancelNotification(int.parse(lessonData
                                          .where((e) => e.day == date)
                                          .toList()[index]
                                          .id));
                                      ref
                                          .read(lessonServiceProvider)
                                          .deleteTask(lessonData
                                              .where((e) => e.day == date)
                                              .toList()[index]
                                              .docID);
                                      Get.back();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      height: 55,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Center(
                                          child: Text("Удалить занятие",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      height: 55,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Center(
                                          child: Text("Закрыть",
                                              style: TextStyle(
                                                  color: Colors.black))),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ]),
                              ));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(bottom: 10),
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${DateFormat("HH:mm").format(DateFormat('yyyy-M-dd HH:mm:s.S').parse(lessonData.where((e) => e.day == date).toList()[index].startTime))} - ${DateFormat("HH:mm").format(DateFormat('yyyy-M-dd HH:mm:s.S').parse(lessonData.where((e) => e.day == date).toList()[index].endTime))}",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            decoration: DateFormat(
                                                            "yyyy-M-dd HH:mm:s.S")
                                                        .parse(lessonData
                                                            .where((e) =>
                                                                e.day == date)
                                                            .toList()[index]
                                                            .endTime)
                                                        .isBefore(
                                                            DateTime.now()) &&
                                                    date ==
                                                        DateFormat("E").format(
                                                            DateTime.now())
                                                ? TextDecoration.lineThrough
                                                : null,
                                            fontSize: 15,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Text(
                                        lessonData
                                            .where((e) => e.day == date)
                                            .toList()[index]
                                            .title,
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            decoration: DateFormat(
                                                            "yyyy-M-dd HH:mm:s.S")
                                                        .parse(lessonData
                                                            .where((e) =>
                                                                e.day == date)
                                                            .toList()[index]
                                                            .endTime)
                                                        .isBefore(
                                                            DateTime.now()) &&
                                                    date ==
                                                        DateFormat("E").format(
                                                            DateTime.now())
                                                ? TextDecoration.lineThrough
                                                : null,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Flexible(
                                      child: Text(
                                        lessonData
                                            .where((e) => e.day == date)
                                            .toList()[index]
                                            .teacher,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            decoration: DateFormat(
                                                            "yyyy-M-dd HH:mm:s.S")
                                                        .parse(lessonData
                                                            .where((e) =>
                                                                e.day == date)
                                                            .toList()[index]
                                                            .endTime)
                                                        .isBefore(
                                                            DateTime.now()) &&
                                                    date ==
                                                        DateFormat("E").format(
                                                            DateTime.now())
                                                ? TextDecoration.lineThrough
                                                : null,
                                            fontSize: 15,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "Аудитория ${lessonData.where((e) => e.day == date).toList()[index].location}",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            decoration: DateFormat(
                                                            "yyyy-M-dd HH:mm:s.S")
                                                        .parse(lessonData
                                                            .where((e) =>
                                                                e.day == date)
                                                            .toList()[index]
                                                            .endTime)
                                                        .isBefore(
                                                            DateTime.now()) &&
                                                    date ==
                                                        DateFormat("E").format(
                                                            DateTime.now())
                                                ? TextDecoration.lineThrough
                                                : null,
                                            fontSize: 15,
                                            color: Colors.grey),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        });
                  })
              : Container(
                  padding: const EdgeInsets.all(12),
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        flex: 4,
                        child: Text(
                          "Ну же...",
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Flexible(
                        flex: 4,
                        child: Text(
                          "У вас еще не настроено расписание ваших занятий.",
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ))),
    );
  }
}
