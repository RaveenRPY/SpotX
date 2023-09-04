import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rive/rive.dart' hide RadialGradient, LinearGradient;
import 'package:flutter/services.dart';
import 'package:spotx/Screens/login_card.dart';
import 'package:spotx/Screens/tracking_page_JG.dart';
import 'package:spotx/Screens/tracking_page_kia.dart';
import 'package:spotx/Screens/vehicle_page.dart';
import 'glowing_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color.fromARGB(6, 0, 0, 0),
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    return Material(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(255, 0, 31, 59),
                Color.fromARGB(255, 0, 0, 0),
              ],
              radius: 1,
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Color.fromARGB(232, 0, 255, 255),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                  ),
                ),
              ),
              // SingleChildScrollView(
              //   child: SizedBox(
              //     height: MediaQuery.of(context).size.height,
              //     child: const Align(
              //       alignment: Alignment.topCenter,
              //       child: AspectRatio(
              //         aspectRatio: 0.5, // Set the desired aspect ratio
              //         child: RiveAnimation.asset(
              //           "lib/assets/old/flying_car (1).riv",
              //           alignment: Alignment.topCenter,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/old/LogoText2.png',
                        scale: 6,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 350,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(0, 0, 0, 0),
                          Color.fromARGB(255, 0, 0, 0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 320,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 0, bottom: 0),
                            child: Text(
                              "Find your own vehicle from the crowed",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                height: 1.2,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 1, right: 20, bottom: 30),
                            child: Text(
                              "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    StartButton(
                      color1: const Color(0xff47b5fb),
                      color2: const Color(0xff57e3eb),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: const TrackKia(),
                          ),
                        );
                        // handleButtonPress(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
