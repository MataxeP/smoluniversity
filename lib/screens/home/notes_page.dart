// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../provider/service_provider.dart';
import '../../services/notification_service.dart';
import '../components/new_task_model.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchToDoStreamProvider);
    int count = 0;
    if (todoData.value != null) {
      count = todoData.value!.length;
    }

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 25),
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
                            "Ваши заметки",
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
                            builder: (context) => AddNewTaskModel()),
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
                          child: const Text("+ Добавить заметку",
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: count != 0
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return todoData.when(
                                  // ignore: avoid_types_as_parameter_names
                                  error: (error, StackTrace) => Center(
                                      child: Text(StackTrace.toString())),
                                  loading: () => const Center(
                                      child: CircularProgressIndicator()),
                                  data: (todoData) {
                                    todoData.sort(
                                        (a, b) => a.date.compareTo(b.date));
                                    todoData.sort(
                                        (a, b) => a.time.compareTo(b.time));
                                    Color categoryColor = Colors.white;
                                    final getCategory =
                                        todoData[index].category;
                                    switch (getCategory) {
                                      case "Учеба":
                                        categoryColor = Colors.green;
                                        break;
                                      case "Работа":
                                        categoryColor = Colors.blue;
                                        break;
                                      case "Личное":
                                        categoryColor = Colors.amberAccent;
                                        break;
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(Container(
                                          color: Colors.white,
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.32,
                                          child: Column(children: [
                                            Container(
                                              height: 6,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade300),
                                            ),
                                            const Spacer(),
                                            todoData[index].isDone
                                                ? GestureDetector(
                                                    onTap: () {
                                                      ref
                                                          .read(
                                                              todoServiceProvider)
                                                          .updateTask(
                                                              todoData[index]
                                                                  .docID,
                                                              false);
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 4),
                                                      height: 55,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: const Center(
                                                          child: Text(
                                                              "Задача не завершена",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white))),
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      cancelNotification(
                                                          int.parse(
                                                              todoData[index]
                                                                  .id));
                                                      ref
                                                          .read(
                                                              todoServiceProvider)
                                                          .updateTask(
                                                              todoData[index]
                                                                  .docID,
                                                              true);
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 4),
                                                      height: 55,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: const Center(
                                                          child: Text(
                                                              "Задача завершена",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white))),
                                                    ),
                                                  ),
                                            GestureDetector(
                                              onTap: () {
                                                cancelNotification(int.parse(
                                                    todoData[index].id));
                                                ref
                                                    .read(todoServiceProvider)
                                                    .deleteTask(
                                                        todoData[index].docID);
                                                Get.back();
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                height: 55,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: const Center(
                                                    child: Text(
                                                        "Удалить заметку",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                height: 55,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                decoration: BoxDecoration(
                                                    border:
                                                        Border.all(width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: const Center(
                                                    child: Text("Закрыть",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black))),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ]),
                                        ));
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(20),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          height: 200,
                                          decoration: BoxDecoration(
                                              color: categoryColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  DateFormat("HH:mm").format(
                                                      DateFormat(
                                                              'yyyy-M-dd h:m:s.S')
                                                          .parse(todoData[index]
                                                              .time)),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      decoration:
                                                          todoData[index].isDone
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : null,
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  todoData[index].date,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      decoration:
                                                          todoData[index].isDone
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
                                                  todoData[index].title,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      decoration:
                                                          todoData[index].isDone
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
                                                  todoData[index].description,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      decoration:
                                                          todoData[index].isDone
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : null,
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  });
                            },
                            itemCount: count,
                            shrinkWrap: true)
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
                            )),
                  ))
            ]));
  }
}
