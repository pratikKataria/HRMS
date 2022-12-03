import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_request.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/hrm_input_fields.dart';
import 'package:hrms/widgets/widget_util.dart';

late AddEmployeeRequest addEmployeeRequest;
class AadhaarVerificationScreen extends StatelessWidget {
  TextEditingController aadhaarTextController = TextEditingController();

  AadhaarVerificationScreen({Key? key}) : super(key: key) {
    addEmployeeRequest = AddEmployeeRequest();
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  verticalSpace(20.0),
                  HrmInputField(
                      textController: aadhaarTextController,
                      headingText: "Aadhaar Card",
                      text: "Enter aadhaar card",
                      mandate: true),
                  verticalSpace(20.0),
                  verticalSpace(20.0),
                  HrmGradientButton(text: "Verify").onClick(() {
                    addEmployeeRequest.aadharNumber = aadhaarTextController.text.toString();
                    Navigator.pushNamed(context, Screens.EMPLOYEE_BASIC_DETAIL);
                  }),
                  verticalSpace(20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
