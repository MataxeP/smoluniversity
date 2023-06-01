import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:smol_university/services/theme_service.dart';

import '../components/profile_menu_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final nameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  bool backPressed = false;

  late AnimationController controllerToIncreasingCurve;

  late AnimationController controllerToDecreasingCurve;

  late Animation<double> animationToIncreasingCurve;

  late Animation<double> animationToDecreasingCurve;

  @override
  void initState() {
    controllerToIncreasingCurve = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    controllerToDecreasingCurve = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animationToIncreasingCurve = Tween<double>(begin: 500, end: 0).animate(
      CurvedAnimation(
        parent: controllerToIncreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {});
      });

    animationToDecreasingCurve = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(
        parent: controllerToDecreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {});
      });

    controllerToIncreasingCurve.forward();

    super.initState();
  }

  StateMachineController? controller;
  SMIInput<bool>? switchInput;

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backPressed = true;
        controllerToDecreasingCurve.forward();
        return true;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(backPressed == false
            ? animationToIncreasingCurve.value
            : animationToDecreasingCurve.value),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
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
                                "Настройки",
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
                          child: Container(
                            alignment: Alignment.center,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileMenuWidget(
                            color: Colors.green,
                            icon: Icons.person,
                            title: "Профиль",
                            onTap: () {
                              Get.to(() => const EditProfilePage());
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                ),
                                child: const Icon(
                                  Icons.sunny,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Тема",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                  onTap: () {
                                    switchInput!.value =
                                        ThemeService().theme == ThemeMode.dark
                                            ? false
                                            : true;
                                    ThemeService().switchTheme();
                                  },
                                  borderRadius: BorderRadius.circular(150),
                                  child: SizedBox(
                                      height: 46,
                                      width: 70,
                                      child: RiveAnimation.asset(
                                          "assets/RiveAssets/switch_theme.riv",
                                          fit: BoxFit.fill,
                                          stateMachines: const ["Switch Theme"],
                                          onInit: (artboard) {
                                        controller =
                                            StateMachineController.fromArtboard(
                                                artboard, "Switch Theme");
                                        if (controller == null) return;
                                        artboard.addController(controller!);
                                        switchInput =
                                            controller?.findInput("isDark");
                                        switchInput!.value =
                                            ThemeService().theme ==
                                                    ThemeMode.dark
                                                ? true
                                                : false;
                                      })))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ProfileMenuWidget(
                            color: Colors.red,
                            icon: Icons.logout,
                            title: "Выйти из приложения",
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                            },
                          )
                        ],
                      ))
                ])),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  bool backPressed = false;

  late AnimationController controllerToIncreasingCurve;

  late AnimationController controllerToDecreasingCurve;

  late Animation<double> animationToIncreasingCurve;

  late Animation<double> animationToDecreasingCurve;

  @override
  void initState() {
    controllerToIncreasingCurve = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    controllerToDecreasingCurve = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animationToIncreasingCurve = Tween<double>(begin: 500, end: 0).animate(
      CurvedAnimation(
        parent: controllerToIncreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {});
      });

    animationToDecreasingCurve = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(
        parent: controllerToDecreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {});
      });

    controllerToIncreasingCurve.forward();

    super.initState();
  }

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backPressed = true;
        controllerToDecreasingCurve.forward();
        return true;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(backPressed == false
            ? animationToIncreasingCurve.value
            : animationToDecreasingCurve.value),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Ваш профиль",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            backgroundColor: const Color(0xFF0C9869),
            elevation: 0,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(CupertinoIcons.arrow_left)),
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                          left: 25.0,
                          right: 25.0,
                          bottom: 20,
                        ),
                        height: MediaQuery.of(context).size.height * 0.07 - 27,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0C9869),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(36),
                            bottomRight: Radius.circular(36),
                          ),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Form(
                          child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: user.displayName)),
                              )),
                          const SizedBox(height: 10),
                          Container(
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: user.email)),
                              )),
                          const SizedBox(height: 10),
                          Container(
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Пароль')),
                              )),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              if (nameController.text != '') {
                                user.updateDisplayName(nameController.text);
                                nameController.clear();
                              }
                              if (emailController.text != '') {
                                user.updateEmail(emailController.text);
                                emailController.clear();
                              }
                              if (passwordController.text != '') {
                                user.updatePassword(passwordController.text);
                                passwordController.clear();
                              }
                              Get.back();
                            },
                            child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF0C9869),
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Center(
                                    child: Text("Изменить данные",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17)))),
                          ),
                        ],
                      ))
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
