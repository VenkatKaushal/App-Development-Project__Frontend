import 'package:app_frontend/daily_nutrients.dart';
import 'package:app_frontend/global_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:global_health_insights/screens/analysis_page.dart';
import 'Login_Screen.dart';
import 'Suggestions.dart';
import 'profile_page.dart';
import 'Nutricalcfinal.dart';
import 'analysis_page.dart';
import 'package:app_frontend/required_nutrition.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class home_page extends StatefulWidget {
  const home_page({super.key});
  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Nutricalc()),
        );
        break;
    // case 1:
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => CalculatorPage()),
    //   );
    //   break;
    // case 2:
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => SettingsPage()),
    //   );
    //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: const Color.fromARGB(255, 120, 119, 119),
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'NutriGuide',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 41, 192, 46),
          ),
        ),
        centerTitle: true, // This centers the title in the AppBar
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              children: [
                Image.asset("lib/assets/Note.png",height: 50, width: 50),
                SizedBox(width: 10,),
                Text("We are so happy to see you again !!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),),
              ],
            ),
            DynamicCardView(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> SuggestionsPage())
                        );
                      },
                      child: Text('Suggestions'),
                    ),
                  ),
                  SizedBox(width: 10), // Optional spacing between buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AnalysisPage()),
                        );
                      },
                      child: Text('Analysis'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: WaterWidget(),
                  ),
                  SizedBox(width: 10), // Optional spacing between button
                  Expanded(
                    child: ExerciseWidget(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh),
            label: 'Load Page',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}


class ProfileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(width: 8),
        Text(
          'Hi, \nUser Name',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        SizedBox(width: 10),
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage('https://example.com/your-image-url.jpg'),
        ),
      ],
    );
  }
}


class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  final PageController _pageController = PageController();
  NutritionData nutritionData = NutritionData();
  RequiredNutritionData requiredNutritionData = RequiredNutritionData();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Macros',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMacroColumn('Carbohydrates', 55, 76, Colors.teal),
                  _buildMacroColumn('Fat', (nutritionData.dailyFat)?.toDouble()?? 0, requiredNutritionData.requiredFat ?? 0, Colors.purple),
                  _buildMacroColumn('Protein', nutritionData.dailyProtein?? 0, requiredNutritionData.requiredProtein ?? 0, Colors.orange),
                ],
              ),
              SizedBox(height: 16),
              _buildDotsIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroColumn(String name, num current, num total, Color color) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                value: current.toDouble(),
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation(color),
                backgroundColor: color.withOpacity(0.2),
              ),
            ),
            Text(
              '$current/\n$total\ng',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text('${total - current}g left'),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(Colors.blue),
        _buildDot(Colors.grey),
        _buildDot(Colors.grey),
      ],
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class WaterWidget extends StatefulWidget {
  const WaterWidget({super.key});

  @override
  State<WaterWidget> createState() => _WaterWidgetState();
}

class _WaterWidgetState extends State<WaterWidget> {
  int _waterLiters = 0;

  void _increaseWater(){
    setState(() {
      _waterLiters++;
    });
  }

  void _decreaseWater(){
    setState(() {
      _waterLiters--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.local_drink, size: 40, color: Colors.blue),
          SizedBox(height: 8),
          Text(
            'Water Intake',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            '$_waterLiters L',
            style: TextStyle(fontSize: 24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.remove, color: Colors.red),
                  onPressed: () {
                    if (_waterLiters > 0) {
                      _decreaseWater();
                    }
                  }
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.green),
                onPressed: () {
                  if (_waterLiters < 11) {
                    _increaseWater();
                  }
                },
              ),
            ],
          ),

        ],
      ),
    );
  }
}


class ExerciseWidget extends StatefulWidget {
  const ExerciseWidget({super.key});

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  int _workoutHours = 0;

  void _increaseWorkout() {
    setState(() {
      if(_workoutHours <= 24)_workoutHours++;
    });
  }

