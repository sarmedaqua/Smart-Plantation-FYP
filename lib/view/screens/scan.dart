import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:assignment_starter/main.dart';
import 'package:tflite/tflite.dart';


class Scan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  bool camera_on = false;

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

        if(prediction['confidence']>0.97) {
          output +=
              prediction['label'].toString().substring(0, 1).toUpperCase() +
                  prediction['label'].toString().substring(1) +
                  " " +
                  (prediction['confidence'] as double).toStringAsFixed(3) +
                  '\n';
        }
      }
      // predictions!.forEach((element) {
      //   setState(() {
      //     output = element['label'];
      //   });
      // }





      );

      setState(() {
        output = output;
      });
      camera_on = false;

    }
  }

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadmodel();
  }

  // @override
  // void dispose() async {
  //   super.dispose();
  //
  //   await Tflite.close();
  //   cameraController!.dispose();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plant Detector'), backgroundColor: Colors.green, ),
      body: Column(children: [
        Padding(
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
        Text(
          output,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )
      ]),
    );
  }
}