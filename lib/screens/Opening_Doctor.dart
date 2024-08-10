import 'package:flutter/material.dart';

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
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0), // Position of shadow
                  blurRadius: 3.0, // Blur effect of shadow
                  color: Colors.black.withOpacity(0.5), // Color of shadow
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: (){}, child: Text("Login")),
          SizedBox(height: 20),
          ElevatedButton(onPressed: (){}, child: Text("Signin")),
        ]
      ),
    );
  }
}
