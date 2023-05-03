import 'package:flutter/material.dart';
import 'package:assignment_starter/staticfiles/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:assignment_starter/view/screens/scan.dart';
import 'package:assignment_starter/view/screens/TfliteModel.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override



  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Constants.primaryColor.withOpacity(.15),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Constants.primaryColor,
                      ),
                    ),
                  ),

                ],
              )),
          Positioned(
            top: 100,
            right: 20,
            left: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(20),
              child: Center(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            PageTransition(child:  GreenBottomSheet(),
                                type: PageTransitionType.bottomToTop));
                      },
                      child: Image.asset(
                        'assets/images/code-scan.png',
                        height: 100,
                      ),
                    ),


                    const SizedBox(
                      height: 20,

                    ),
                    Text(
                      'Tap to Scan',
                      style: TextStyle(
                        color: Constants.primaryColor.withOpacity(.80),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),

                  ],

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class GreenBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      decoration: BoxDecoration(
        color: Constants.primaryColor.withOpacity(.90),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
        ),
      ),
      child: Column(

        children: [
          SizedBox(height: 500),

          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, PageTransition(child:  TfliteModel(), type: PageTransitionType.bottomToTop));
                },
                icon: Icon(
                  Icons.photo_library,
                  color: Colors.white,
                ),
                label: Text(
                  'Upload Picture',
                  style: TextStyle(color: Colors.white,),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, PageTransition(child:  Scan(), type: PageTransitionType.bottomToTop));
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                label: Text(
                  'Take a Picture',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}