 import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_request.dart';

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
                    inputTypeNumber: true,
                    inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                    mandate: true,
                  ),
                  verticalSpace(20.0),
                  verticalSpace(20.0),
                  HrmGradientButton(text: "Verify").onClick(() {
                    addEmployeeRequest.aadharNumber = aadhaarTextController.text.toString();

                    if (aadhaarTextController.text.isEmpty) {
                      FlutterToastX.showErrorToastBottom(context, "Please enter aadhaar card");
                      return;
                    }

                    if (aadhaarTextController.text.length < 12) {
                      FlutterToastX.showErrorToastBottom(context, "Please enter valid aadhar card");
                      return;
                    }

                    Navigator.pushNamed(context, Screens.EMPLOYEE_BASIC_DETAIL);
                  }),
                  verticalSpace(20.0),

                  HrmGradientButton(text: "Continue without Aadhaar").onClick(() {
                    addEmployeeRequest.aadharNumber = "";

                    // if (aadhaarTextController.text.isEmpty) {
                    //   FlutterToastX.showErrorToastBottom(context, "Please enter aadhaar card");
                    //   return;
                    // }
                    //
                    // if (aadhaarTextController.text.length < 12) {
                    //   FlutterToastX.showErrorToastBottom(context, "Please enter valid aadhar card");
                    //   return;
                    // }

                    Navigator.pushNamed(context, Screens.EMPLOYEE_BASIC_DETAIL);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
