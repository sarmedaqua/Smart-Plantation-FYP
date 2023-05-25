import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment_starter/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tflite/tflite.dart';
import '../../Domain/plants.dart';
import 'more_screens/detail_page.dart';

class Scan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key,
    //required User user
  })
      //: _user = user,
      :  super(key: key);

  //final User _user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //late User _user;
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  bool camera_on = false;
  List<Plant> pl = Plant.plantList;
  Plant? currentPlant;

  loadmodel() async {
    await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt");
  }

  loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
          cameraController!.startImageStream((imageStream) {
            if (!camera_on)
            {
              camera_on = !camera_on;
              cameraImage = imageStream;
              runModel();
            }
          });
        });
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true);

      output = '';
      predictions!.forEach((prediction) {
        if (prediction['confidence'] > 0.97) {
          output +=
              prediction['label'].toString().substring(0, 1).toUpperCase() +
                  prediction['label'].toString().substring(1) +
                  '\n'+
                  "Detection accuracy: " +
                  ((prediction['confidence'])*100 as double).toStringAsFixed(3) + "%"+
                  '\n';
          // Get the plant matching the detected label
          String label = prediction['label'];
          setState(() {
            currentPlant = pl.firstWhere(
                    (plan) => plan.plantName.toLowerCase() == label.split(" ")[0].toString().toLowerCase(),
                //orElse: () => null
            );
          });
        }
      });

      setState(() {
        output = output;
      });
      camera_on = false;
    }
  }

  @override
  void initState() {
    //_user = widget._user;

    super.initState();
    loadCamera();
    loadmodel();
  }
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Plant Detector'), backgroundColor: Colors.green, ),
      body: Column(children: [
        SizedBox(
          height: 15,
        ),
        Text(
          "Tap when detection is accurate",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
          GestureDetector(
          onTap: () {

        // Navigate to new screen
        Navigator.push(context,
            PageTransition(child: DetailPage(plantId: currentPlant!.plantId, user: FirebaseAuth.instance.currentUser!,),
                type: PageTransitionType.bottomToTop));
          },
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: !cameraController!.value.isInitialized
                    ? Container()
                    : AspectRatio(
                  aspectRatio: cameraController!.value.aspectRatio,
                  child: CameraPreview(cameraController!),
                ),
              ),
            ),
          ),
        Text(
          output,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
      ),
    );
  }
}
