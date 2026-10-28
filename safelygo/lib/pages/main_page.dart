import 'package:safely_go/pages/emergencyContactPage.dart';
import 'package:safely_go/pages/map_page.dart';
import 'package:safely_go/pages/report_list_page.dart';
import 'package:flutter/material.dart';

class Hub extends StatefulWidget {
  const Hub({super.key});

  @override
  HubState createState() => HubState();
}

class HubState extends State<Hub> with AutomaticKeepAliveClientMixin {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<Widget> pages = [ReportsPage(), MapPage(), EmergencyContactPage()];
    return Scaffold(
      appBar: AppBar(
        actions: [OutlinedButton(onPressed: null, child: Icon(Icons.house))],
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
          });
        },
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Reports"),

          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows_sharp),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Emergency Contact Directory",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: "Find Trusted People",
          ),
        ],
      ),

      body: pages[selectedIndex],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