  void _decreaseWorkout() {
    setState(() {
      _workoutHours--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.local_drink, size: 40, color: Colors.blue),
          SizedBox(height: 8),
          Text(
            'Workout Hours',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            '$_workoutHours H',
            style: TextStyle(fontSize: 24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove, color: Colors.red),
                onPressed: () {
                  if (_workoutHours > 0) {
                    _decreaseWorkout();
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.green),
                onPressed: () {
                  if (_workoutHours < 9) {
                    _increaseWorkout();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class DynamicCardView extends StatefulWidget {
  const DynamicCardView({super.key});

  @override
  State<DynamicCardView> createState() => _DynamicCardViewState();
}

class _DynamicCardViewState extends State<DynamicCardView> {
  Future<Map<String, int>> _fetchNutritionData() async {
    var box = await Hive.openBox('authBox');
    String? token = box.get('jwtToken');

    if (token == null) {
      _showErrorDialog('Authorization token not found. Please log in again.');
      throw Exception('Authorization token not found.');
    }

    final userResponse = await http.put(
      Uri.parse('https://app-development-project-backend.onrender.com/api/auth/profile'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': '$token',
      },
    );

    if (userResponse.statusCode == 200) {
      final profileData = json.decode(userResponse.body);
      int age = profileData['profile']['age'];
      String gender = profileData['profile']['gender'];
      String ageGroup = getAgeGroup(age);

      final dailyResponse = await http.get(
        Uri.parse('https://app-development-project-backend.onrender.com/api/nutrients/daily'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': '$token',
        },
      );
      print("Response: ${dailyResponse.body}");
      print("DailyResponse: ${dailyResponse.statusCode}");

      final nutrients = ['Protein', 'Carbohydrates', 'Fats'];
      final standardResponses = await Future.wait(
        nutrients.map((nutrient) async {
          final standardResponse = await http.post(
            Uri.parse('https://app-development-project-backend.onrender.com/api/standard/nutritional-values'),
            headers: {
              'Content-Type': 'application/json',
              'x-auth-token': '$token',
            },
            body: json.encode({
              'age': ageGroup,
              'gender': gender,
              'nutrient': nutrient,
            }),
          );

          if (standardResponse.statusCode == 200) {
            final standardData = json.decode(standardResponse.body);
            return MapEntry(
              nutrient.toLowerCase(),
              standardData['value'] ?? 0,
            );
          } else {
            return MapEntry(nutrient.toLowerCase(), 0);
          }
        }),
      );

      final nutrientMap = Map.fromEntries(standardResponses);

      int dailyCarbohydrates = 0;
      int dailyFat = 0;
      int dailyProtein = 0;

      if (dailyResponse.statusCode == 200) {
        final dailyData = jsonDecode(dailyResponse.body);
        final dailyNutrients = dailyData['dailyNutrients'] as List<dynamic>;

        for (var nutrient in dailyNutrients) {
          final String nutrientName = nutrient['name'];
          final double amount = nutrient['amount'].toDouble();
          if (nutrientName == "Carbohydrate, by difference") {
            dailyCarbohydrates = amount.toInt();
          } else if (nutrientName == "Total lipid (fat)") {
            dailyFat = amount.toInt();
          } else if (nutrientName == "Protein") {
            dailyProtein = amount.toInt();
          }
        }
      }

      return {
        'carbohydrates': dailyCarbohydrates,
        'fat': dailyFat,
        'protein': dailyProtein,
        'requiredCarbohydrates': nutrientMap['carbohydrates'] ?? 0,
        'requiredFat': nutrientMap['fats'] ?? 0,
        'requiredProtein': nutrientMap['protein'] ?? 0,
      };
    } else {
      throw Exception('Failed to load user profile.');
    }
  }

  String getAgeGroup(int age) {
    if (age >= 1 && age <= 3) return '1-3 years';
    if (age >= 4 && age <= 8) return '4-8 years';
    if (age >= 9 && age <= 13) return '9-13 years';
    if (age >= 14 && age <= 18) return '14-18 years';
    if (age >= 19 && age <= 50) return '19-50 years';
    return '51+ years';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: _fetchNutritionData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        } else {
          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Macros',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMacroColumn(
                          'Carbohydrates',
                          data['carbohydrates'] ?? 0,
                          data['requiredCarbohydrates'] ?? 0,
                          Colors.teal,
                        ),
                        _buildMacroColumn(
                          'Fat',
                          data['fat'] ?? 0,
                          data['requiredFat'] ?? 0,
                          Colors.purple,
                        ),
                        _buildMacroColumn(
                          'Protein',
                          data['protein'] ?? 0,
                          data['requiredProtein'] ?? 0,
                          Colors.orange,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildDotsIndicator(),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildMacroColumn(String name, num current, num total, Color color) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                value: total > 0 ? current / total : 0,
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation(color),
                backgroundColor: color.withOpacity(0.2),
              ),
            ),
            Text(
              '$current/\n$total\ng',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text('${total - current}g left'),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(Colors.blue),
      ],
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
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
}
