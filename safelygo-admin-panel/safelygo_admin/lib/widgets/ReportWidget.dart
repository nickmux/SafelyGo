import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:safelygo_admin/Models/ReportModel.dart';

class ReportWidget extends StatefulWidget {
  ReportWidget({super.key, required this.model});

  ReportModel model;
  @override
  State<ReportWidget> createState() => _ReportWidgetGui();
}

class _ReportWidgetGui extends State<ReportWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [ListTile(title: Text(widget.model.title))]);
  }
}
