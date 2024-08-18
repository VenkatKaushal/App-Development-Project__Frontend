import 'package:flutter/material.dart';
// import 'global_data.dart'; // Ensure this file defines the UserData class
import 'package:app_frontend/global_data.dart';
class ProfilePage extends StatefulWidget {
  final UserData userData;

  ProfilePage({super.key, required this.userData});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    userData: widget.userData,
                    onProfileUpdated: (updatedProfile) {
                      setState(() {
                        // Update the existing instance directly
                        widget.userData.updateData(
                          userName: updatedProfile.userName ?? '',
                          email: updatedProfile.email ?? ' ',
                          password: updatedProfile.password ?? ' ',
                          age: updatedProfile.age ?? 0,
                          gender: updatedProfile.gender ?? '',
                          weight: updatedProfile.weight ?? 0.0,
                          height: updatedProfile.height ?? 0.0,
                        );
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                'User Name: ${widget.userData.userName}',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                'Age: ${widget.userData.age}',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                'Gender: ${widget.userData.gender ?? 'Not specified'}',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                'Weight: ${widget.userData.weight} kg',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                'Height: ${widget.userData.height} cm',
                style: TextStyle(fontSize: 30),
              ),
            ),
            // Other profile related widgets or functionality
          ],
        ),
      ),
    );
  }
}
// Ensure this file defines the UserData class
class EditProfilePage extends StatefulWidget {
  final UserData userData;
  final ValueChanged<UserData> onProfileUpdated;

  const EditProfilePage({
    super.key,
    required this.userData,
    required this.onProfileUpdated,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers and selectedGender
    userNameController.text = widget.userData.userName ?? '';
    emailController.text = widget.userData.email ?? '';
    passwordController.text = widget.userData.password ?? '';
    ageController.text = widget.userData.age?.toString() ?? '';
    weightController.text = widget.userData.weight?.toString() ?? '';
    heightController.text = widget.userData.height?.toString() ?? '';
    selectedGender = widget.userData.gender;
  }

  void _saveProfile() {
    final updatedProfile = UserData()
      ..updateData(
        userName: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
        age: int.tryParse(ageController.text) ?? widget.userData.age ?? 0,
        gender: selectedGender ?? '',
        weight: double.tryParse(weightController.text) ?? widget.userData.weight ?? 0.0,
        height: double.tryParse(heightController.text) ?? widget.userData.height ?? 0.0,
      );

    widget.onProfileUpdated(updatedProfile);
    Navigator.of(context).pop();
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
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFFB0BEC5),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: userNameController,
              decoration: InputDecoration(
                hintText: 'User Name',
                filled: true,
                fillColor: Colors.white,
                focusedBorder: border,
                enabledBorder: border,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Age',
                filled: true,
                fillColor: Colors.white,
                focusedBorder: border,
                enabledBorder: border,
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(
                hintText: 'Gender',
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
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Weight (KGs)',
                filled: true,
                fillColor: Colors.white,
                focusedBorder: border,
                enabledBorder: border,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Height (cm)',
                filled: true,
                fillColor: Colors.white,
                focusedBorder: border,
                enabledBorder: border,
              ),
            ),
            const SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

