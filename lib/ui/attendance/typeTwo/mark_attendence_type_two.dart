import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/hrm_input_fields.dart';
import 'package:hrms/widgets/widget_util.dart';

class MarkAttendanceTypeTwo extends StatefulWidget {
  const MarkAttendanceTypeTwo({Key? key}) : super(key: key);

  @override
  State<MarkAttendanceTypeTwo> createState() => _MarkAttendanceTypeTwoState();
}

class _MarkAttendanceTypeTwoState extends State<MarkAttendanceTypeTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Mark Attendance"),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  verticalSpace(20.0),
                  HrmInputField(headingText: "Select Block No.", text: "Block Number"),
                  verticalSpace(20.0),
                  HrmInputField(headingText: "Select Robot No.", text: "Robot Number"),
                  verticalSpace(20.0),
                  HrmInputField(headingText: "Select Inverter No.", text: "Inverter Number"),
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
