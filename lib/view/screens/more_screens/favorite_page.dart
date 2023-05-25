import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment_starter/staticfiles/constants.dart';
import 'package:assignment_starter/Domain/plants.dart';
import 'package:assignment_starter/view/screens/more_screens/widgets/plant_widget.dart';

class FavoritePage extends StatefulWidget {

  final List<Plant> favoritedPlants;
  const FavoritePage({Key? key, required this.favoritedPlants})
      : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

   final List<Plant> favourite_plants = [];


  void Favourite() {
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('favourite_plant_data');
    //favourite_plants.clear();

    Future<void> getData() async {

      QuerySnapshot querySnapshot = await _collectionRef.where('user_mail', isEqualTo: FirebaseAuth.instance.currentUser?.email).get();

      favourite_plants.clear();
      querySnapshot.docs.forEach((favouritedoc) {
        favourite_plants.add(Plant.plantList[favouritedoc['plant_id']]);
        print(favourite_plants);
      });

    }
    getData();

  }

   @override
   void initState() {
     super.initState();
   }



  @override
  Widget build(BuildContext context) {
     Favourite();
    Size size = MediaQuery.of(context).size;
    return FocusScope(
      child: Scaffold(
      body: favourite_plants.isEmpty
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset('assets/images/favorited.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Your favorited Plants',
              style: TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
          ],
        ),
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        height: size.height * .8,
        child: ListView.builder(
            itemCount: favourite_plants.length,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return PlantWidget(
                  index: index, plantList: favourite_plants);
            }),
      ),
    ),
    );
  }
}