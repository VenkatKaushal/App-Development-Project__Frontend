import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicUserInfo extends StatefulWidget {
  const BasicUserInfo({super.key});

  @override
  State<BasicUserInfo> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BasicUserInfo> {
  // Separate controllers for each TextField
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String? selectedGender;

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

  void _submitData() {
    final userName = userNameController.text;
    final age = int.tryParse(ageController.text);
    final gender = selectedGender;
    final weight = double.tryParse(weightController.text);
    final height = double.tryParse(heightController.text);

    if (age == null || age < 0 || age > 110) {
      _showErrorDialog('Age must be between 0 and 110.');
      return;
    }

    if (weight == null || weight < 0 || weight > 250) {
      _showErrorDialog('Weight must be between 0 and 250 KGs.');
      return;
    }

    if (height == null || height < 0 || height > 250) {
      _showErrorDialog('Height must be between 0 and 250 cm.');
      return;
    }


    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submitted Data'),
        content: Text(
          'User Name: $userName\nAge: $age\nGender: $gender\nWeight: $weight kg\nHeight: $height cm',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(5),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 134, 167, 190),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB0BEC5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
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
        padding: const EdgeInsets.all(16.0), // Padding around the column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: userNameController,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Please enter your User Name',
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: border,
                enabledBorder: border,
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0), // Spacing between text fields
            TextField(
              controller: ageController,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Please enter your Age',
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: border,
                enabledBorder: border,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(
                hintText: 'Please select your Gender',
                hintStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: border,
                enabledBorder: border,
              ),
              items: ['Male', 'Female'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: weightController,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Please enter your weight in KGs',
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: border,
                enabledBorder: border,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: heightController,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Please enter your height in cm',
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: border,
                enabledBorder: border,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 32.0,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
