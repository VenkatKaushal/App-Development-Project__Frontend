import 'package:flutter/material.dart';
import 'splash_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutricalc',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
            fontSize: 36
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
              onPressed: () {
                Navigator.push(
                  context,
              MaterialPageRoute(builder: (context) =>  SplashScreen()),
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
                'Calculate',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(int index, String day) {
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
              Text(day, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
}

enum Foods {
  red('Dal'),
  orange('Roti'),
  yellow('Rice'),
  green('Egg'),
  blue('Chicken(100 gm)'),
  indigo('Dosa'),
  violet('Idli'),
  purple('Sambar(1 small bowl[100 ml])'),
  pink('Dahi(1 small bowl[100 ml])'),
  silver('Vada'),
  gold('Onion Uttapam'),
  beige('Pongal(1 small bowl)'),
  brown('Aloo Paratha'),
  grey('Milk (100 ml = 1 glass)'),
  black('Paneer(100 gm)'),
  white('Rajma(2 small bowl)');

  const Foods(this.label);
  final String label;
}

// void main() => runApp(const MaterialApp(home: Nutricalc()));
