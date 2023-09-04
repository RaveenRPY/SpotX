import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart' hide RadialGradient, LinearGradient;
import 'package:glassmorphism/glassmorphism.dart';
import 'package:spotx/Screens/tracking_page_JG.dart';
import 'package:spotx/Screens/tracking_page_kia.dart';
import 'package:spotx/glowing_button.dart';
import 'package:imageview360/imageview360.dart';
import 'package:page_transition/page_transition.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  List<ImageProvider> imageList = <ImageProvider>[];
  bool autoRotate = true;
  int rotationCount = 2;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = Duration(milliseconds: 50);
  bool imagePrecached = false;

  @override
  void initState() {
    //* To load images from assets after first frame build up.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(context));
    super.initState();
  }

  void updateImageList(BuildContext context) async {
    for (int i = 1; i <= 72; i++) {
      imageList.add(AssetImage('lib/assets/3D/webp/$i.webp'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('lib/assets/3D/webp/$i.webp'), context);
    }
    setState(() {
      imagePrecached = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 27, 63),
                  Color.fromARGB(255, 0, 80, 138),
                  Color.fromARGB(255, 3, 162, 173),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          Center(
            child: SizedBox(
                height: 300,
                width: 300,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Color.fromARGB(223, 0, 183, 207),
                        Color.fromARGB(151, 0, 39, 112),
                      ],
                      focalRadius: 1,
                      radius: 5,
                    ),
                  ),
                )),
          ),
          // const RiveAnimation.asset(
          //   "lib/assets/RiveAssets/bg2.riv",
          // ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              child: const SizedBox(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: SafeArea(
                  child: Image.asset(
                    'lib/assets/old/LogoText2.png',
                    scale: 5,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 25.0,
                    right: 0,
                    left: 0,
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            width: 180,
                            height: 250,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color.fromARGB(255, 0, 19, 105)
                                        .withOpacity(0.1),
                                    const Color.fromARGB(255, 0, 99, 247)
                                        .withOpacity(0.05),
                                  ],
                                  stops: const [
                                    0.1,
                                    1,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 2,
                                  color: const Color.fromARGB(255, 0, 199, 206)
                                      .withOpacity(0.5),
                                )),
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Text(
                          'Jaguar XF',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Intel",
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Positioned(
                        top: -50,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 27),
                          child: Row(
                            children: [
                              Text(
                                'Engine:  ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Intel",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '1000cc',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Intel",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 10,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 27),
                          child: Row(
                            children: [
                              Text(
                                'Seats:  ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Intel",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '05',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Intel",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 180,
                        child: TrackButton(
                          color1: const Color(0xff47b5fb),
                          color2: const Color(0xff57e3eb),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const TrackJG(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 25.0,
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            width: 180,
                            height: 250,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color.fromARGB(255, 0, 19, 105)
                                        .withOpacity(0.1),
                                    const Color.fromARGB(255, 0, 99, 247)
                                        .withOpacity(0.05),
                                  ],
                                  stops: const [
                                    0.1,
                                    1,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 2,
                                  color: const Color.fromARGB(255, 0, 199, 206)
                                      .withOpacity(0.5),
                                )),
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Text(
                          'KIA Seltos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: "Intel",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Positioned(
                        top: -50,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 27),
                          child: Row(
                            children: [
                              Text(
                                'Engine:  ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Intel",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '1600cc',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Intel",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 10,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 27),
                          child: Row(
                            children: [
                              Text(
                                'Seats:  ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Intel",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '08',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Intel",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 180,
                        child: TrackButton(
                          color1: const Color(0xff47b5fb),
                          color2: const Color(0xff57e3eb),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const TrackKia(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: SizedBox(
                width: 800,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    (imagePrecached == true)
                        ? ImageView360(
                            key: UniqueKey(),
                            imageList: imageList,
                            autoRotate: autoRotate,
                            rotationCount: rotationCount,
                            rotationDirection: RotationDirection.anticlockwise,
                            frameChangeDuration: Duration(milliseconds: 40),
                            swipeSensitivity: swipeSensitivity,
                            allowSwipeToRotate: allowSwipeToRotate,
                            onImageIndexChanged: (currentImageIndex) {
                              print("currentImageIndex: $currentImageIndex");
                            },
                          )
                        : const Text(
                            "Loading...",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          // Center(
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(20),
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          //       child: Container(
          //         width: 300,
          //         height: 300,
          //         decoration: BoxDecoration(
          //             gradient: const LinearGradient(
          //               colors: [Colors.white54, Colors.white10],
          //               begin: Alignment.topLeft,
          //               end: Alignment.bottomCenter,
          //             ),
          //             borderRadius: BorderRadius.circular(25),
          //             border: Border.all(width: 2, color: Colors.white30)),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
