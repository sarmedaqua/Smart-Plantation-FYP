import 'dart:developer';
import 'dart:io';

import 'package:assignment_starter/view/screens/more_screens/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assignment_starter/staticfiles/constants.dart';
import 'package:assignment_starter/view/screens/more_screens/widgets/profile_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/authentication.dart';
import '../../../widgets/custom_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

   File? profilePic;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [

            SizedBox(height: 20,),
            Column(

              children: [
                Center(child: _getProfilePicture()),
                SizedBox(height: 20,),
                _getEmailAndTick(context),
                SizedBox(height: 20,),
                _getAllButtons(context),
              ],
            ),


          ],
        ),
      ),


    );

  }

  void _gestureAction(String opt_name, BuildContext context) {
    if(opt_name == 'LOGOUT'){
      Authentication.signOut(context: context);
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          CustomColors.firebaseOrange,
        ),
      );
      const snackBar = SnackBar(
        content: Text('Logged OUT!'),
      );

      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => SignIn()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

//get Logout button
Widget _getAllButtons(BuildContext context) {
    return Column(
      children: [

    ListTile(
      onTap: () {
        _gestureAction("LOGOUT", context);
      },
    leading: Icon(
    FontAwesomeIcons.user, // Replace with desired Font Awesome icon
      color: Colors.grey,
    ),
    title: Text(
    'Logout',
    style: GoogleFonts.roboto(
    textStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    ),),

      ],
    );
}

//get email and green tick
  Widget _getEmailAndTick(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.25),
      child: Row(

        children: [
        Center(child: Text('${widget._user.email!} ')),
        SizedBox(width: 10,),
        SizedBox(
            height: 24,
            child: Image.asset("assets/images/verified.png")),


      ],),
    );
  }




  //profile image
  Widget _getProfilePicture() {
    return Container(
      width: 118,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: (profilePic != null) ? FileImage(profilePic!) : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () async {
                // Handle button press
                XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);


                if (selectedImage != null) {
                  File convertedFile = File(selectedImage.path);
                  setState(() {
                    profilePic = convertedFile;
                  });
                  log("ImageSelected");
                }
                else {

                }
              },
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Constants.primaryColor.withOpacity(.5),
          width: 5.0,
        ),
      ),
    );
  }
}