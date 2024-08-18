import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Log In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        elevation: 4.0,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text("Welcome", textAlign: TextAlign.left, style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                color: Colors.blue,
                letterSpacing: 0.5,
                height: 1.5,
              ),),
              Text("Welcome! Log in to start tracking your nutrients and achieve your health goals."),
              SizedBox(height: 50.0),
              LoginForm(),
              Image.asset("lib/assets/3dDoctor.png"),
            ],
          ),
        ),
      ),
    );
  }
}

final storage = FlutterSecureStorage();

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  Future<void> _login() async {
    final url = 'http://10.0.2.2:3000/api/auth/login'; // Replace with your IP address

    print('Attempting to login with email: $_email and password: $_password');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _email!,
          'password': _password!,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Debugging print statements
      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          final token = data['token'];

          if (token != null) {
            await storeToken(token);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const home_page()),
            );
          } else {
            _showErrorDialog('Invalid credentials');
          }
        } catch (e) {
          print('Error parsing response: $e');
          _showErrorDialog('An error occurred while processing the response.');
        }
      } else {
        _showErrorDialog('Login failed. Please try again.');
      }
    } catch (error) {
      print('Error: $error');
      _showErrorDialog('An error occurred. Please try again.');
    }
  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.lightBlueAccent,
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(value)) {
                return 'Please enter a valid Gmail address';
              }
              return null;
            },
            onSaved: (value) {
              _email = value;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.lightBlueAccent,
              labelText: 'Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.contains(' ')) {
                return 'Password cannot contain spaces';
              }
              if (value.length < 7) {
                return 'Password must be at least 7 characters long';
              }
              return null;
            },
            onSaved: (value) {
              _password = value;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save(); // Ensure this is called to save form data
                _login(); // Perform login after validation and saving
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  Future<void> storeToken(String token) async {
    var box = Hive.box('authBox');
    await box.put('jwtToken', token);
  }
}