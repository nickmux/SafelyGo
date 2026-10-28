import 'package:flutter/material.dart';
import 'package:safely_go/Models/ReportModel.dart';

class ReportInfo extends StatelessWidget {
  const ReportInfo({super.key, required this.report});
  final ReportModel report;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(report.title),
      ),
      body: Column(
        children: [
          Text(report.description),
          SizedBox(height: 32,),
          Text(report.dateCreated.toString()),
        ],
      ),
    );
  }
}
