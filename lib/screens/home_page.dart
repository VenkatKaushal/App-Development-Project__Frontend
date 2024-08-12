import 'package:flutter/material.dart';

class home_page extends StatelessWidget {
  const home_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 31, 102),
      appBar: AppBar(
        shadowColor: Color.fromARGB(255, 120, 119, 119),
        backgroundColor: Color.fromARGB(255, 69, 69, 69),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.search),
                iconSize: 16,
                onPressed: () {
                  // Handle search button press
                  print('Search button pressed');
                },
              ),
              IconButton(
                icon: Icon(Icons.settings),
                iconSize: 16,
                onPressed: () {
                  // Handle settings button press
                  print('Settings button pressed');
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'NutriGuide',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 41, 192, 46),
                  ),
                ),
              ),
            ],
          ),
          ProfileIcon(),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: double.infinity,
                  height: 125,
                  child: Center(
                    child: Text(
                      'Current Status',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: ElevatedButton(
                onPressed: () {
                  print('Second ElevatedButton is pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 175),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Know Your\n Analysis',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                print('First FloatingActionButton pressed');
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.black,
            ),
          ),
          Positioned(
            bottom: 16,
            right: 96, // Adjust right position to fit both buttons
            child: FloatingActionButton(
              onPressed: () {
                print('Second FloatingActionButton pressed');
              },
              child: Icon(Icons.camera),
              backgroundColor: Colors.black,
            ),
          ),
        ],
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
