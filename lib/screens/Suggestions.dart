import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SuggestionsPage extends StatefulWidget {
  @override
  _SuggestionsPageState createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  List<Map<String, dynamic>> suggestions = [];

  @override
  void initState() {
    super.initState();
    fetchSuggestions();
  }

  Future<void> fetchSuggestions() async {
    try {
      var box = await Hive.openBox('authBox');
      String? token = box.get('jwtToken');

      final response = await http.post(
        Uri.parse('https://app-development-project-backend.onrender.com/api/nutrients/batch-suggestions'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': '$token',
        },
        body: json.encode([
          {'nutrient': 'Protein', 'type': 'deficiency'},
          {'nutrient': 'Protein', 'type': 'excess'},
          {'nutrient': 'Carbohydrate ', 'type': 'deficiency'},
          {'nutrient': 'Carbohydrate ', 'type': 'excess'},
          {'nutrient': 'Fat', 'type': 'deficiency'},
          {'nutrient': 'Fat', 'type': 'excess'},
          {'nutrient': 'Fiber', 'type': 'deficiency'},
          {'nutrient': 'Fiber', 'type': 'excess'},
          {'nutrient': 'Calcium ', 'type': 'deficiency'},
          {'nutrient': 'Calcium ', 'type': 'excess'},
          {'nutrient': 'Iron ', 'type': 'deficiency'},
          {'nutrient': 'Iron ', 'type': 'excess'}
        ]),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        setState(() {
          suggestions = data.map((item) {
            return {
              'nutrient': item['nutrient'],
              'type': item['type'],
              'suggestions': List<String>.from(item['suggestions'] ?? []),
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutritional Suggestions'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: suggestions.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView(
          children: suggestions.map((suggestion) {
            return SuggestionCard(
              nutrient: suggestion['nutrient'],
              type: suggestion['type'],
              suggestions: List<String>.from(suggestion['suggestions']),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class SuggestionCard extends StatelessWidget {
  final String nutrient;
  final String type;
  final List<String> suggestions;

  const SuggestionCard({
    required this.nutrient,
    required this.type,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nutrient,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              type == 'deficiency'
                  ? 'Suggestions to overcome deficiency:'
                  : 'Suggestions to manage excess:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Display suggestions dynamically
            ...suggestions.map((suggestion) => Text('- $suggestion')).toList(),
          ],
        ),
      ),
    );
  }
}
