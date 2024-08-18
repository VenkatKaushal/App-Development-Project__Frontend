import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalysisPage extends StatefulWidget {
  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  Map<String, dynamic> requiredNutritionData = {};
  Map<String, dynamic> nutritionData = {};
  Map<String, dynamic> deficitData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/nutrition'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        requiredNutritionData = data['requiredNutrients'];
        nutritionData = data['nutritionIntake'];
        deficitData = calculateDeficit(data['requiredNutrients'], data['nutritionIntake']);
      });
    } else {
      throw Exception('Failed to load nutrition data');
    }
  }

  Map<String, dynamic> calculateDeficit(Map<String, dynamic> required, Map<String, dynamic> intake) {
    Map<String, dynamic> deficit = {};
    required.forEach((key, value) {
      deficit[key] = value - intake[key];
    });
    return deficit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Page'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
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
                    maxX: 10,
                    minY: 0,
                    maxY: requiredNutritionData['calories']?.toDouble() ?? 2500.0,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, requiredNutritionData['calories']?.toDouble() ?? 0),
                          FlSpot(1, nutritionData['calories']?.toDouble() ?? 0),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
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
                      buildDataRow('Calories', requiredNutritionData['calories'].toString(), nutritionData['calories'].toString(), deficitData['calories'].toString()),
                      buildDataRow('Protein', requiredNutritionData['protein'].toString(), nutritionData['protein'].toString(), deficitData['protein'].toString()),
                      buildDataRow('Carbs', requiredNutritionData['carbs'].toString(), nutritionData['carbs'].toString(), deficitData['carbs'].toString()),
                      buildDataRow('Fat', requiredNutritionData['fat'].toString(), nutritionData['fat'].toString(), deficitData['fat'].toString()),
                      buildDataRow('Fiber', requiredNutritionData['fiber'].toString(), nutritionData['fiber'].toString(), deficitData['fiber'].toString()),
                      buildDataRow('Calcium', requiredNutritionData['calcium'].toString(), nutritionData['calcium'].toString(), deficitData['calcium'].toString()),
                      buildDataRow('Iron', requiredNutritionData['iron'].toString(), nutritionData['iron'].toString(), deficitData['iron'].toString()),
                      buildDataRow('Vitamin A', requiredNutritionData['vitaminA'].toString(), nutritionData['vitaminA'].toString(), deficitData['vitaminA'].toString()),
                      buildDataRow('Vitamin B6', requiredNutritionData['vitaminB6'].toString(), nutritionData['vitaminB6'].toString(), deficitData['vitaminB6'].toString()),
                      buildDataRow('Vitamin D', requiredNutritionData['vitaminD'].toString(), nutritionData['vitaminD'].toString(), deficitData['vitaminD'].toString()),
                      buildDataRow('Vitamin E', requiredNutritionData['vitaminE'].toString(), nutritionData['vitaminE'].toString(), deficitData['vitaminE'].toString()),
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

  Widget buildDataRow(String nutrient, String required, String yours, String deficit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(nutrient)),
          Expanded(child: Text(required)),
          Expanded(child: Text(yours)),
          Expanded(child: Text(deficit, style: TextStyle(color: deficit.startsWith('-') ? Colors.red : Colors.green))),
        ],
      ),
    );
  }
}
