import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

// ignore: camel_case_types
class car3d extends StatefulWidget {
  const car3d({super.key});

  @override
  State<car3d> createState() => _car3dState();
}

// ignore: camel_case_types
class _car3dState extends State<car3d> {
  List<ImageProvider> imageList = <ImageProvider>[];
  bool autoRotate = true;
  int rotationCount = 20;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = const Duration(milliseconds: 500);
  bool imagePrecached = false;

  @override
  void initState() {
    //* To load images from assets after first frame build up.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    (imagePrecached == true)
                        ? ImageView360(
                            key: UniqueKey(),
                            imageList: imageList,
                            autoRotate: autoRotate,
                            rotationCount: 5,
                            rotationDirection: RotationDirection.anticlockwise,
                            frameChangeDuration:
                                const Duration(milliseconds: 60),
                            swipeSensitivity: swipeSensitivity,
                            allowSwipeToRotate: allowSwipeToRotate,
                            onImageIndexChanged: (currentImageIndex) {
                              // ignore: avoid_print
                              print("currentImageIndex: $currentImageIndex");
                            },
                          )
                        : const Text("Pre-Caching images..."),
                    // Image.asset('lib/assets/3D/JPG/1.jpg'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateImageList(BuildContext context) async {
    for (int i = 1; i <= 72; i++) {
      imageList.add(AssetImage('lib/assets/3D/JPG/$i.jpg'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('lib/assets/3D/JPG/$i.jpg'), context);
    }
    setState(() {
      imagePrecached = true;
    });
  }
}
