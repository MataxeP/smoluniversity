import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smol_university/screens/onboarding/login_page.dart';

import 'screens/home/nav_bar_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //logged in
          if (snapshot.hasData) {
            return const NavBarPage();
          }
          //not logged in
          else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
