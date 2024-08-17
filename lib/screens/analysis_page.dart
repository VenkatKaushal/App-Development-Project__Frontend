import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:app_frontend/required_nutrition.dart';
import 'package:app_frontend/global_data.dart';

class AnalysisPage extends StatefulWidget {
  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  RequiredNutritionData requiredNutritionData = RequiredNutritionData();
  UserData userData = UserData();

  @override
  void initState() {
    super.initState();

    if(userData.gender ==  'Male'){
      final age = userData.age!;
      final wi = userData.weight!;
      if(age > 0 && age <= 1){
        
      }
      else if(age > 1 && age <= 3){

      }
      else if(age > 3 && age <= 7){

      }
      else if(age > 7 && age <= 9){

      }
      else if(age > 9 && age <= 12){

      }
      else if(age > 12 && age <= 15){

      }
      else if(age > 15 && age <= 18){

      }
      else if(age > 18 && age <= 30){

      }
      else if(age > 30 && age <= 50){

      }
      else if(age > 50){

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access data from singleton instances
    final List<FlSpot> spots = [
      FlSpot(0, requiredNutritionData.requiredTotalNutrition ?? 0),
      FlSpot(1, requiredNutritionData.requiredTotalNutrition ?? 0),
      FlSpot(2, requiredNutritionData.requiredTotalNutrition ?? 0),
      FlSpot(3, requiredNutritionData.requiredTotalNutrition ?? 0),
      FlSpot(4, requiredNutritionData.requiredTotalNutrition ?? 0),
      FlSpot(5, requiredNutritionData.requiredTotalNutrition ?? 0),
      FlSpot(6, requiredNutritionData.requiredTotalNutrition ?? 0),
    ];

    final List<String> deficitNutrients = [
      'Protein',
      'Fat',
      'Calcium',
      'Iron',
    ];

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
              // Line Graph Section
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(show: true),
                    minX: 0,
                    maxX: 9,
                    minY: 0,
                    maxY: 100, // Adjust based on your data range
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Data Card Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildHeaderCell('Nutrient'),
                          buildHeaderCell('Yours'),
                          buildHeaderCell('Required'),
                          buildHeaderCell('Deficit'),
                        ],
                      ),
                      Divider(),
                      // Data Rows
                      buildDataRow('Calories', '500 IU', '5000 IU', '4500 IU'),
                      buildDataRow('Protein', '${requiredNutritionData.requiredProtein ?? 0}g', '40g', '20g'),
                      buildDataRow('Carbs', '${requiredNutritionData.requiredCarbohydrates ?? 0}g', '200g', '100g'),
                      buildDataRow('Fat', '${requiredNutritionData.requiredFat ?? 0}g', '70g', '55g'),
                      buildDataRow('Fiber', '${requiredNutritionData.requiredFiber ?? 0}g', '30g', '25g'),
                      buildDataRow('Calcium', '${requiredNutritionData.requiredCalcium ?? 0}mg', '1000mg', '700mg'),
                      buildDataRow('Iron', '${requiredNutritionData.requiredIron ?? 0}mg', '18mg', '14mg'),
                      buildDataRow('Vitamin A', '${requiredNutritionData.requiredVitaminA ?? 0} IU', '5000 IU', '4500 IU'),
                      buildDataRow('Vitamin B6', '${requiredNutritionData.requiredvitaminB6 ?? 0} IU', '5000 IU', '4500 IU'),
                      buildDataRow('Vitamin D', '${requiredNutritionData.requiredVitaminD ?? 0} IU', '5000 IU', '4500 IU'),
                      buildDataRow('Vitamin E', '${requiredNutritionData.requiredVitaminE ?? 0} IU', '5000 IU', '4500 IU'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Suggestions Card Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suggestions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Displaying bullet points for each nutrient in deficit
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: deficitNutrients.map((nutrient) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "• ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    height: 1.5,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Consider increasing your intake of $nutrient-rich foods.',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
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

  Widget buildHeaderCell(String title) {
    return Expanded(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildDataRow(String name, String yours, String required, String deficit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              yours,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              required,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              deficit,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.redAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}