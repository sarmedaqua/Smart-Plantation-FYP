import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment_starter/staticfiles/constants.dart';
import 'package:assignment_starter/Domain/plants.dart';
import 'detail_page.dart';
import 'package:assignment_starter/view/screens/more_screens/widgets/plant_widget.dart';
import 'package:page_transition/page_transition.dart';


class History extends StatefulWidget {


  //List<Plant> itemList= Plant.plantList;
  const History({Key? key})
      : super(key: key);


  @override
  State<History> createState() => _HistoryState();
}


class history {
  final String plantname;
  final String latitude;
  final String longitude;

  history({required this.plantname, required this.latitude, required this.longitude});
}



class _HistoryState extends State<History> {

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
    //history hist = new history(plantname: plantname, latitude: latitude, longitude: longitude)
  }


  //List<Plant> myObjects = Plant.plantList;
  //List<Plant> _suggestions = [];
  //final TextEditingController _searchController = TextEditingController();
 // FocusNode _searchFocusNode = FocusNode();
  @override
  void initState() {
    //_user = widget._user;
    super.initState();
    addHistory();
   // _suggestions = myObjects;

  }

  // void _filterObjects(String query) {
  //   List<Plant> filteredList = [];
  //   if (query.isNotEmpty) {
  //     filteredList = myObjects
  //         .where((obj) =>
  //         obj.plantName.toLowerCase().contains(query.toLowerCase()) )
  //         .toList();
  //   } else {
  //     filteredList = myObjects;
  //   }
  //   // Update the list of search suggestions with the filtered list
  //   setState(() {
  //     _suggestions = filteredList;
  //   });
  // }


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;



    return Scaffold(
        body: SingleChildScrollView(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                //padding: const EdgeInsets.only(top:10),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      width: size.width * .9,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.black54.withOpacity(.6),
                          ),

                          // Expanded(
                          //   child: TextField(
                          //     controller: _searchController,
                          //     onChanged: _filterObjects,
                          //     //showCursor: false,
                          //     decoration: InputDecoration(
                          //       hintText: 'Search Plant',
                          //       border: InputBorder.none,
                          //       focusedBorder: InputBorder.none,
                          //     ),
                          //
                          //     onTap: () {
                          //       _searchController.selection = TextSelection.fromPosition(
                          //           TextPosition(offset: _searchController.text.length));
                          //       _searchFocusNode.requestFocus(); // Add this line
                          //     },
                          //     focusNode: _searchFocusNode,
                          //   ),
                          //
                          // ),

                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Constants.primaryColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20),

                      ),
                    )
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                height: size.height*.8,
                child:
                ListView.builder(
                  itemCount: historyList.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final history myObject = historyList[index];
                    return ListTile(
                               title: Text(historyList[index].plantname)
                             );
                    // return GestureDetector(
                    //     onTap: (){
                    //       Navigator.push(context, PageTransition(child: DetailPage(plantId: myObject.plantId, user: FirebaseAuth.instance.currentUser!,), type: PageTransitionType.bottomToTop));
                    //     },
                    //     child: PlantWidget(index: index, plantList: _suggestions));
                  },
                ),

              ),

            ],
          ),
        ));

  }
}

