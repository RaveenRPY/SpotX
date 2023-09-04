import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'login_form.dart';
import 'package:icons_plus/icons_plus.dart';

void handleButtonPress(BuildContext context) {
  // ignore: avoid_print
  print('Button Pressed!');

  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: const Color.fromARGB(255, 1, 10, 92).withOpacity(0.2),
    transitionDuration: const Duration(milliseconds: 300),
    //ignore: avoid_unnecessary_containers
    pageBuilder: (_, __, ___) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GlassmorphicFlexContainer(
            borderRadius: 20,
            blur: 12,
            padding:
                const EdgeInsets.only(right: 20, left: 20, bottom: 48, top: 75),
            alignment: Alignment.bottomCenter,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                const Color.fromARGB(224, 0, 247, 255).withOpacity(0.18),
                const Color.fromARGB(255, 0, 153, 255).withOpacity(0.1),
              ],
              stops: const [
                0.1,
                1,
              ],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withOpacity(0.2),
                const Color((0xFFFFFFFF)).withOpacity(0.2),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
              ),
              child: Column(
                children: [
                  const SizedBox(
                      height:
                          30), // Add some spacing between the GlassmorphicFlexContainer and the "Sign In" text
                  const Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                      height:
                          15), // Add spacing between the "Sign In" text and other content
                  // Add your login form widget or content here
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Access to 240+ hours of content. Learn design and code, by building real apps with Flutter and Swift.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Intel",
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  SignInForm(),

                  const Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: "Intel",
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 30),
                    child: Center(
                      child: Text(
                        "Sign up with Email, Apple or Google",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                          fontSize: 18,
                          fontFamily: "Intel",
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Logo(
                          Logos.gmail,
                          size: 35,
                        ),
                        onTapDown: (details) {
                          // ignore: avoid_print
                          print("Pressed Email");
                        },
                      ),
                      GestureDetector(
                        child: Logo(
                          Logos.apple,
                          size: 35,
                          colorFilter: const ColorFilter.linearToSrgbGamma(),
                        ),
                        onTapDown: (details) {
                          // ignore: avoid_print
                          print("Pressed Apple");
                        },
                      ),
                      GestureDetector(
                        child: Logo(
                          Logos.google,
                          size: 35,
                        ),
                        onTapDown: (details) {
                          // ignore: avoid_print
                          print("Pressed Google");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;

      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: anim, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
  );
}
