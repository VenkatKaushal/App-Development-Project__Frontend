import 'package:flutter/material.dart';
import 'dart:async';

import 'package:global_health_insights/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the AnalysisPage after 2 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => home_page()), // Change to your main page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Change to your preferred color
      body: Center(
        child: Text(
          'You can check your analysis by clicking on the analysis button',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
// void main() {
//   runApp(MaterialApp(
//     home: AnalysisPage(),
//   ));
// }
