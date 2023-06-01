// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smol_university/screens/components/time_say.dart';
import '../../provider/service_provider.dart';

class HomePage extends ConsumerWidget {
  final Function? changePage;
  const HomePage(this.changePage, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchToDoStreamProvider);
    final lessonData = ref.watch(fetchLessonStreamProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderWithSearchBox(size: MediaQuery.of(context).size),
            TitleWithMoreBtn(
                title: "Расписание",
                press: () {
                  changePage!(1);
                }),
            GestureDetector(
              onTap: () {
                changePage!(1);
              },
              child: Container(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 15, top: 6),
                  child: SizedBox(
                      height: 230,
                      child: lessonData.value != null
                          ? lessonData.value!
                                  .where((e) =>
                                      e.day ==
                                      DateFormat("E").format(DateTime.now()))
                                  .toList()
                                  .isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: lessonData.value!
                                      .where((e) =>
                                          e.day ==
                                          DateFormat("E")
                                              .format(DateTime.now()))
                                      .toList()
                                      .length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return lessonData.when(
                                        // ignore: avoid_types_as_parameter_names
                                        error: (error, StackTrace) => Center(
                                            child: Text(StackTrace.toString())),
                                        loading: () => const Center(
                                            child: CircularProgressIndicator()),
                                        data: (lessonData) {
                                          lessonData.sort((a, b) => a.startTime
                                              .compareTo(b.startTime));
                                          return Container(
                                              padding: const EdgeInsets.all(20),
                                              margin:
                                                  const EdgeInsets.only(right: 20),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              decoration: BoxDecoration(
                                                  color: Colors.green
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      "${DateFormat("HH:mm").format(DateFormat('yyyy-M-dd h:m:s.S').parse(lessonData
                                                              .where((e) =>
                                                                  e.day ==
                                                                  DateFormat("E")
                                                                      .format(DateTime
                                                                          .now()))
                                                              .toList()[index]
                                                              .startTime))} - ${DateFormat("HH:mm").format(DateFormat(
                                                                  'yyyy-M-dd h:m:s.S')
                                                              .parse(lessonData
                                                                  .where((e) => e.day == DateFormat("E").format(DateTime.now()))
                                                                  .toList()[index]
                                                                  .endTime))}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          decoration: DateFormat(
                                                                      "yyyy-M-dd HH:mm:s.S")
                                                                  .parse(lessonData
                                                                      .where((e) =>
                                                                          e.day ==
                                                                          DateFormat("E").format(DateTime
                                                                              .now()))
                                                                      .toList()[
                                                                          index]
                                                                      .endTime)
                                                                  .isBefore(
                                                                      DateTime
                                                                          .now())
                                                              ? TextDecoration
                                                                  .lineThrough
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
                                                          .where((e) =>
                                                              e.day ==
                                                              DateFormat("E")
                                                                  .format(DateTime
                                                                      .now()))
                                                          .toList()[index]
                                                          .title,
                                                      maxLines: 3,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          decoration: DateFormat(
                                                                      "yyyy-M-dd HH:mm:s.S")
                                                                  .parse(lessonData
                                                                      .where((e) =>
                                                                          e.day ==
                                                                          DateFormat("E").format(DateTime
                                                                              .now()))
                                                                      .toList()[
                                                                          index]
                                                                      .endTime)
                                                                  .isBefore(
                                                                      DateTime
                                                                          .now())
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : null,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      lessonData
                                                          .where((e) =>
                                                              e.day ==
                                                              DateFormat("E")
                                                                  .format(DateTime
                                                                      .now()))
                                                          .toList()[index]
                                                          .teacher,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          decoration: DateFormat(
                                                                      "yyyy-M-dd HH:mm:s.S")
                                                                  .parse(lessonData
                                                                      .where((e) =>
                                                                          e.day ==
                                                                          DateFormat("E").format(DateTime
                                                                              .now()))
                                                                      .toList()[
                                                                          index]
                                                                      .endTime)
                                                                  .isBefore(
                                                                      DateTime
                                                                          .now())
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : null,
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      "Аудитория ${lessonData
                                                              .where((e) =>
                                                                  e.day ==
                                                                  DateFormat(
                                                                          "E")
                                                                      .format(DateTime
                                                                          .now()))
                                                              .toList()[index]
                                                              .location}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          decoration: DateFormat(
                                                                      "yyyy-M-dd HH:mm:s.S")
                                                                  .parse(lessonData
                                                                      .where((e) =>
                                                                          e.day ==
                                                                          DateFormat("E").format(DateTime
                                                                              .now()))
                                                                      .toList()[
                                                                          index]
                                                                      .endTime)
                                                                  .isBefore(
                                                                      DateTime
                                                                          .now())
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : null,
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  )
                                                ],
                                              ));
                                        });
                                  })
                              : Container(
                                  padding: const EdgeInsets.all(12),
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
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
                                              fontSize: 15,
                                              color: Colors.grey.shade700),
                                        ),
                                      ),
                                    ],
                                  ))
                          : Container(
                              padding: const EdgeInsets.all(12),
                              width: MediaQuery.of(context).size.width - 40,
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ],
                              )))),
            ),
            TitleWithMoreBtn(
                title: "Заметки",
                press: () {
                  changePage!(2);
                }),
            GestureDetector(
              onTap: () {
                changePage!(2);
              },
              child: Container(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 15, top: 6),
                  child: SizedBox(
                      height: 230,
                      child: todoData.value != null
                          ? todoData.value!
                                  .where((e) => e.isDone == false)
                                  .toList()
                                  .where((e) => DateFormat("dd/M/yyyy")
                                      .parse(e.date)
                                      .isAfter(DateTime.now()))
                                  .toList()
                                  .isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: todoData.value!
                                      .where((e) => e.isDone == false)
                                      .toList()
                                      .where((e) => DateFormat("dd/M/yyyy")
                                          .parse(e.date)
                                          .isAfter(DateTime.now()))
                                      .toList()
                                      .length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return todoData.when(
                                        error: (error, StackTrace) => Center(
                                            child: Text(StackTrace.toString())),
                                        loading: () => const Center(
                                            child: CircularProgressIndicator()),
                                        data: (todoData) {
                                          todoData.sort((a, b) =>
                                              a.date.compareTo(b.date));
                                          todoData.sort((a, b) =>
                                              a.time.compareTo(b.time));
                                          Color categoryColor = Colors.white;
                                          final getCategory = todoData
                                              .where((e) => e.isDone == false)
                                              .toList()
                                              .where((e) =>
                                                  DateFormat("dd/M/yyyy")
                                                      .parse(e.date)
                                                      .isAfter(DateTime.now()))
                                              .toList()[index]
                                              .category;
                                          switch (getCategory) {
                                            case "Учеба":
                                              categoryColor = Colors.green;
                                              break;
                                            case "Работа":
                                              categoryColor = Colors.blue;
                                              break;
                                            case "Личное":
                                              categoryColor =
                                                  Colors.amberAccent;
                                              break;
                                          }
                                          return Container(
                                              padding: const EdgeInsets.all(20),
                                              margin:
                                                  const EdgeInsets.only(right: 20),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              decoration: BoxDecoration(
                                                  color: categoryColor
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      DateFormat("HH:mm").format(DateFormat(
                                                              'yyyy-M-dd h:m:s.S')
                                                          .parse(todoData
                                                              .where((e) =>
                                                                  e.isDone ==
                                                                  false)
                                                              .toList()
                                                              .where((e) => DateFormat(
                                                                      "dd/M/yyyy")
                                                                  .parse(e.date)
                                                                  .isAfter(
                                                                      DateTime
                                                                          .now()))
                                                              .toList()[index]
                                                              .time)),
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      todoData
                                                          .where((e) =>
                                                              e.isDone == false)
                                                          .toList()
                                                          .where((e) => DateFormat(
                                                                  "dd/M/yyyy")
                                                              .parse(e.date)
                                                              .isAfter(DateTime
                                                                  .now()))
                                                          .toList()[index]
                                                          .date,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
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
                                                      todoData
                                                          .where((e) =>
                                                              e.isDone == false)
                                                          .toList()
                                                          .where((e) => DateFormat(
                                                                  "dd/M/yyyy")
                                                              .parse(e.date)
                                                              .isAfter(DateTime
                                                                  .now()))
                                                          .toList()[index]
                                                          .title,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      todoData
                                                          .where((e) =>
                                                              e.isDone == false)
                                                          .toList()
                                                          .where((e) => DateFormat(
                                                                  "dd/M/yyyy")
                                                              .parse(e.date)
                                                              .isAfter(DateTime
                                                                  .now()))
                                                          .toList()[index]
                                                          .description,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        });
                                  })
                              : Container(
                                  padding: const EdgeInsets.all(12),
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Flexible(
                                        flex: 4,
                                        child: Text(
                                          "Пора...",
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Flexible(
                                        flex: 4,
                                        child: Text(
                                          "Время упорядочить свой день.",
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade700),
                                        ),
                                      ),
                                    ],
                                  ))
                          : Container(
                              padding: const EdgeInsets.all(12),
                              width: MediaQuery.of(context).size.width - 40,
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ],
                              )))),
            ),
            const SizedBox(height: 20.0),
          ]),
    );
  }
}

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 25.0,
              right: 25.0,
              bottom: 20,
            ),
            height: size.height * 0.2 - 27,
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
                Timecall(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
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
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);
  final String title;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: const Color(0xFF0C9869)),
            onPressed: press,
            child: const Text(
              "Подробнее",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0 / 4),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(right: 20.0 / 4),
              height: 7,
              color: const Color(0xFF0C9869).withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
