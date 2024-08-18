import 'package:app_frontend/screens/home_page.dart';
import 'package:flutter/material.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {




  @override
  void dispose() {

    super.dispose();
  }



  void _validateAndSubmit() {

  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder( 
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB0BEC5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to ForgotPassword
            debugPrint('Back is pressed');
          },
          color: const Color.fromARGB(255, 11, 106, 14),
        ),
        title: const Text(
          'NutriGuide',
          style: TextStyle(
            color: Color.fromARGB(255, 11, 106, 14),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/assets/forgot_password.png"),

              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: _validateAndSubmit,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFB0BEC5),
                    foregroundColor: const Color.fromARGB(255, 11, 106, 14),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Update Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
