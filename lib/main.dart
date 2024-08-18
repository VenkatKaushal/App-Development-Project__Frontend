import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'screens/Login_Screen.dart';
import 'screens/Opening_Doctor.dart';
import 'screens/basic_user_info.dart';
import 'screens/home_page.dart';


Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
          body: OpeningDoctor(),
          ),
      );
  }
}

