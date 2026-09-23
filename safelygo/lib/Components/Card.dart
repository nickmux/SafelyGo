import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: .min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.safety_check),
            title: Text("Jerry"),
            subtitle: Text("Carsen keeps calling his creations bimbos"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: null, child: Text("Status")),
              TextButton(onPressed: null, child: Text("Touch Grass")),
            ],
          ),
        ],
      ),
    );
  }
}
