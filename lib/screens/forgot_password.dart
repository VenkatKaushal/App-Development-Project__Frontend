import 'dart:convert';

import 'package:app_frontend/screens/Opening_Doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'create_new_password.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool obt = true;
  bool obt2 = true;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid Input'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _validateAndNavigate() async {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showErrorDialog('Please enter your new password and confirm it.');
      return;
    }

    if (newPassword.length < 7 || newPassword.contains(' ')) {
      _showErrorDialog('Password must be at least 7 characters long and contain no spaces.');
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final email = _emailController.text;
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Prepare the request payload
    final payload = json.encode({
      'email': email,
      'password': newPassword,
    });

    // Send the PUT request
    try {
      final response = await http.put(
        Uri.parse('https://app-development-project-backend.onrender.com/api/auth/forget'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: payload,
      );

      if (response.statusCode == 200) {
        // Password updated successfully
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OpeningDoctor()),
        );
      } else {
        // Handle errors from the backend
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update password: ${response.reasonPhrase}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
            Navigator.pop(context);
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
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter your Email',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.black,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _newPasswordController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  obscureText: obt,
                  decoration: InputDecoration(
                    hintText: 'Enter Your New Password',
                    hintStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.password_sharp),
                    prefixIconColor: Colors.black,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obt = !obt;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                    suffixIconColor: Colors.black,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _confirmPasswordController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  obscureText: obt2,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.password_sharp),
                    prefixIconColor: Colors.black,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obt2 = !obt2;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                    suffixIconColor: Colors.black,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: _validateAndNavigate,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFB0BEC5),
                    foregroundColor: const Color.fromARGB(255, 11, 106, 14),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Click here to Update Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
