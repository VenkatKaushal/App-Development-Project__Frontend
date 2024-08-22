import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'dart:async';

class AnalysisPage extends StatefulWidget {
  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  Map<String, dynamic> requiredNutritionData = {};
  Map<String, dynamic> nutritionData = {};
  Map<String, dynamic> deficitData = {};
  var requiredTotalNutrition;
  final dailyTotalNutrition = List<double>.filled(7, 0);
  int weekday = 0;
  late double maxNutrientValue;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchData();
    final now = DateTime.parse(DateTime.now().toString());
    weekday = now.weekday;
    _timer = Timer.periodic(Duration(minutes: 5), (Timer t) => fetchData());
    maxNutrientValue = dailyTotalNutrition.reduce((a, b) => a > b? a : b);
    requiredTotalNutrition = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      var box = await Hive.openBox('authBox');
      String? token = box.get('jwtToken');

      if (token == null) {
        _showErrorDialog('Authorization token not found. Please log in again.');
        throw Exception('Authorization token not found.');
      }
      
      final userResponse = await http.put(
        Uri.parse(
            'https://app-development-project-backend.onrender.com/api/auth/profile'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': '$token',
        },
      );

      if (userResponse.statusCode != 200) {
        throw Exception('Failed to load user profile.');
      }
      final profileData = json.decode(userResponse.body);
      int age = profileData['profile']['age'];
      String gender = profileData['profile']['gender'];
      String ageGroup = getAgeGroup(age);

      // Fetch daily nutrients data
      final dailyResponse = await http.get(
        Uri.parse(
            'https://app-development-project-backend.onrender.com/api/nutrients/daily'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': '$token',
        },
      );

      if (dailyResponse.statusCode != 200) {
        throw Exception('Failed to load daily nutrients data.');
      }
      final dailyData = json.decode(dailyResponse.body);
      final dailyNutrients = dailyData['dailyNutrients'] as List<dynamic>;

      Map<String, double> dailyNutrientMap = {
        'protein': 0,
        'carbohydrates': 0,
        'fats': 0,
        'fiber': 0,
        'calcium': 0,
        'iron': 0,
      };

      for (var nutrient in dailyNutrients) {
        final String nutrientName = nutrient['name'];
        final double amount = nutrient['amount'].toDouble();
        if (nutrientName == "Protein") {
          dailyNutrientMap['protein'] = amount;
        } else if (nutrientName == "Carbohydrate, by difference") {
          dailyNutrientMap['carbohydrates'] = amount;
        } else if (nutrientName == "Total lipid (fat)") {
          dailyNutrientMap['fats'] = amount;
        } else if (nutrientName == "Dietary Fiber") {
          dailyNutrientMap['fiber'] = amount;
        } else if (nutrientName == "Calcium, Ca") {
          dailyNutrientMap['calcium'] = amount;
        } else if (nutrientName == "Iron, Fe") {
          dailyNutrientMap['iron'] = amount;
        }
      }

