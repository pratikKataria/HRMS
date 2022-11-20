import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/widget_util.dart';

class UserScannedScreen extends StatelessWidget {
  const UserScannedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Scanned View"),
            verticalSpace(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: AppColors.inputFieldBackgroundColor,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: Rajesh shree vashtav", style: textStyle14px500w),
                        Text("Employee Id: 45331233", style: textStyle14px500w),
                        verticalSpace(8.0),
                        Text("Receptionist", style: textStyleGreen14px500w),
                      ],
                    ),
                  ),
                  verticalSpace(20.0),
                  Row(
                    children: [
                      Flexible(
                        child: HrmGradientButton(text: "Attendance T1")
                            .onClick(() => Navigator.pushNamed(context, Screens.ATTENDANCE_TYPE_ONE)),
                      ),
                      horizontalSpace(20.0),
                      Flexible(
                        child: HrmGradientButton(text: "Attendance T2")
                            .onClick(() => Navigator.pushNamed(context, Screens.ATTENDANCE_TYPE_TWO)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            verticalSpace(20.0),
          ],
        ),
      ),
    );
  }
}
