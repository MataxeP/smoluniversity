// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:smol_university/screens/onboarding/login_page.dart';

import '../components/page_transition.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  bool backPressed = false;

  late AnimationController controllerToIncreasingCurve;

  late AnimationController controllerToDecreasingCurve;

  late Animation<double> animationToIncreasingCurve;

  late Animation<double> animationToDecreasingCurve;

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// input form controller
  FocusNode emailFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  FocusNode confPasswordFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  /// rive controller and input
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    nameFocusNode.addListener(nameFocus);
    confPasswordFocusNode.addListener(confPasswordFocus);
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
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    nameFocusNode.removeListener(nameFocus);
    confPasswordFocusNode.removeListener(confPasswordFocus);
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  void nameFocus() {
    isChecking?.change(nameFocusNode.hasFocus);
  }

  void confPasswordFocus() {
    isHandsUp?.change(confPasswordFocusNode.hasFocus);
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
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xFFD6E2EA),
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
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Давай\nзнакомиться!",
                            style: GoogleFonts.montserrat(
                                color: Colors.black, fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: RiveAnimation.asset(
                              "assets/RiveAssets/animated-login-screen.riv",
                              fit: BoxFit.fitHeight,
                              stateMachines: const ["Login Machine"],
                              onInit: (artboard) {
                                controller =
                                    StateMachineController.fromArtboard(
                                  artboard,
                                  "Login Machine",
                                );
                                if (controller == null) return;

                                artboard.addController(controller!);
                                isChecking =
                                    controller?.findInput("isChecking");
                                numLook = controller?.findInput("numLook");
                                isHandsUp = controller?.findInput("isHandsUp");
                                trigSuccess =
                                    controller?.findInput("trigSuccess");
                                trigFail = controller?.findInput("trigFail");
                              },
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: TextField(
                                      focusNode: nameFocusNode,
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Имя",
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      onChanged: (value) {
                                        numLook
                                            ?.change(value.length.toDouble());
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: TextField(
                                      focusNode: emailFocusNode,
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      onChanged: (value) {
                                        numLook
                                            ?.change(value.length.toDouble());
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: TextField(
                                      focusNode: passwordFocusNode,
                                      controller: passwordController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Пароль",
                                      ),
                                      obscureText: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: TextField(
                                      focusNode: confPasswordFocusNode,
                                      controller: confPasswordController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Повторите пароль",
                                      ),
                                      obscureText: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 64,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        emailFocusNode.unfocus();
                                        passwordFocusNode.unfocus();

                                        final email = emailController.text;
                                        final name = nameController.text;
                                        final password =
                                            passwordController.text;
                                        final confPassword =
                                            confPasswordController.text;

                                        showLoadingDialog(context);
                                        await Future.delayed(
                                          const Duration(milliseconds: 2000),
                                        );
                                        if (mounted) Navigator.pop(context);

                                        try {
                                          if (password == confPassword) {
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                                    email: email,
                                                    password: password);
                                            await FirebaseAuth
                                                .instance.currentUser!
                                                .updateDisplayName(name);
                                            trigSuccess?.change(true);
                                          } else {
                                            trigFail?.change(true);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Stack(
                                                children: [
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      height: 90,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFFC72C41),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text("Ошибка!",
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .white)),
                                                                Text(
                                                                    "Пароли не совпадают",
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white)),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                            ));
                                          }
                                        } on FirebaseAuthException catch (e) {
                                          trigFail?.change(true);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Stack(
                                              children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    height: 90,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFC72C41),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text("Ошибка!",
                                                                  style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white)),
                                                              Text(e.code,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          ));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: const Text("Зарегистрироваться"),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Уже есть аккаунт?",
                                          style: GoogleFonts.poppins()),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MyPageTransitionAnimation(
                                                    const LoginPage()));
                                          },
                                          child: Text(" Войти",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.blue))),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