      final nutrients = [
        'Protein',
        'Carbohydrates',
        'Fats',
        'Fiber',
        'Calcium',
        'Iron'
      ];
      final standardResponses = await Future.wait(
        nutrients.map((nutrient) async {
          final standardResponse = await http.post(
            Uri.parse(
                'https://app-development-project-backend.onrender.com/api/standard/nutritional-values'),
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

      setState(() {
        requiredNutritionData = {
          'protein': nutrientMap['protein'] ?? 0,
          'carbohydrates': nutrientMap['carbohydrates'] ?? 0,
          'fats': nutrientMap['fats'] ?? 0,
          'fiber': nutrientMap['fiber'] ?? 0,
          'calcium': nutrientMap['calcium'] ?? 0,
          'iron': nutrientMap['iron'] ?? 0,
        };
        requiredTotalNutrition = (nutrientMap['protein'] ?? 0) * 4 +
            (nutrientMap['carbohydrates'] ?? 0) * 4 +
            (nutrientMap['fats']?? 0) +
            (nutrientMap['calcium'] ?? 0) / 1000 +
            (nutrientMap['iron'] ?? 0) / 1000 +
            (nutrientMap['fiber'] ?? 0) * 2;
        });

        dailyTotalNutrition[weekday] = (dailyNutrientMap['protein'] ?? 0) * 4 +
          (dailyNutrientMap['carbohydrates'] ?? 0) * 4 +
          (dailyNutrientMap['fats'] ?? 0) +
          (dailyNutrientMap['calcium'] ?? 0) / 1000 +
          (dailyNutrientMap['iron'] ?? 0) / 1000 +
           (dailyNutrientMap['fiber'] ?? 0) * 2;
        nutritionData = dailyNutrientMap;
        deficitData = calculateDeficit(requiredNutritionData, nutritionData);


    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Map<String, dynamic> calculateDeficit(Map<String, dynamic> required,
      Map<String, dynamic> intake) {
    Map<String, dynamic> deficit = {};
    required.forEach((key, value) {
      if (key == "calcium" || key == "iron") {
        ((intake[key] ?? 0) / 1000)-value > 0 ? deficit[key] = 0 : deficit[key] = value - ((intake[key] ?? 0) / 1000);
      }
      else {
        (intake[key] ?? 0) - value > 0 ? deficit[key] = 0 : deficit[key] = value - (intake[key] ?? 0);
      }
    });
    return deficit;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = [
      FlSpot(0, requiredTotalNutrition.toDouble() ?? 0),
      FlSpot(1, (requiredTotalNutrition.toDouble() ?? 0) + 10),  // Example variation
      FlSpot(2, (requiredTotalNutrition.toDouble() ?? 0) + 20),  // Example variation
      FlSpot(3, (requiredTotalNutrition.toDouble() ?? 0) + 30),  // Example variation
      FlSpot(4, (requiredTotalNutrition.toDouble() ?? 0) + 40),  // Example variation
      FlSpot(5, (requiredTotalNutrition.toDouble() ?? 0) + 50),  // Example variation
      FlSpot(6, (requiredTotalNutrition.toDouble() ?? 0) + 60),  // Example variation
    ];

    final List<FlSpot> spots1 = [
      FlSpot(0, (dailyTotalNutrition[0] ?? 0) + 0),
      FlSpot(1, (dailyTotalNutrition[1] ?? 0) + 10),  // Example variation
      FlSpot(2, (dailyTotalNutrition[2] ?? 0) + 20),  // Example variation
      FlSpot(3, (dailyTotalNutrition[3] ?? 0) + 30),  // Example variation
      FlSpot(4, (dailyTotalNutrition[4] ?? 0) + 40),  // Example variation
      FlSpot(5, (dailyTotalNutrition[5] ?? 0) + 50),  // Example variation
      FlSpot(6, (dailyTotalNutrition[6] ?? 0) + 60),  // Example variation
    ];
    // Show a loading indicator while data is being fetched
    if (requiredNutritionData.isEmpty || nutritionData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Analysis Page'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Page'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              fetchData(); // Manually refresh the data
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(show: true),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: (maxNutrientValue.toDouble() ?? 0) + 2600,
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: false,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: FlDotData(show: true),  // Show plot points
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: spots1,
                        isCurved: false,
                        color: Colors.red,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildHeaderCell('Nutrient'),
                          buildHeaderCell('Required'),
                          buildHeaderCell('Yours'),
                          buildHeaderCell('Deficit'),
                        ],
                      ),
                      Divider(),
                      buildDataRow('Protein',
                          requiredNutritionData['protein'].toString(),
                          nutritionData['protein'].toString(),
                          deficitData['protein']?.toString() ?? '0'),
                      buildDataRow('Carbohydrates',
                          requiredNutritionData['carbohydrates'].toString(),
                          nutritionData['carbohydrates'].toString(),
                          deficitData['carbohydrates']?.toString() ?? '0'),
                      buildDataRow(
                          'Fats', requiredNutritionData['fats'].toString(),
                          nutritionData['fats'].toString(),
                          deficitData['fats']?.toString() ?? '0'),
                      buildDataRow(
                          'Fiber', requiredNutritionData['fiber'].toString(),
                          nutritionData['fiber'].toString(),
                          deficitData['fiber']?.toString() ?? '0'),
                      buildDataRow('Calcium',
                          requiredNutritionData['calcium'].toString(),
                          (nutritionData['calcium'] / 1000).toStringAsFixed(2),
                          deficitData['calcium']?.toStringAsFixed(2) ?? '0'),
                      buildDataRow(
                          'Iron', requiredNutritionData['iron'].toString(),
                          (nutritionData['iron'] / 1000).toStringAsFixed(2),
                          deficitData['iron']?.toStringAsFixed(2) ?? '0'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderCell(String label) {
    return Expanded(
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }

  Widget buildDataRow(String nutrient, String required, String yours,
      String deficit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Text(nutrient)),
          Expanded(child: Text(required)),
          Expanded(child: Text(yours)),
          Expanded(child: Text(deficit, style: TextStyle(
              color: deficit=="0" ? Colors.red : Colors.green))),
        ],
      ),
    );
  }

  String getAgeGroup(int age) {
    if (age >= 1 && age <= 3) return '1-3 years';
    if (age >= 4 && age <= 8) return '4-8 years';
    if (age >= 9 && age <= 13) return '9-13 years';
    if (age >= 14 && age <= 18) return '14-18 years';
    if (age >= 19 && age <= 50) return '19-50 years';
    return '51+ years';
  }


}


