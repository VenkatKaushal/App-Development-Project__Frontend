import 'package:flutter/material.dart';
import 'home_page.dart';
import 'sign_in.dart';

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

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

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
              // Ensure the email is a valid Gmail address
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
              // Ensure the password does not contain spaces
              if (value.contains(' ')) {
                return 'Password cannot contain spaces';
              }
              // Ensure the password is at least 7 characters long
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
                _formKey.currentState?.save();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => home_page()),
                );
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
