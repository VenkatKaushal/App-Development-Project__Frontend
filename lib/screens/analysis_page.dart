import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalysisPage extends StatelessWidget {
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
              // Line Graph Section
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
                    maxY: 6,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 1),
                          FlSpot(2, 2),
                          FlSpot(4, 3),
                          FlSpot(6, 2.5),
                          FlSpot(8, 4),
                          FlSpot(10, 3),
                        ],
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
                      buildDataRow('Protein', '20g', '40g', '20g'),
                      buildDataRow('Carbs', '100g', '200g', '100g'),
                      buildDataRow('Fat', '15g', '70g', '55g'),
                      buildDataRow('Fiber', '5g', '30g', '25g'),
                      buildDataRow('Sugars', '10g', '50g', '40g'),
                      buildDataRow('Cholesterol', '30mg', '300mg', '270mg'),
                      buildDataRow('Sodium', '200mg', '2300mg', '2100mg'),
                      buildDataRow('Calcium', '300mg', '1000mg', '700mg'),
                      buildDataRow('Iron', '4mg', '18mg', '14mg'),
                      buildDataRow('Vitamin A', '500 IU', '5000 IU', '4500 IU'),
                      buildDataRow('Vitamin C', '60mg', '90mg', '30mg'),
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

void main() {
  runApp(MaterialApp(
    home: AnalysisPage(),
  ));
}
