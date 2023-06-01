// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smol_university/provider/service_provider.dart';

class CardTodoList extends ConsumerWidget {
  const CardTodoList({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchToDoStreamProvider);
    return todoData.when(
        data: (todoData) {
          Color categoryColor = Colors.white;
          final getCategory = todoData[getIndex].category;
          switch (getCategory) {
            case "Учеба":
              categoryColor = Colors.green;
              break;
            case "Работа":
              categoryColor = Colors.blue.shade700;
              break;
            case "Личное":
              categoryColor = Colors.amberAccent.shade700;
              break;
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  width: 20,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          leading: IconButton(
                              onPressed: () => ref
                                  .read(todoServiceProvider)
                                  .deleteTask(todoData[getIndex].docID),
                              icon: const Icon(CupertinoIcons.delete)),
                          contentPadding: EdgeInsets.zero,
                          title: Text(todoData[getIndex].title,
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                  decoration: todoData[getIndex].isDone
                                      ? TextDecoration.lineThrough
                                      : null)),
                          subtitle: Text(todoData[getIndex].description,
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                  decoration: todoData[getIndex].isDone
                                      ? TextDecoration.lineThrough
                                      : null)),
                          trailing: Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                  activeColor: Colors.blue.shade800,
                                  shape: const CircleBorder(),
                                  value: todoData[getIndex].isDone,
                                  onChanged: (value) => ref
                                      .read(todoServiceProvider)
                                      .updateTask(
                                          todoData[getIndex].docID, value)))),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Column(
                          children: [
                            Divider(
                                thickness: 1.5, color: Colors.grey.shade200),
                            Row(
                              children: [
                                Text(todoData[getIndex].date),
                                const Gap(12),
                                Text(todoData[getIndex].time),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          );
        },
        error: (error, StackTrace) =>
            Center(child: Text(StackTrace.toString())),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
