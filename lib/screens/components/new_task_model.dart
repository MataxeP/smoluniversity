// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smol_university/model/todo_model.dart';
import 'package:smol_university/provider/radio_provider.dart';
import 'package:smol_university/provider/service_provider.dart';

import '../../provider/date_time_provider.dart';
import '../../services/notification_service.dart';

final titleController = TextEditingController();
final descController = TextEditingController();

class AddNewTaskModel extends ConsumerWidget {
  AddNewTaskModel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioCategory = ref.watch(radioProvider);
    final dateProv = ref.watch(dateProvider);
    final timeProv = ref.watch(timeProvider);

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
                  child: Text("Новая заметка",
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
              Text("Описание",
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
                      controller: descController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Введите описание"))),
              const Gap(12),
              Text("Категория",
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
                          child: Text("УЧЕБА",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700))),
                    ),
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.blue.shade700),
                        child: Radio(
                          value: 2,
                          groupValue: radioCategory,
                          activeColor: Colors.blue.shade700,
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
                              unselectedWidgetColor: Colors.blue.shade700),
                          child: Text("РАБОТА",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue.shade700))),
                    ),
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.amberAccent.shade700),
                        child: Radio(
                          value: 3,
                          groupValue: radioCategory,
                          activeColor: Colors.amberAccent.shade700,
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
                              unselectedWidgetColor:
                                  Colors.amberAccent.shade700),
                          child: Text("ЛИЧНОЕ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.amberAccent.shade700))),
                    )
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
                        Text("Дата",
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
                                final getValue = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 1825)));
                                if (getValue != null) {
                                  final format = DateFormat('dd/M/yyyy');
                                  ref.read(dateProvider.notifier).update(
                                      (state) => format.format(getValue));
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
                                  const Icon(CupertinoIcons.calendar),
                                  const Gap(6),
                                  Text(dateProv)
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
                        Text("Время",
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
                                          .parse(timeProv)))
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
                            ref
                                .read(radioProvider.notifier)
                                .update((state) => 1);
                            ref.read(dateProvider.notifier).update((state) =>
                                DateFormat("dd/mm/yyyy")
                                    .format(DateTime.now()));
                            ref.read(timeProvider.notifier).update((state) =>
                                DateFormat("yyyy-M-dd HH:mm:s.S")
                                    .format(DateTime.now()));
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
                            final getRadioValue = ref.read(radioProvider);
                            String category = '';
                            switch (getRadioValue) {
                              case 1:
                                category = 'Учеба';
                                break;
                              case 2:
                                category = 'Работа';
                                break;
                              case 3:
                                category = 'Личное';
                                break;
                            }
                            final title = titleController.text;
                            final description = descController.text;
                            final date = ref.read(dateProvider);
                            final time = ref.read(timeProvider);
                            final id = Random().nextInt(3000000);

                            if (title != "" &&
                                description != "" &&
                                category != "") {
                              ref.read(todoServiceProvider).addNewTask(
                                  TodoModel(
                                      id: id.toString(),
                                      title: title,
                                      description: description,
                                      category: category,
                                      date: date,
                                      time: time,
                                      isDone: false));

                              createNoteRemindedNotification(
                                  id,
                                  title,
                                  description,
                                  DateFormat("yyyy-M-dd HH:mm:s.S")
                                      .parse(time)
                                      .hour,
                                  DateFormat("dd/M/yyyy").parse(date).year,
                                  DateFormat("dd/M/yyyy").parse(date).month,
                                  DateFormat("dd/M/yyyy").parse(date).day,
                                  DateFormat("yyyy-M-dd HH:mm:s.S")
                                      .parse(time)
                                      .minute);

                              titleController.clear();
                              descController.clear();
                              ref
                                  .read(radioProvider.notifier)
                                  .update((state) => 1);
                              ref.read(dateProvider.notifier).update((state) =>
                                  DateFormat("dd/mm/yyyy")
                                      .format(DateTime.now()));
                              ref.read(timeProvider.notifier).update((state) =>
                                  DateFormat("yyyy-M-dd HH:mm:s.S")
                                      .format(DateTime.now()));
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
