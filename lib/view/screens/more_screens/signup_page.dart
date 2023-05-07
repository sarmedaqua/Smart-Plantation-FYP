import 'package:assignment_starter/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment_starter/staticfiles/constants.dart';
import 'package:provider/provider.dart';
import '../../../services/firebase_auth_methods.dart';
import 'package:assignment_starter/view/screens/root_page.dart';
import 'package:assignment_starter/view/screens/more_screens/widgets/custom_textfield.dart';
import 'signin_page.dart';
import 'package:page_transition/page_transition.dart';
import '../../../widgets/reusable_widget.dart';



//final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();


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
              Image.asset('assets/images/signup.png'),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // CustomTextfield(
              //   obscureText: false,
              //   hintText: 'Enter Email',
              //   icon: Icons.alternate_email,
              //   controller: _emailTextController,
              // ),
              reusableTextField("Enter Email Id", Icons.alternate_email, false,
                  _emailTextController),

              const SizedBox(
                height: 20,
              ),
              // const CustomTextfield(
              //   obscureText: false,
              //   hintText: 'Enter Full name',
              //   icon: Icons.person,
              // ),
              // CustomTextfield(
              //   obscureText: true,
              //   hintText: 'Enter Password',
              //   icon: Icons.lock,
              //   controller: _passwordTextController,
              // ),

              reusableTextField("Enter Password", Icons.lock, true,
                  _passwordTextController),

              const SizedBox(
                height: 20,
              ),

              firebaseUIButton(context, "Sign Up", () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text)
                    .then((value) {
                  print("Created New Account");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              }),

              GestureDetector(

                onTap: () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailTextController.text.toString(),
                      password: _passwordTextController.text.toString())
                      .then((value) {
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RootPage(user: value.user!)));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                },
                child: Container(
                  width: size.width,


                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('OR'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Constants.primaryColor),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Image.asset('assets/images/google.png'),
                    ),
                    Text(
                      'Sign Up with Google',
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushReplacement(
              //         context,
              //         PageTransition(
              //             child: const SignIn(),
              //             type: PageTransitionType.bottomToTop));
              //   },
              //   child: Center(
              //     child: Text.rich(
              //       TextSpan(children: [
              //         TextSpan(
              //           text: 'Have an Account? ',
              //           style: TextStyle(
              //             color: Constants.blackColor,
              //           ),
              //         ),
              //         TextSpan(
              //           text: 'Login',
              //           style: TextStyle(
              //             color: Constants.primaryColor,
              //           ),
              //         ),
              //       ]),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}