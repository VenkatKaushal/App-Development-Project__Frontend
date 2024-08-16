import 'package:app_frontend/screens/home_page.dart';
import 'package:flutter/material.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool obt = true;
  bool obt2 = true;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
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

  void _validateAndSubmit() {
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
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>home_page()),
      );
    // Handle password update logic here

    // You can navigate to another page or display a success message
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
