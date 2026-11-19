import 'package:flutter/material.dart';
import 'package:safely_go/Models/ReportModel.dart';

class ReportInfo extends StatelessWidget {
  const ReportInfo({super.key, required this.report});
  final ReportModel report;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(report.title)),

      body: Padding(
        padding: EdgeInsetsGeometry.all(32),
        child: Center(
          child: Column(
            children: [
              Text(
                report.title,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight(300)),
              ),
              SizedBox(height: 32),
              Card(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Description:",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight(300),
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(report.description),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              Card(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Status:",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight(300),
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(
                        "This safety concern is currently: ${report.status}",
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              Card(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "How Pressing?:",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight(300),
                        ),
                      ),
                      SizedBox(height: 32),
                      Text("You marked this concern as: ${report.type}"),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 128),
              Card(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Description:",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight(300),
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(report.description),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
