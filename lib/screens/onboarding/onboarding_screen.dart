// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth_page.dart';
import '../components/page_transition.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late RiveAnimationController _btnAnimationColtroller;

  @override
  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset("assets/images/Spline.png"),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
            ),
          ),
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Смоленский\nУниверситет",
                          style: GoogleFonts.montserrat(
                            fontSize: 35,
                            height: 1.2,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 16),
                      Text("Ваша возможность стать лучше.",
                          style: GoogleFonts.montserrat()),
                    ],
                  ),
                  const Spacer(flex: 2),
                  GestureDetector(
                    onTap: () async {
                      _btnAnimationColtroller.isActive = true;
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('showHome', true);
                      Navigator.of(context)
                          .push(MyPageTransitionAnimation(const AuthPage()));
                    },
                    child: SizedBox(
                      height: 64,
                      width: 230,
                      child: Stack(
                        children: [
                          RiveAnimation.asset(
                            "assets/RiveAssets/button.riv",
                            controllers: [_btnAnimationColtroller],
                          ),
                          const Positioned.fill(
                            top: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.arrow_right),
                                SizedBox(width: 8),
                                Text(
                                  "Стать продуктивнее",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 15),
                    child: Text(
                        "Твое расписание, заметки, навигация - все в одном приложении.",
                        style: GoogleFonts.montserrat()),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
