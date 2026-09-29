import 'package:SafelyGo/Components/Card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'reportCreationPage.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

    int indexSelected() {
      return selectedIndex;
    }

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Home"),
        leading: Icon(Icons.house),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,

        selectedItemColor:
            Colors.purple, // Prevents unexpected black backgrounds
        currentIndex: indexSelected(),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Reports"),

          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows_sharp),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.safety_check),
            label: "nerd",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc_outlined),
            label: "nerd",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (context) => ReportCreationPage()),
          );
        },
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 32),
            Text(
              "Reports",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight(300)),
            ),
            SizedBox(height: 32),
            GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
            ),
          ],
        ),
      ),
    );
  }
}
