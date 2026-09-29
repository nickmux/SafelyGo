import 'package:flutter/material.dart';

class ReportCreationPage extends StatelessWidget {
  const ReportCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            "Report a Concern",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight(300)),
          ),
          SizedBox(height: 32),
          TextField(),
          SizedBox(height: 32),
          TextFormField(),
          SizedBox(height: 128),
          OutlinedButton(
            onPressed: null,
            child: Text("Jarona", style: TextStyle(fontSize: 32)),
          ),
        ],
      ),
    );
  }
}
