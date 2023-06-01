// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:smol_university/screens/components/page_transition.dart';
import 'package:smol_university/screens/onboarding/forgot_password_page.dart';
import 'package:smol_university/screens/onboarding/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool backPressed = false;

  late AnimationController controllerToIncreasingCurve;

  late AnimationController controllerToDecreasingCurve;

  late Animation<double> animationToIncreasingCurve;

  late Animation<double> animationToDecreasingCurve;

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);

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

    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }

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
  TextEditingController emailController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();

  /// rive controller and input
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
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
          backgroundColor: const Color(0xFFD6E2EA),
          resizeToAvoidBottomInset: true,
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
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          "Привет!",
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 250,
                          width: 250,
                          child: RiveAnimation.asset(
                            "assets/RiveAssets/animated-login-screen.riv",
                            fit: BoxFit.fitHeight,
                            stateMachines: const ["Login Machine"],
                            onInit: (artboard) {
                              controller = StateMachineController.fromArtboard(
                                artboard,
                                "Login Machine",
                              );
                              if (controller == null) return;

                              artboard.addController(controller!);
                              isChecking = controller?.findInput("isChecking");
                              numLook = controller?.findInput("numLook");
                              isHandsUp = controller?.findInput("isHandsUp");
                              trigSuccess =
                                  controller?.findInput("trigSuccess");
                              trigFail = controller?.findInput("trigFail");
                            },
                          ),
                        ),
                        Container(
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
                                  focusNode: emailFocusNode,
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                  ),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  onChanged: (value) {
                                    numLook?.change(value.length.toDouble());
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
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  onChanged: (value) {},
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MyPageTransitionAnimation(
                                            const ForgotPasswordPage()));
                                  },
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("Забыли пароль?",
                                            style: GoogleFonts.poppins(
                                                color: Colors.blue)),
                                      ])),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 64,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    emailFocusNode.unfocus();
                                    passwordFocusNode.unfocus();

                                    final email = emailController.text;
                                    final password = passwordController.text;

                                    showLoadingDialog(context);
                                    await Future.delayed(
                                      const Duration(milliseconds: 2000),
                                    );
                                    if (mounted) Navigator.pop(context);

                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: email, password: password);
                                      trigSuccess?.change(true);
                                    } on FirebaseAuthException catch (e) {
                                      trigFail?.change(true);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Stack(
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                height: 90,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFC72C41),
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white)),
                                                          Text(e.code,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .poppins(
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
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text("Войти"),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Еще нет аккаунта?",
                                      style: GoogleFonts.poppins()),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MyPageTransitionAnimation(
                                                const RegisterPage()));
                                      },
                                      child: Text(" Зарегистрироваться",
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue))),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
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
