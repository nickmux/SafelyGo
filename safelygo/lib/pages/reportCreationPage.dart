import 'package:flutter/material.dart';

class ReportCreationLive extends StatefulWidget {
  @override
  const ReportCreationLive({super.key});

  @override
  ReportCreationPage createState() => ReportCreationPage();
}

class ReportCreationPage extends State<ReportCreationLive> {
  final jerry = ["Not that Serious", "Pressing", "Emergency"];
  String? value = "Not that Serious";
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  items: jerry.map(buildOptions).toList(),
                  value: value,
                  onChanged: (String? value) {
                    setState(() {
                      this.value = value;
                    });
                    print(value);
                  },
                ),

                OutlinedButton(
                  onPressed: null,
                  child: Text("Submit report", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildOptions(String item) =>
      DropdownMenuItem(value: item, child: Text(item));
}
