import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment_starter/staticfiles/constants.dart';
import 'package:assignment_starter/view/screens/more_screens/widgets/custom_textfield.dart';
import 'signin_page.dart';
import 'package:page_transition/page_transition.dart';
import '../../../widgets/reusable_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>{

  TextEditingController _emailTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/reset-password.png'),
              const Text(
                'Forgot\nPassword',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              reusableTextField("Enter Email Id", Icons.person_outline, false,
                  _emailTextController),
              const SizedBox(
                height: 30,
              ),
              firebaseUIButton(context, "Reset Password", () {
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: _emailTextController.text)
                    .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn())));
              }),

              // const CustomTextfield(
              //   obscureText: false,
              //   hintText: 'Enter Email',
              //   icon: Icons.alternate_email,
              // ),
              // GestureDetector(
              //   onTap: () {},
              //   child: Container(
              //     width: size.width,
              //     decoration: BoxDecoration(
              //       color: Constants.primaryColor,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     padding:
              //     const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              //     child: const Center(
              //       child: Text(
              //         'Reset Password',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 18.0,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const SignIn(),
                          type: PageTransitionType.bottomToTop));
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'Have an Account? ',
                        style: TextStyle(
                          color: Constants.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Constants.primaryColor,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}