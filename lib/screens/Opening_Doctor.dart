import 'package:flutter/material.dart';
import 'package:global_health_insights/screens/Login_Screen.dart';
import 'package:global_health_insights/screens/basic_user_info.dart';
import 'package:global_health_insights/screens/forgot_password.dart';

import 'create_new_password.dart';

class OpeningDoctor extends StatelessWidget {
  const OpeningDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Image.asset("lib/assets/urbandoctors.gif"),
          SizedBox(height: 20),
          Text(
            'NutriGuide',
            style: TextStyle(
              fontSize: 32, // Size of the text
              fontWeight: FontWeight.bold, // Bold text
              color: Colors.white, // Text color
              letterSpacing: 2.0, // Space between letters
              wordSpacing: 5.0, // Space between words
              fontStyle: FontStyle.italic, // Italic text
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }, child: Text("Login")),
          SizedBox(height: 20),
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BasicUserInfo()),
            );
          }, child: Text("Signin")),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              // Navigate to the next page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPassword()),
              );
            },
            child: Text(
              'ForgotPassword?',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                decoration: TextDecoration.underline, // Optional: underline text
              ),
            ),
          ),
        ]
      ),
    );
  }
}
