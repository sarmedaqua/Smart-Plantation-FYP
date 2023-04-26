import 'dart:async';

import 'package:assignment_starter/Domain/plants.dart';
import 'package:assignment_starter/components/buttons/planted_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}


class MapSampleState extends State<MapSample> {
  late LatLng universityMiddleCoordinates = LatLng(24.941374, 67.114108); // Southwest corner of university area
  double universityRadiusCoordinates = 400; // Northeast corner of university area



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
          title: 'Elephant Ears Planted Here!',
        ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),

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


  late LatLng point1;
  late LatLng point2;
  late LatLng point3;
  late LatLng point4;
  late LatLng point5;
  late LatLng point6;
  late LatLng point7;
  late LatLng point8;

  late List<LatLng> plantLocationCoordinates = [];
  late List<LatLng> plantLocationCoordinates1 = [];


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.939954, 67.115214),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(24.939954, 67.115214),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  // Set<Circle> circles = Set.from([Circle(
  //   center: LatLng(24.939954, 67.115214),
  //   radius: 60, circleId: CircleId("1"),
  // )]);
  @override
  void initState() {
    super.initState();

    point1 = LatLng(24.939826, 67.113248);
    point2 = LatLng(24.939525, 67.112741);
    point3 = LatLng(24.939272, 67.112872);
    point4 = LatLng(24.939600, 67.113298);

    point5 = LatLng(24.938288, 67.112529);
    point6 = LatLng(24.938381, 67.112678);
    point7 = LatLng(24.938313, 67.112708);
    point8 = LatLng(24.938229, 67.112582);
    // point5 = LatLng(24.939516, 67.113276);
    // point6 = LatLng(24.940214, 67.113566);
    // point7 = LatLng(24.940214, 67.113566);

    plantLocationCoordinates = [  point1,  point2,  point3,  point4, ];
    plantLocationCoordinates1 = [  point5,  point6,  point7,  point8, ];
  }

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
                // circles: {
                //   Circle(
                //     circleId: CircleId("university"),
                //     center: universityMiddleCoordinates,
                //     radius: universityRadiusCoordinates,
                //     fillColor: Colors.red.withOpacity(0.5),
                //     strokeWidth: 2,
                //     strokeColor: Colors.green,
                //   ),
                // },
              polygons: {
                Polygon(
                  polygonId: PolygonId("university"),
                  points: plantLocationCoordinates,
                  fillColor: Colors.red.withOpacity(0.5),
                  strokeWidth: 1,
                  strokeColor: Colors.red.withOpacity(0.5),
                ),
                Polygon(
                  polygonId: PolygonId("university"),
                  points: plantLocationCoordinates1,
                  fillColor: Colors.red.withOpacity(0.5),
                  strokeWidth: 1,
                  strokeColor: Colors.red.withOpacity(0.5),
                ),

              },
              markers: Set<Marker>.of(_markers),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              compassEnabled: true,
              //circles: circles,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          ),
          SizedBox(height: 40),

          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Container(child: ElevatedButton(

              onPressed: () async {
                getUserCurrentLocation().then((value) async {
                  print(value.latitude.toString() + " " + value.longitude.toString());

                  // marker added for current users location
                  _markers.add(
                      Marker(
                        markerId: MarkerId("2"),
                        position: LatLng(value.latitude, value.longitude),
                        infoWindow: InfoWindow(
                          title: 'Elephant Ears Planted Here!',
                        ),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
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
            )),
          )


        ],
      ),

    );

  }

}