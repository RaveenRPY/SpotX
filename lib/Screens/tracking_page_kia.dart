import 'dart:async';
import 'dart:ui';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotx/glowing_button.dart';
import 'package:geolocator/geolocator.dart';

class TrackKia extends StatefulWidget {
  const TrackKia({Key? key}) : super(key: key);

  @override
  State<TrackKia> createState() => _TrackKiaState();
}

class _TrackKiaState extends State<TrackKia> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng sourceLocation = const LatLng(6.338201, 80.846538);
  LatLng currentLocation = LatLng(6.855127, 79.917868);

  late String _darkMapStyle;

  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];

  getPolyPoints(sourceLocation, destinationLocation) async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAuzktB9nEHc-T-2NOsstGmh-_IdMP7Ies",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[];

  // created method for getting user current location
  getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((currentLocation) {}).onError(
      (error, stackTrace) async {
        await Geolocator.requestPermission();
        print("ERROR" + error.toString());
      },
    );
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadMapStyles();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _setMapStyle();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _loadMapStyles() async {
    _darkMapStyle =
        await rootBundle.loadString('lib/assets/Json/lightDarkMode.json');
  }

  _setMapStyle() async {
    final controller = await _controller.future;
    controller.setMapStyle(_darkMapStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   height: 1000,
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         Color.fromARGB(255, 34, 43, 58),
          //         Color.fromARGB(255, 15, 20, 27),
          //       ],
          //       begin: Alignment.bottomCenter,
          //       end: Alignment.topCenter,
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: sourceLocation,
                zoom: 16.8,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polylineCoordinates,
                  color: const Color.fromARGB(255, 0, 255, 255),
                  width: 5,
                )
              },
              // on below line setting user location enabled.
              myLocationEnabled: true,
              // on below line setting compass enabled.
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _setMapStyle(); // Set the dark map style
              },
              markers: {
                Marker(
                  markerId: const MarkerId('Vehicle'),
                  position: sourceLocation,
                  infoWindow: const InfoWindow(title: 'Your Vehicle'),
                ),
              },
            ),
          ),
          Positioned(
            left: 5,
            top: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 3, 157, 168),
                shape: const CircleBorder(),
                alignment: Alignment.center,
                elevation: 5,
                padding: const EdgeInsets.all(13),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 270,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 15, 19, 26),
                      Color.fromARGB(255, 24, 31, 41),
                      Color.fromARGB(218, 36, 47, 62),
                      Color.fromARGB(0, 36, 47, 62),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
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
                    bottom: 15.0,
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
                            width: 160,
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
                        top: 25,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Text(
                          'Kia Seltos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Intel",
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Positioned(
                        top: -60,
                        left: -13,
                        right: -35,
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: Image(
                                  image: AssetImage('lib/assets/old/kia.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 180,
                        child: DirrectionButton(
                          color1: const Color(0xff47b5fb),
                          color2: const Color(0xff57e3eb),
                          onPressed: () {
                            getUserCurrentLocation().then((value) =>
                                getPolyPoints(sourceLocation, value));

                            // Navigator.push(
                            //   context,
                            //   (
                            //     builder:(context) => (getPolyPoints(sourceLocation, destination)),
                            //   ),
                            // );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: Container(
                              width: 220,
                              height: 120,
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
                                    color:
                                        const Color.fromARGB(255, 0, 199, 206)
                                            .withOpacity(0.5),
                                  )),
                            ),
                          ),
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Distance',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Intel",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  Text(
                                    'Remaining',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Intel",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Text(
                                      '125.2 km ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 255, 255),
                                        fontFamily: "Intel",
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Icon(
                                OctIcons.location_24,
                                size: 60,
                                color: Color.fromARGB(204, 137, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15.0,
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
                              width: 220,
                              height: 120,
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
                                    color:
                                        const Color.fromARGB(255, 0, 199, 206)
                                            .withOpacity(0.5),
                                  )),
                            ),
                          ),
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Car',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Intel",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  Text(
                                    'Speed',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Intel",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Text(
                                      '15 km/h ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 255, 255),
                                        fontFamily: "Intel",
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2),
                              child: Icon(
                                Iconsax.speedometer,
                                size: 60,
                                color: Color.fromARGB(204, 137, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 12,
            bottom: 280,
            child: ElevatedButton(
              onPressed: () async {
                getUserCurrentLocation().then((value) async {
                  // marker added for current users location
                  _markers.add(Marker(
                    markerId: const MarkerId("2"),
                    position: LatLng(value.latitude, value.longitude),
                    infoWindow: const InfoWindow(
                      title: 'My Current Location',
                    ),
                  ));

                  // specified current users location
                  CameraPosition cameraPosition = CameraPosition(
                    target: LatLng(value.latitude, value.longitude),
                    zoom: 16,
                  );

                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(cameraPosition));
                  setState(() {});
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 3, 157, 168),
                shape: const CircleBorder(),
                alignment: Alignment.center,
                fixedSize: const Size.square(55),
                elevation: 5,
              ),
              child: const Icon(OctIcons.person_16),
            ),
          ),

          Positioned(
            right: 12,
            bottom: 350,
            child: ElevatedButton(
              onPressed: () async {
                getUserCurrentLocation().then((value) async {
                  // specified current users location
                  CameraPosition cameraPosition = CameraPosition(
                    target: LatLng(
                        sourceLocation.latitude, sourceLocation.longitude),
                    zoom: 16,
                  );

                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(cameraPosition));
                  setState(() {});
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 3, 157, 168),
                shape: const CircleBorder(),
                alignment: Alignment.center,
                fixedSize: const Size.square(55),
                elevation: 5,
              ),
              child: const Icon(OctIcons.dot_fill_24),
            ),
          ),
        ],
      ),
    );
  }
}
