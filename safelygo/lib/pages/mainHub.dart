import 'package:flutter/material.dart';
import 'package:safelygo/Components/Card.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;

    int _indexSelected() {
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
        currentIndex: _indexSelected(),
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
        onPressed: () {
          print("wow you pressed it");
        },
      ),
      body: Container(
        child: Column(children: [Text("Main HUB"), Text("Nerd"),Scrollbar(child: Text("Reports"),chil)]),
      ),
    );
  }
}
