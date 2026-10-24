import 'package:flutter/material.dart';

class EmergencyContactDir extends StatefulWidget {
  const EmergencyContactDir({super.key});

  @override
  EmergencyContactDirState createState() => EmergencyContactDirState();
}

class EmergencyContactDirState extends State<EmergencyContactDir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(32),
        child: Column(
          children: [
            Text(
              "Report a Concern",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight(300)),
            ),
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                hint: Text("Title"),
                label: Text("Title"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            TextFormField(
              maxLines: 10,
              decoration: InputDecoration(
                hint: Text("Description"),
                label: Text("Description"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 128),
          ],
        ),
      ),
    );
  }
}
