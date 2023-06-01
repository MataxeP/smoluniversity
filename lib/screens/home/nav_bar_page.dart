import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smol_university/screens/home/home_page.dart';

import 'notes_page.dart';
import 'maps_page.dart';
import 'profile_page.dart';
import 'timetable_page.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({Key? key}) : super(key: key);

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> with TickerProviderStateMixin {
  int currentActiveIndex = 0;

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  void changePage(page) {
    setState(() {
      currentActiveIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: IndexedStack(index: currentActiveIndex, children: <Widget>[
          HomePage(changePage),
          const TimetablePage(),
          const NotesPage(),
          const MapsPage(),
          const ProfilePage(),
        ]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 20,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: SizedBox(
              height: 80,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (index) => changePage(index),
                currentIndex: currentActiveIndex,
                selectedItemColor: const Color(0xFF0C9869),
                unselectedItemColor: Colors.grey.withOpacity(0.5),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.clock), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.book_fill), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.map_fill), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.settings), label: "Home"),
                ],
              )),
        ),
      ),
    );
  }
}
