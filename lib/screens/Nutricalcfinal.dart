import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'splash_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Nutricalc extends StatefulWidget {
  const Nutricalc({super.key});

  @override
  _Nutricalcstate createState() => _Nutricalcstate();
}

class _Nutricalcstate extends State<Nutricalc> {
  String? selectedValue;
  int? selectedCardIndex;
  List<List<String>> itemsPerCard = [
    [], // Breakfast
    [], // Lunch
    [], // Snacks
    []  // Dinner
  ];

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return Foods.values.where((Foods food) => food.label.contains(input)).map(
          (Foods filteredFood) => ListTile(
        title: Text(filteredFood.label),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            if (selectedCardIndex != null) {
              setState(() {
                itemsPerCard[selectedCardIndex!].add(filteredFood.label);
                controller.clear(); // Clear the search field
              });
            }
          },
        ),
        onTap: () {
          controller.closeView(filteredFood.label);
        },
      ),
    );
  }

  Future<void> sendFoodItemsToServer() async {
    try {
      // Retrieve token from Hive
      var box = await Hive.openBox('authBox');
      String? token = box.get('jwtToken');

      if (token == null) {
        _showErrorDialog('Authorization token not found. Please log in again.');
        return;
      }

      // Prepare URL and data
      final url = Uri.parse('https://app-development-project-backend.onrender.com/api/nutrients/daily-calculate');

      // Collect all food items from the meal blocks
      final List<String> allFoodItems = itemsPerCard
          .expand((mealList) => mealList)
          .map((item) => item.toLowerCase()) // Convert each item to lowercase
          .toList();
      print("Food Items: $allFoodItems");

      final Map<String, dynamic> data = {
        'foodItems': allFoodItems,
      };
      print("JSON: ${jsonEncode(data)}");
      // Make the HTTP POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': '$token'
        },
        body: jsonEncode(data),
      );

      print("UpdateNutrients Response Status Code: ${response.statusCode}");
      print("UpdateNutrients Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print('Data sent successfully');
        // Optionally clear the itemsPerCard lists after sending data
        setState(() {
          itemsPerCard = [[], [], [], []]; // Resetting all meal blocks
        });
      } else {
        print('Failed to send data. Server responded with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending data: $e');
      // Handle or display the error
      _showErrorDialog('An error occurred while sending data. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nutricalc',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
            fontSize: 36,
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SearchAnchor.bar(
              barHintText: 'Search foods',
              suggestionsBuilder: (BuildContext context, SearchController controller) {
                return getSuggestions(controller);
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  buildCard(0, 'Breakfast'),
                  buildCard(1, 'Lunch'),
                  buildCard(2, 'Snacks'),
                  buildCard(3, 'Dinner'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await sendFoodItemsToServer();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(20),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Calculate\n(Note: Each Item calculates for 100g, Add accordingly)',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(int index, String mealTime) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCardIndex = index == selectedCardIndex ? null : index;
        });
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: selectedCardIndex == index ? Colors.blue : Colors.grey,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mealTime, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: itemsPerCard[index]
                      .map((item) => ListTile(
                    title: Text(item, style: const TextStyle(fontSize: 16)),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          itemsPerCard[index].remove(item);
                        });
                      },
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
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

enum Foods {
  apple('Apple'),
  dosa('Dosa'),
  BasmatiRice('Basmati Rice'),
  Chutney('Chutney'),
  puri('Puri'),
  chappatti('Chappatti'),
  paratha('Paratha'),
  naan('Naan'),
  Dal('Dal'),
  Kidneybeans('Kidney Beans'),
  Mango('Mango'),
  Banana('Banana'),
  Orange('Orange'),
  Pomegranate('Pomegranate'),
  Papaya('Papaya'),
  Guava('Guava'),
  Pineapple('Pineapple'),
  Grapes('Grapes'),
  Watermelon('Watermelon'),
  Muskmelon('Muskmelon'),
  Mosambi('Mosambi'),
  Lychee('Lychee'),
  Cherries('Cherries'),
  Plum('Plum'),
  Kiwi('Kiwi'),
  Pear('Pear'),
  Peach('Peach'),
  Blackberries('Blackberries'),
  Coconut('Coconut'),
  Lemon('Lemon'),
  Raspberries('Raspberries'),
  Strawberries('Strawberries'),
  Blueberries('Blueberries'),
  Milk('Milk'),
  paneer('Paneer'),
  Buttermilk('Buttermilk'),
  Almonds('Almonds'),
  Cashews('Cashews'),
  Raisins('Raisins'),
  Pistachios('Pistachios'),
  Walnuts('Walnuts'),
  Peanuts('Peanuts'),
  Dates('Dates'),
  Driedfigs('Dried Figs'),
  Samosa('Samosa'),
  Papad('Papad'),
  Idli('Idli'),
  Bananachips('Banana Chips'),
  MasalaDosa('Masala Dosa'),
  Chickencurry('Chicken Curry'),
  Chickenbiryani('Chickenbiryani'),
  Butterchicken('Butterchicken'),
  Fishcurry('Fishcurry'),
  egg('egg'),
  Tea('Tea'),
  Coffee('Coffee'),
  lemonade('lemonade'),
  Aampanna('Aampanna'),
  Coconutwater('Coconutwater'),
  Herbaltea('Herbaltea'),
  Ladoo('Ladoo'),
  Barfi('Barfi'),
  Kulfi('Kulfi'),
  Potato('Potato'),
  Onion('Onion'),
  Tomatoes('Tomatoes'),
  Brinjal('Brinjal'),
  Carrots('Carrots'),
  Cauliflower('Cauliflower'),
  ladyfinger('ladyfinger'),
  Cabbage('Cabbage'),
  Greenpeas('Greenpeas'),
  Radish('Radish'),
  Spinach('Spinach'),
  Sweetpotato('Sweetpotato'),
  Cucumber('Cucumber'),
  Capsicum('Capsicum'),
  Springonion('Springonion'),
  Bread('Bread'),
  PalakPaneer('PalakPaneer'),
  Vegetablecurry('Vegetablecurry'),
  Tomatosoup('Tomatosoup'),
  Vegetablesoup('Vegetablesoup'),
  Upma('Upma'),
  Sambhar('Sambhar'),
  VegetableBiryani('VegetableBiryani'),
  Phirni('Phirni'),
  ChannaSaag('ChannaSaag');

  const Foods(this.label);
  final String label;
}

