import 'package:flutter/material.dart';

import 'view/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'System to Enhance Plantation Drive',

      home: OnboardingScreen(),


      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
     // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}




