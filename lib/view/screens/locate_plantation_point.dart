import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class history {
  final String plantname;
  final String latitude;
  final String longitude;

  history({required this.plantname, required this.latitude, required this.longitude});
}


class MapSampleState extends State<MapSample> {


  bool _selected = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late LatLng universityMiddleCoordinates = LatLng(24.941374, 67.114108); // Southwest corner of university area
  double universityRadiusCoordinates = 400; // Northeast corner of university area

  //all plants
  List<String> plantDropDown = ['Calotrophis', 'Neem', 'Oleander', 'Raavi', 'Potato', 'Bellpepper'];


  final List<history> historyList =[];

  void addHistory() {

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('plant_location');

    Future<void> getData() async {
      QuerySnapshot querySnapshot = await _collectionRef.where('user_mail', isEqualTo: FirebaseAuth.instance.currentUser?.email).get();

      querySnapshot.docs.forEach((history_doc) {
        history hist = new history(plantname: history_doc['plant_name'], latitude: history_doc['latitude'].toString(), longitude: history_doc['longitude'].toString());
        historyList.add(hist);
      });
    }
    getData();
  }



 //user planted these plants
  List<String> userPlants = [];
//Selected value from menu
  String selectedValue = "Choose plant";

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: Column(
            children: [
              ListTile(
                leading: FaIcon(FontAwesomeIcons.plantWilt),
                title: Center(child: Text(selectedValue)),
                onTap: () {
                  // Handle music option selection
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  void _showAlertBox() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
      title: Text('Select Plant'),
      content: DropdownButton<String>(
        hint: Text('Please choose a plant'),
        value: _selected ? selectedValue: null,
        isExpanded: true,
        items: plantDropDown.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.green),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue!;
            _selected  = true;
            Navigator.pop(context);
              _showAlertBox();
            // FirebaseFirestore.instance.collection(
            //     'plant_location')
            //     .add({
            //   'latitude': ,
            //   'longitude':,
            //   'plant_name':,
            //   'user_mail': FirebaseAuth.instance.currentUser
            //       ?.email
            //
            // });

          });
        },
      ),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () {
            userPlants.add(selectedValue!);

            getUserCurrentLocation().then((value) async {
              FirebaseFirestore.instance.collection(
                  'plant_location')
                  .add({
                'latitude': value.latitude,
                'longitude': value.longitude,
                'plant_name': selectedValue,
                'user_mail': FirebaseAuth.instance.currentUser
                    ?.email
              });
              print(value.longitude);
              _markers.add(
                Marker(
                  onTap: () {
                   //_showBottomSheet();
                  },
                  markerId: MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: InfoWindow(
                    title: '$selectedValue is planted here',
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                ),
              );
              setState(() {

              });
            });


            Navigator.of(context).pop();
            _showAlertBoxAfterPlanting();
          },
        ),
      ],
    ),
    );
  }


  //alert box after planting

  void _showAlertBoxAfterPlanting() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
                   title: Text('Success!'),
            content: Text('You have successfully planted ${selectedValue} at this location!'),
           actions: [
             TextButton(
               child: Text('Continue'),
               onPressed: () {
                 Navigator.of(context).pop();
               }
             ),
           ],
    ));
  }


  //deleting
  Future<void> deleteUser(String collectionName,String id) async{
    await _firestore.collection(collectionName).doc(id).delete();
  }
  
  // alert box to show history
  //firebase crud
  /*
    * Collection : plants_planted
    * Save plants there
   */
//alert box after planting
//streambuilder to get
  Widget realTimeDisplayOfAdding(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //subscribed to firestore collection called users
      //so whenever doc is added/changed, we get 'notification'
      stream: _firestore.collection("plant_location").snapshots(),
      //snapshot is real time data we will get
      builder: (context, snapshot) {
        //if connection (With firestore) is established then.....
        if (snapshot.connectionState == ConnectionState.active) {
          if(snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              //length as much as doc we have
              itemCount:snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                //from docs array we are now selecting a doc
                Map<String, dynamic> userMap = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                //get users document id
                String documentId = snapshot.data!.docs[index].id;
                return Card(
                  elevation: 10,
                  child: ListTile(
                    minVerticalPadding: 30,
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/plant-six.png')
                    ),
                    title: Text(userMap["plant_name"]),
                    subtitle: Text('Planted at: '+userMap["longitude"].toString()  +' '+ userMap["latitude"].toString()),
                    trailing: IconButton(onPressed: () {
                      //delete with specific document function comes
                      deleteUser("plant_location",documentId);
                    },
                      icon: Icon(Icons.delete),

                    ),
                  ),
                );
              },);
          }
          else {
            return Text("No Data");
          }}
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }},
    );
  }

  void _showAlertBoxHistory() async {
    await showDialog(
        context: context,
        builder: (context) => SizedBox(
          width: double.infinity,
          child: Container(
            height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            child: AlertDialog(

              title: Text('History'),
              content: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: realTimeDisplayOfAdding(context),
              ),
              actions: [
                TextButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                ),
              ],
            ),
          ),
        ));
  }




  Completer<GoogleMapController> _controller = Completer();
  // on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(24.939954, 67.115214),
    zoom: 14.4746,
  );
  final List<Marker> _markers = <Marker>[];


  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }


 //return long and lat of current location:



  late CameraPosition _kGooglePlex;

  void _setInitialCameraPosition() async {
    Position position = await getUserCurrentLocation();
    double latitude = position.latitude;
    double longitude = position.longitude;

    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 14.4746,
      );
    });
  }


  @override
  void initState() {
    super.initState();
    addHistory();
    getMarkers();
    _setInitialCameraPosition();
  }

  void getMarkers() {
    var marker_id = 0;
    Future<void> getData() async {
      CollectionReference _collectionRef = FirebaseFirestore.instance
          .collection('plant_location');
      QuerySnapshot querySnapshot = await _collectionRef.get();
      querySnapshot.docs.forEach((plant_location_doc) {

        if(plant_location_doc['user_mail'] == FirebaseAuth.instance.currentUser?.email) {
          _markers.add(
            Marker(
              onTap: () {
                //_showBottomSheet();
              },
              markerId: MarkerId(plant_location_doc.id),
              position: LatLng(plant_location_doc['latitude'],
                  plant_location_doc['longitude']),
              //position: LatLng(34.765, 69.567),

              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
            ),
          );
        }

        else {
          _markers.add(
            Marker(
              onTap: () {
                //_showBottomSheet();
              },
              markerId: MarkerId(plant_location_doc.id),
              position: LatLng(plant_location_doc['latitude'],
                  plant_location_doc['longitude']),
              //position: LatLng(34.765, 69.567),

              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
            ),
          );
        }

      });
    }
    getData();
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
          SizedBox(height: 18),

          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(child:GestureDetector(
                  onTap: () {
                    _showAlertBoxHistory();
                  },
                  child: Icon(
                      FontAwesomeIcons.history
                  ),

                ),
                ),

                Container(child: ElevatedButton(

                  onPressed: () async {
                    _showAlertBox();
                  }
                  ,
                  child: Text(
                    'Plant here',
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
                SizedBox(width: 30,)
              ],
            ),
          ),


        ],
      ),

    );

  }

}