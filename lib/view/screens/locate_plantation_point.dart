import 'dart:async';

import 'package:assignment_starter/staticfiles/planted_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.939954, 67.115214),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(24.939954, 67.115214),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Set<Circle> circles = Set.from([Circle(
    center: LatLng(24.939954, 67.115214),
    radius: 6000, circleId: CircleId("1"),
  )]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width, // or use fixed size like 200
            height: MediaQuery.of(context).size.height * 0.8,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              circles: circles,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          ),
          SizedBox(height: 30,),

          PlantedButton()


        ],
      ),

    );

  }

}