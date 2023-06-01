// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Timecall extends StatelessWidget {
  String text = "";
  int nowtime = DateTime.now().hour;

  Timecall({super.key});
  String time_call() {
    if (nowtime <= 11) {
      text = "Доброе утро  ☀️";
    }
    if (nowtime > 11) {
      text = "Добрый день  🌞";
    }
    if (nowtime >= 16) {
      text = "Добрый вечер  🌆";
    }
    if (nowtime >= 21) {
      text = "Доброй ночи  🌙";
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  time_call(),
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${FirebaseAuth.instance.currentUser!.displayName!}, чем займемся сегодня?",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade200,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
