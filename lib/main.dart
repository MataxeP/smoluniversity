import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smol_university/auth_page.dart';
import 'package:smol_university/screens/onboarding/onboarding_screen.dart';
import 'package:smol_university/screens/theme/dark_theme.dart';
import 'package:smol_university/screens/theme/light_theme.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'schedule',
            channelName: "Расписание",
            channelDescription: "Напоминания о парах")
      ],
      debug: true);
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'notes',
            channelName: "Заметки",
            channelDescription: "Ваши дела")
      ],
      debug: true);
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ProviderScope(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Смоленский Университет',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeService().theme,
          home: showHome ? const AuthPage() : const OnboardingScreen(),
        ),
      );
    });
  }
}
