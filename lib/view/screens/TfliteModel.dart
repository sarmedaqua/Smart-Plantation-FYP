import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tflite/tflite.dart';

import '../../Domain/plants.dart';
import 'more_screens/detail_page.dart';


class TfliteModel extends StatefulWidget {
  const TfliteModel({Key? key})
      : super(key: key);


  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  late User _user;

  List<Plant> plants = Plant.plantList;
  late File _image;
  late List _results;
  bool imageSelect=false;
  dynamic _highestConfidenceResult;
  @override
  void initState()
  {
    super.initState();
    loadModel();
  }
  Future loadModel()
  async {
    Tflite.close();
    String res;
    res=(await Tflite.loadModel(model: "assets/model.tflite",labels: "assets/labels.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image)
  async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

      setState(() {
        _results = recognitions!;
        _image = image;
        imageSelect = true;
        _results.sort((a, b) => b['confidence'].compareTo(.8));
        _highestConfidenceResult = _results[0];
      });



  }
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant Detector"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          (imageSelect)
              ? Container(
            margin: const EdgeInsets.all(10),
            child: Image.file(_image),
          )
              : Container(
            margin: const EdgeInsets.all(10),
            child: const Opacity(
              opacity: 0.8,
              child: Center(
                child: Text("No image selected"),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                if (imageSelect && _highestConfidenceResult != null)
                  Card(
                    child: InkWell(
                      onTap: () {
                        // Find the selected plant from the list
                        Plant? selectedPlant = plants.firstWhere(
                              (plant) => plant.plantName == _highestConfidenceResult['label'].split(" ")[0],
                          //orElse: () => null,
                        );

                        if (selectedPlant != null) {
                          // Navigate to the plant details screen
                          Navigator.push(context,
                              PageTransition(child: DetailPage(plantId: selectedPlant.plantId, user: FirebaseAuth.instance.currentUser!,),
                                  type: PageTransitionType.bottomToTop));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "${_highestConfidenceResult['label']} ${'\n'} ${"Detection Accuracy: "} ${(_highestConfidenceResult['confidence']*100).toStringAsFixed(2)}${"%"}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: "Pick Image",
        backgroundColor: Colors.green,
        child: const Icon(Icons.image),
      ),
    );
  }

  /*
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant Detector"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          (imageSelect )?Container(
            margin: const EdgeInsets.all(10),
            child: Image.file(_image),
          ):Container(
            margin: const EdgeInsets.all(10),
            child: const Opacity(
              opacity: 0.8,
              child: Center(
                child: Text("No image selected"),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: (imageSelect && _highestConfidenceResult != null)?_results.map((result) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.red,
                          fontSize: 20),
                    ),
                  ),
                );
              }).toList():[],

            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: "Pick Image",
        backgroundColor: Colors.green,
        child: const Icon(Icons.image),
      ),

    );
  }
  */

  Future pickImage()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image=File(pickedFile!.path);
    imageClassification(image);
  }
}