import 'package:assignment_starter/view/screens/root_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'view/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool loggedIn = FirebaseAuth.instance.currentUser != null;
  cameras = await availableCameras();
  runApp(MaterialApp(
    title: 'Smart Plantation',
    home: loggedIn ? RootPage(user: FirebaseAuth.instance.currentUser!): OnboardingScreen(),
  ));
}