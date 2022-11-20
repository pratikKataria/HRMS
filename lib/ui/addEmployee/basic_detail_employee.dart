import 'package:flutter/material.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/hrm_input_fields.dart';
import 'package:hrms/widgets/widget_util.dart';

class BasicDetailEmployee extends StatefulWidget {
  const BasicDetailEmployee({Key? key}) : super(key: key);

  @override
  State<BasicDetailEmployee> createState() => _BasicDetailEmployeeState();
}

class _BasicDetailEmployeeState extends State<BasicDetailEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Employee Basic Detail"),
            Container(
              color: AppColors.alert,
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Center(child: Text("Fields marked in the red are compulsory", style: textStyleWhite12px600w)),
            ),

            //progress detail
            verticalSpace(20.0),
            Text("Detail progress", style: textStyleGreen14px500w),
            verticalSpace(20.0),
            Image(image: AssetImage(Assets.imagesImgDetailProcessOne), height: 40.0),
            verticalSpace(10.0),

            //fields
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputField(headingText: "First Name", text: "Enter First Name", mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Last Name", text: "Enter last Name", mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Mobile Number", text: "Enter 10 digit mobile number", mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(
                      headingText: "Emergency Contact Number",
                      text: "Brother/Father/Friend mobile number",
                      mandate: true,
                    ),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Mobile Number", text: "Enter 10 digit mobile number", mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Email Address", text: "Enter email address", mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Date of Birth", text: "DD/MM/YYYY", mandate: true),
                    verticalSpace(20.0),
                  ],
                ),
              ),
            ),
            verticalSpace(20.0),
            HrmGradientButton(text: "Next", margin: EdgeInsets.symmetric(horizontal: 20.0))
                .onClick(() => Navigator.pushNamed(context, Screens.EMPLOYEE_ADDRESS_DETAIL)),
            verticalSpace(20.0),
          ],
        ),
      ),
    );
  }
}
