import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'create_new_password.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _userIdController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _validateAndNavigate() {
    final dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

    if (_userIdController.text.isEmpty || _dobController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!emailRegex.hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address.'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!dateRegex.hasMatch(_dobController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid date in DD-MM-YYYY format.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      final inputDate = DateFormat('dd-MM-yyyy').parse(_dobController.text);
      final maxDate = DateTime(2024, 07, 31);

      if (inputDate.isAfter(maxDate)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The date must be on or before 31-July-2024.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateNewPassword()),
        );
        debugPrint('Navigation to Create New Password');
      }
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
                  controller: _userIdController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter your UserId',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.mail),
                    prefixIconColor: Colors.black,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _dobController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Date of Birth (DD-MM-YYYY)',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.date_range),
                    prefixIconColor: Colors.black,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'\d|-')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
              ),
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
                child: TextButton(
                  onPressed: _validateAndNavigate,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFB0BEC5),
                    foregroundColor: const Color.fromARGB(255, 11, 106, 14),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Click here to Forgot'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
