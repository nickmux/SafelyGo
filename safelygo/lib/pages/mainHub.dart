import 'dart:async';

import 'package:SafelyGo/Components/Card.dart';
import 'package:SafelyGo/pages/reportListPage.dart';
import 'package:SafelyGo/pages/signUp.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'reportCreationPage.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  Home createState() => Home();
}

class Home extends State<MapScreen> with AutomaticKeepAliveClientMixin {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<Widget> pages = [ReportsPage(), SignIn(), ReportCard(), ReportsPage()];
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
        type: BottomNavigationBarType.fixed,
        // Prevents unexpected black backgrounds
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            print('works $index , $selectedIndex');
          });
        },
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Reports"),

          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows_sharp),
            label: "Map",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
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
            MaterialPageRoute<void>(builder: (context) => ReportCreationLive()),
          );
        },
      ),
      body: pages[selectedIndex],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
