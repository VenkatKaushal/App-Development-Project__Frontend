import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:global_health_insights/screens/analysis_page.dart';
import 'Login_Screen.dart';
import 'profile_page.dart';
import 'Nutricalcfinal.dart';
import 'analysis_page.dart';

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
                            userProfile: UserProfile(
                              userName: 'John Doe',
                              age: 25,
                              gender: 'Male',
                              weight: 70.0,
                              height: 175.0,
                            ),
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
                        CardView(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle Check status action
                                  },
                                  child: Text('Check Status'),
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
            icon: Icon(Icons.navigate_next),
            label: 'Next Page',
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
                  _buildMacroColumn('Carbohydrates', 50, 165, Colors.teal),
                  _buildMacroColumn('Fat', 35, 65, Colors.purple),
                  _buildMacroColumn('Protein', 65, 85, Colors.orange),
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

  Widget _buildMacroColumn(String name, int current, int total, Color color) {
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
                value: current / total,
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
                onPressed: _increaseWater,
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
      _workoutHours++;
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
            '$_workoutHours L',
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
                onPressed: _increaseWorkout,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
