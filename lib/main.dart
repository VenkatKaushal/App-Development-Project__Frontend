import 'package:flutter/material.dart';
import 'package:global_health_insights/screens/Login_Screen.dart';
import 'package:global_health_insights/screens/Opening_Doctor.dart';
import 'package:global_health_insights/screens/basic_user_info.dart';
import 'package:global_health_insights/screens/home_page.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
          body: OpeningDoctor(),
          ),
      );
  }
}

