import 'package:flutter/material.dart';
import 'package:hrms/export.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_request.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_response.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/hrm_input_fields.dart';
import 'package:hrms/widgets/widget_util.dart';

class BankDetailEmployee extends StatefulWidget {
  const BankDetailEmployee({Key? key}) : super(key: key);

  @override
  State<BankDetailEmployee> createState() => _BankDetailEmployeeState();
}

class _BankDetailEmployeeState extends State<BankDetailEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Employee Bank Detail"),
            Container(
              color: AppColors.alert,
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Center(child: Text("Fields marked in the red are compulsory", style: textStyleWhite12px600w)),
            ),

            //progress detail
            verticalSpace(20.0),
            Text("Detail progress", style: textStyleGreen14px500w),
            verticalSpace(20.0),
            Image(image: AssetImage(Assets.imagesIcDetailProcessFour), height: 40.0),
            verticalSpace(10.0),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Account Number", text: "Enter skill"),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "IFSC Code", text: "Enter company name"),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Aadhaar Card", text: "Enter joining date"),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Pan Card", text: "Enter working days"),
                    verticalSpace(20.0),
                    HrmGradientButton(text: "Confirm").onClick(() => Navigator.of(context).popUntil((route) => route.isFirst)),
                    verticalSpace(20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerEmployee(String userId) async {
    // await Future.delayed(Duration(milliseconds: 200));
    AddEmployeeRequest addEmployeeRequest = AddEmployeeRequest();
    var formData = FormData.fromMap(addEmployeeRequest.toJson());

    Dialogs.showLoader(context, "Marking attendance please wait ...");
    AddEmployeeResponse addEmployeeResponse = await apiController.post<AddEmployeeResponse>(
      EndPoints.REGISTER_EMPLOYEE,
      body: formData,
    );
    Dialogs.hideLoader(context);
    if (addEmployeeResponse.status?.isApiSuccessful ?? false) {
      FlutterToastX.showSuccessToastBottom(context, addEmployeeResponse.message ?? "Attendance marked!");
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${addEmployeeResponse.message ?? ""}");
    }
  }
}
