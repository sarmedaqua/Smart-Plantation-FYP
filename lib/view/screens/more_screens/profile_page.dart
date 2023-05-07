import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment_starter/staticfiles/constants.dart';
import 'package:assignment_starter/view/screens/more_screens/widgets/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: ExactAssetImage('assets/images/profile.jpg'),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Constants.primaryColor.withOpacity(.5),
                      width: 5.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * .3,
                  child: Row(
                    children: [
                      // Text(
                      //   '( ${_user.displayName!} )',
                      //   style: TextStyle(
                      //     color: Constants.blackColor,
                      //     fontSize: 20,
                      //   ),
                      // ),
                      SizedBox(
                          height: 24,
                          child: Image.asset("assets/images/verified.png")),
                    ],
                  ),
                ),
                Text(
                  '( ${_user.email!} )',
                  style: TextStyle(
                    color: Constants.blackColor.withOpacity(.3),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: size.height * .7,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: const [
                      // ProfileWidget(
                      //   icon: Icons.person,
                      //   title: 'My Profile',
                      //   opt_name: 'MyProfile',
                      // ),
                      // ProfileWidget(
                      //   icon: Icons.settings,
                      //   title: 'Settings',
                      //   opt_name: 'Settings',
                      // ),
                      // ProfileWidget(
                      //   icon: Icons.notifications,
                      //   title: 'Notifications',
                      //   opt_name: 'Notifications',
                      // ),
                      // ProfileWidget(
                      //   icon: Icons.chat,
                      //   title: 'FAQs',
                      //   opt_name: 'FAQs',
                      // ),
                      // ProfileWidget(
                      //   icon: Icons.share,
                      //   title: 'Share',
                      //   opt_name: 'Share',
                      //
                      // ),

                      ProfileWidget(
                        icon: Icons.logout,
                        title: '        Log Out',
                        opt_name: 'LOGOUT',
                      ),



                    ],

                  ),
                ),
              ],

            ),
          ),

        ));
  }
}