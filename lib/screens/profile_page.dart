import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Opening_Doctor.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    var box = await Hive.openBox('authBox');
    String? token = box.get('jwtToken');

    if (token == null) {
      _showErrorDialog('Authorization token not found. Please log in again.');
      return;
    }

    try {
      print("Token: $token");
      final response = await http.put(
        Uri.parse('https://app-development-project-backend.onrender.com/api/auth/profile'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': '$token',
        },
      );

      if (response.statusCode == 200) {
        final profileData = json.decode(response.body);
        setState(() {
          userNameController.text = profileData['username'];
          ageController.text = profileData['profile']['age']?.toString() ?? '';
          selectedGender = profileData['profile']['gender'] ?? '';
          weightController.text = profileData['profile']['weight']?.toString() ?? '';
          heightController.text = profileData['profile']['height']?.toString() ?? '';
        });
      } else {
        _showErrorDialog('Failed to load profile. Please try again.');
      }
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again. $e');
    }
  }

  Future<void> updateUserProfile() async {
    var box = await Hive.openBox('authBox');
    String? token = box.get('jwtToken');

    if (token == null) {
      _showErrorDialog('Authorization token not found. Please log in again.');
      return;
    }

    try {
      final response = await http.put(
        Uri.parse('https://app-development-project-backend.onrender.com/api/auth/profile'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': '$token',
        },
        body: json.encode({
          'username': userNameController.text,
          'age': int.tryParse(ageController.text),
          'gender': selectedGender,
          'weight': double.tryParse(weightController.text),
          'height': double.tryParse(heightController.text),
        }),
      );

      if (response.statusCode == 200) {
        _showSuccessDialog('Profile updated successfully.');
      } else {
        _showErrorDialog('Failed to update profile.');
      }
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again. $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
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

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
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
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: border,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: border,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: border,
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
                decoration: InputDecoration(
                  labelText: 'Weight (KG)',
                  border: border,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: heightController,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  border: border,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: updateUserProfile,
                  child: const Text('Update Profile'),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    //logout();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => OpeningDoctor()),
                    );
                  },
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }
}






// // Ensure this file defines the UserData class
// class EditProfilePage extends StatefulWidget {
//   final UserData userData;
//   final ValueChanged<UserData> onProfileUpdated;
//
//   const EditProfilePage({
//     super.key,
//     required this.userData,
//     required this.onProfileUpdated,
//   });
//
//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }
//
// class _EditProfilePageState extends State<EditProfilePage> {
//   TextEditingController userNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController weightController = TextEditingController();
//   TextEditingController heightController = TextEditingController();
//   String? selectedGender;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the controllers and selectedGender
//     userNameController.text = widget.userData.userName ?? '';
//     ageController.text = widget.userData.age?.toString() ?? '';
//     weightController.text = widget.userData.weight?.toString() ?? '';
//     heightController.text = widget.userData.height?.toString() ?? '';
//     selectedGender = widget.userData.gender;
//   }
//
//   void _saveProfile() {
//     final updatedProfile = UserData()
//       .updateData(
//         userName: userNameController.text,
//         email: emailController.text,
//         age: int.tryParse(ageController.text) ?? widget.userData.age ?? 0,
//         gender: selectedGender ?? '',
//         weight: double.tryParse(weightController.text) ?? widget.userData.weight ?? 0.0,
//         height: double.tryParse(heightController.text) ?? widget.userData.height ?? 0.0, password: '',
//       );
//
//     widget.onProfileUpdated(updatedProfile);
//     Navigator.of(context).pop();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final border = OutlineInputBorder(
//       borderSide: const BorderSide(
//         width: 2.0,
//         style: BorderStyle.solid,
//       ),
//       borderRadius: BorderRadius.circular(5),
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//         backgroundColor: const Color(0xFFB0BEC5),
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: userNameController,
//               decoration: InputDecoration(
//                 hintText: 'User Name',
//                 filled: true,
//                 fillColor: Colors.white,
//                 focusedBorder: border,
//                 enabledBorder: border,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             TextField(
//               controller: ageController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: 'Age',
//                 filled: true,
//                 fillColor: Colors.white,
//                 focusedBorder: border,
//                 enabledBorder: border,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             DropdownButtonFormField<String>(
//               value: selectedGender,
//               decoration: InputDecoration(
//                 hintText: 'Gender',
//                 filled: true,
//                 fillColor: Colors.white,
//                 focusedBorder: border,
//                 enabledBorder: border,
//               ),
//               items: ['Male', 'Female'].map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (newValue) {
//                 setState(() {
//                   selectedGender = newValue;
//                 });
//               },
//             ),
//             const SizedBox(height: 16.0),
//             TextField(
//               controller: weightController,
//               keyboardType: TextInputType.numberWithOptions(decimal: true),
//               decoration: InputDecoration(
//                 hintText: 'Weight (KGs)',
//                 filled: true,
//                 fillColor: Colors.white,
//                 focusedBorder: border,
//                 enabledBorder: border,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             TextField(
//               controller: heightController,
//               keyboardType: TextInputType.numberWithOptions(decimal: true),
//               decoration: InputDecoration(
//                 hintText: 'Height (cm)',
//                 filled: true,
//                 fillColor: Colors.white,
//                 focusedBorder: border,
//                 enabledBorder: border,
//               ),
//             ),
//             const SizedBox(height: 32.0),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _saveProfile,
//                 child: const Text('Save'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
