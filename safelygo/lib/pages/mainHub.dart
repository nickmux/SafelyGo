import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.house), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows_sharp),
            label: "wow",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.safety_check),
            label: "nerd",
          ),
        ],
      ),
      body: Container(
        child: Column(children: [Text("Main HUB"), Text("Nerd")]),
      ),
    );
  }
}
