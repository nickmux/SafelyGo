import 'package:flutter/material.dart';
import 'package:safelygo_admin/Models/ReportModel.dart';
import 'package:safelygo_admin/firebase.dart';

class ReportWidget extends StatefulWidget {
  ReportWidget({super.key, required this.model});

  ReportModel model;
  @override
  State<ReportWidget> createState() => _ReportWidgetGui();
}

class _ReportWidgetGui extends State<ReportWidget> {
  DropdownMenuItem<String> buildOptions(String item) =>
      DropdownMenuItem(value: item, child: Text(item));
  final type = ["Pending", "On Going", "Resolved"];
  String? value = "Pending";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.model.title),
          subtitle: Text(widget.model.description),
        ),
        Row(
          children: [
            DropdownButton<String>(
              items: type.map(buildOptions).toList(),
              value: value,
              onChanged: (String? value) {
                setState(() {
                  this.value = value;
                  FirebaseTools.updateReportStatud(widget.model.id, value!);
                });
                print(value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
