import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/hrm_input_fields.dart';
import 'package:hrms/widgets/widget_util.dart';

class MarkAttendanceTypeOne extends StatefulWidget {
  const MarkAttendanceTypeOne({Key? key}) : super(key: key);

  @override
  State<MarkAttendanceTypeOne> createState() => _MarkAttendanceTypeOneState();
}

class _MarkAttendanceTypeOneState extends State<MarkAttendanceTypeOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Mark Attendance"),
            verticalSpace(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  HrmInputField(headingText: "Title", text: "Enter job title"),
                  verticalSpace(20.0),
                  Container(
                    height: 45.0,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: AppColors.inputFieldBackgroundColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Select Employee", style: textStyleSubText14px500w),
                        Icon(Icons.filter_list_sharp, size: 20.0),
                      ],
                    ),
                  ),
                  verticalSpace(20.0),
                  line(),
                  verticalSpace(20.0),
                  Text("Present Employee", style: textStyle14px500w),
                  verticalSpace(50.0),
                  HrmGradientButton(text: "Approve"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
