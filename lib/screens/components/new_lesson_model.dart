import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smol_university/model/lesson_model.dart';
import 'package:smol_university/provider/service_provider.dart';

import '../../provider/date_time_provider.dart';
import '../../provider/radio_provider.dart';
import '../../services/notification_service.dart';

final titleController = TextEditingController();
final locationController = TextEditingController();
final teacherController = TextEditingController();

class AddNewLessonModel extends ConsumerWidget {
  const AddNewLessonModel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioCategory = ref.watch(radioProvider);
    final startTimeProv = ref.watch(timeProvider);
    final endTimeProv = ref.watch(endTimeProvider);

    return Container(
        padding: const EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height * 0.80,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Text("Новое занятие",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary))),
              Divider(thickness: 1.2, color: Colors.grey.shade200),
              const Gap(12),
              Text("Название",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary)),
              const Gap(6),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Введите название",
                          hintStyle: GoogleFonts.poppins()))),
              const Gap(12),
              Text("Аудитория",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary)),
              const Gap(6),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Введите номер аудитории"))),
              const Gap(12),
              Text("Преподаватель",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary)),
              const Gap(6),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                      controller: teacherController,
                      decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Введите имя преподавателя"))),
              const Gap(12),
              Text("День недели",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.green.shade700),
                        child: Radio(
                          value: 1,
                          groupValue: radioCategory,
                          activeColor: Colors.green.shade700,
                          onChanged: (value) {
                            ref
                                .read(radioProvider.notifier)
                                .update((state) => 1);
                          },
                        )),
                    GestureDetector(
                      onTap: () {
                        ref.read(radioProvider.notifier).update((state) => 1);
                      },
                      child: Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Colors.green.shade700),
                          child: Text("ПН",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700))),
                    ),
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.green.shade700),
                        child: Radio(
                          value: 2,
                          groupValue: radioCategory,
                          activeColor: Colors.green.shade700,
                          onChanged: (value) {
                            ref
                                .read(radioProvider.notifier)
                                .update((state) => 2);
                          },
                        )),
                    GestureDetector(
                      onTap: () {
                        ref.read(radioProvider.notifier).update((state) => 2);
                      },
                      child: Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Colors.green.shade700),
                          child: Text("ВТ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700))),
                    ),
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.green.shade700),
                        child: Radio(
                          value: 3,
                          groupValue: radioCategory,
                          activeColor: Colors.green.shade700,
                          onChanged: (value) {
                            ref
                                .read(radioProvider.notifier)
                                .update((state) => 3);
                          },
                        )),
                    GestureDetector(
                      onTap: () {
                        ref.read(radioProvider.notifier).update((state) => 3);
                      },
                      child: Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Colors.green.shade700),
                          child: Text("СР",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700))),
                    ),
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.green.shade700),
                        child: Radio(
                          value: 4,
                          groupValue: radioCategory,
                          activeColor: Colors.green.shade700,
                          onChanged: (value) {
                            ref
                                .read(radioProvider.notifier)
                                .update((state) => 4);
                          },
                        )),
                    GestureDetector(
                      onTap: () {
                        ref.read(radioProvider.notifier).update((state) => 4);
                      },
                      child: Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Colors.green.shade700),
                          child: Text("ЧТ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700))),
                    ),
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.green.shade700),
                        child: Radio(
                          value: 5,
                          groupValue: radioCategory,
                          activeColor: Colors.green.shade700,
                          onChanged: (value) {
                            ref
                                .read(radioProvider.notifier)
                                .update((state) => 5);
                          },
                        )),
                    GestureDetector(
                      onTap: () {
                        ref.read(radioProvider.notifier).update((state) => 5);
                      },
                      child: Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Colors.green.shade700),
                          child: Text("ПТ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700))),
                    ),
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.green.shade700),
                        child: Radio(
                          value: 6,
                          groupValue: radioCategory,
                          activeColor: Colors.green.shade700,
                          onChanged: (value) {
                            ref
                                .read(radioProvider.notifier)
                                .update((state) => 6);
                          },
                        )),
                    GestureDetector(
                      onTap: () {
                        ref.read(radioProvider.notifier).update((state) => 6);
                      },
                      child: Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Colors.green.shade700),
                          child: Text("СБ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700))),
                    ),
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.green.shade700),
                        child: Radio(
                          value: 7,
                          groupValue: radioCategory,
                          activeColor: Colors.green.shade700,
                          onChanged: (value) {
                            ref
                                .read(radioProvider.notifier)
                                .update((state) => 7);
                          },
                        )),
                    GestureDetector(
                      onTap: () {
                        ref.read(radioProvider.notifier).update((state) => 7);
                      },
                      child: Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Colors.green.shade700),
                          child: Text("ВС",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700))),
                    ),
                  ],
                ),
              ),
              const Gap(6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Время начала",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.primary)),
                        const Gap(6),
                        Material(
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () async {
                                final getTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: childWidget!);
                                    });
                                if (getTime != null) {
                                  ref.read(timeProvider.notifier).update(
                                      (state) =>
                                          DateFormat('yyyy-M-dd HH:mm:s.S')
                                              .format(DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month,
                                                  DateTime.now().day,
                                                  getTime.hour,
                                                  getTime.minute)));
                                }
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(children: [
                                  const Icon(CupertinoIcons.clock),
                                  const Gap(6),
                                  Text(DateFormat("HH:mm").format(
                                      DateFormat('yyyy-M-dd HH:mm:s.S')
                                          .parse(startTimeProv)))
                                ]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(22),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Время окончания",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.primary)),
                        const Gap(6),
                        Material(
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () async {
                                final getTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: childWidget!);
                                    });
                                if (getTime != null) {
                                  ref.read(endTimeProvider.notifier).update(
                                      (state) =>
                                          DateFormat('yyyy-M-dd HH:mm:s.S')
                                              .format(DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month,
                                                  DateTime.now().day,
                                                  getTime.hour,
                                                  getTime.minute)));
                                }
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(children: [
                                  const Icon(CupertinoIcons.clock),
                                  const Gap(6),
                                  Text(DateFormat("HH:mm").format(
                                      DateFormat('yyyy-M-dd HH:mm:s.S')
                                          .parse(endTimeProv)))
                                ]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(12),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            ref.read(timeProvider.notifier).update((state) =>
                                DateFormat("yyyy-M-dd HH:mm:s.S")
                                    .format(DateTime.now()));
                            ref.read(endTimeProvider.notifier).update((state) =>
                                DateFormat("yyyy-M-dd HH:mm:s.S")
                                    .format(DateTime.now()));
                            ref
                                .read(radioProvider.notifier)
                                .update((state) => 1);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              foregroundColor: Colors.green.shade800,
                              elevation: 0,
                              side: BorderSide(color: Colors.green.shade800),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: const Text("Отмена"))),
                  const Gap(20),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            int selectedDay = ref.read(radioProvider);
                            String day = "Mon";
                            switch (selectedDay) {
                              case 1:
                                day = "Mon";
                              case 2:
                                day = "Tue";
                              case 3:
                                day = "Wed";
                              case 4:
                                day = "Thu";
                              case 5:
                                day = "Fri";
                              case 6:
                                day = "Sat";
                              case 7:
                                day = "Sun";
                            }
                            final title = titleController.text;
                            final location = locationController.text;
                            final teacher = teacherController.text;
                            final startTime = ref.read(timeProvider);
                            final endTime = ref.read(endTimeProvider);
                            final id = Random().nextInt(3000000);

                            if (title != "" &&
                                location != "" &&
                                teacher != "" &&
                                day != "" &&
                                startTime != "HH:mm" &&
                                endTime != "HH:mm") {
                              ref.read(lessonServiceProvider).addNewTask(
                                  LessonModel(
                                      id: (4000000 + id).toString(),
                                      title: title,
                                      location: location,
                                      endTime: endTime,
                                      startTime: startTime,
                                      teacher: teacher,
                                      day: day));

                              createLessonRemindedNotification(
                                4000000 + id,
                                title,
                                selectedDay,
                                DateFormat("yyyy-M-dd HH:mm:s.S")
                                    .parse(startTime)
                                    .subtract(const Duration(minutes: 20))
                                    .hour,
                                DateFormat("yyyy-M-dd HH:mm:s.S")
                                    .parse(startTime)
                                    .subtract(const Duration(minutes: 20))
                                    .minute,
                              );

                              titleController.clear();
                              locationController.clear();
                              teacherController.clear();

                              ref.read(timeProvider.notifier).update((state) =>
                                  DateFormat("yyyy-M-dd HH:mm:s.S")
                                      .format(DateTime.now()));
                              ref.read(endTimeProvider.notifier).update(
                                  (state) => DateFormat("yyyy-M-dd HH:mm:s.S")
                                      .format(DateTime.now()));
                              ref
                                  .read(radioProvider.notifier)
                                  .update((state) => 1);
                              Navigator.pop(context);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                        backgroundColor: Colors.deepPurple,
                                        title: Center(
                                            child: Text(
                                                "Все поля должны быть заполнены!",
                                                style: TextStyle(
                                                    color: Colors.white))));
                                  });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.green.shade800,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              side: BorderSide(color: Colors.green.shade800),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: const Text("Добавить"))),
                ],
              )
            ],
          ),
        ));
  }
}
