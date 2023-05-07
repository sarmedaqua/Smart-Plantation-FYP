import 'package:flutter/material.dart';
import 'package:assignment_starter/staticfiles//constants.dart';
import '../../../../utils/authentication.dart';
import '../signin_page.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String opt_name;

  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.opt_name

  }) : super(key: key);

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignIn(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  String gesture_action (String opt_name, BuildContext context) {
    if(opt_name == 'LOGOUT'){
      Authentication.signOut(context: context);
      Navigator.of(context).pushReplacement(_routeToSignInScreen());
    }
    return opt_name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Constants.blackColor.withOpacity(.5),
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              GestureDetector(
                  onTap: () async {
                    await gesture_action(opt_name, context);
                  }

                  ),
              Text(
                title,
                style: TextStyle(
                  color: Constants.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Constants.blackColor.withOpacity(.4),
            size: 16,
          )
        ],
      ),
    );
  }
}