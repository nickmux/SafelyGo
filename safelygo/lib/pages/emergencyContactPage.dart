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
              "Emergency Contact dir",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight(300)),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
