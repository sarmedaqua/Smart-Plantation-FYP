import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PlantedButton extends StatefulWidget {
  PlantedButton({Key? key}) : super(key: key);

  @override
  State<PlantedButton> createState() => _PlantedButtonState();
}

class _PlantedButtonState extends State<PlantedButton> {

  Completer<GoogleMapController> _controller = Completer();
  // on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(24.939954, 67.115214),
    zoom: 14.4746,
  );
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )
    ),
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: () async {
        getUserCurrentLocation().then((value) async {
          print(value.latitude.toString() + " " + value.longitude.toString());

          // marker added for current users location
          _markers.add(
              Marker(
                markerId: MarkerId("2"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(
                  title: 'My Current Location',
                ),
              )
          );

          // specified current users location
          CameraPosition cameraPosition = new CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            zoom: 14,
          );
          // specified current users location
          cameraPosition = new CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            zoom: 14,
          );

          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          setState(() {
          });

        });
        }
      ,
      child: Text(
          'PLANTED',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: (
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(
                0x980E7911)
        ),
        fixedSize: Size(180, 50),
      ),
    );
  }
}





