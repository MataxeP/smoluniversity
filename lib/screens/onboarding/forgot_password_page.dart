// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
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
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

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
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
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
                          "Какая досада!",
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
                              const SizedBox(height: 15),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 64,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    emailFocusNode.unfocus();

                                    final email = emailController.text;

                                    showLoadingDialog(context);
                                    await Future.delayed(
                                      const Duration(milliseconds: 2000),
                                    );
                                    if (mounted) Navigator.pop(context);

                                    try {
                                      await FirebaseAuth.instance
                                          .sendPasswordResetEmail(email: email);
                                      trigSuccess?.change(true);
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
                                                          Text("Готово!",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white)),
                                                          Text(
                                                              "Инструкция по восстановлению пароля отправлена на вашу почту.",
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
                                    } on FirebaseAuthException catch (e) {
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
                                  child: const Text("Отправить"),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Text("Назад",
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
