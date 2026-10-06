import 'package:safely_go/Components/report_widget.dart';
import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(32),
        child: Column(
          children: [
            SizedBox(height: 32),
            Text(
              "Reports",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight(300)),
            ),
            ListView.builder(
              itemCount: 128,
              itemExtent: 256,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ReportCard();
              },
            ),
          ],
        ),
      ),
    );
  }
}
