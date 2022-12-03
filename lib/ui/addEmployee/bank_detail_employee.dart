import 'package:flutter/material.dart';
import 'package:hrms/export.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/ui/addEmployee/aadhaar_verification_screen.dart';
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
  TextEditingController accountTextController = TextEditingController();
  TextEditingController ifscTextController = TextEditingController();
  TextEditingController aadhaarCardTextController = TextEditingController();
  TextEditingController panCardTextController = TextEditingController();

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
                    HrmInputField(
                      textController: accountTextController,
                      headingText: "Account Number",
                      text: "Enter account number",
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: ifscTextController,
                      headingText: "IFSC Code",
                      text: "Enter IFSC code",
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: aadhaarCardTextController,
                      headingText: "Aadhaar Card",
                      text: "Enter aadhaar card",
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: panCardTextController,
                      headingText: "Pan Card",
                      text: "Enter pancard",
                    ),
                    verticalSpace(20.0),
                    HrmGradientButton(text: "Confirm").onClick(() {
                      addEmployeeRequest.accountNumber = accountTextController.text.toString();
                      addEmployeeRequest.ifsc = ifscTextController.text.toString();
                      addEmployeeRequest.aadharNumber = aadhaarCardTextController.text.toString();
                      addEmployeeRequest.panNumber = panCardTextController.text.toString();

                      registerEmployee();

                    }),
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

  Future<void> registerEmployee() async {
    // await Future.delayed(Duration(milliseconds: 200));

    print(addEmployeeRequest.toJson());
    var formData = FormData.fromMap(addEmployeeRequest.toJson());

    Dialogs.showLoader(context, "Marking attendance please wait ...");
    AddEmployeeResponse addEmployeeResponse = await apiController.post<AddEmployeeResponse>(
      EndPoints.REGISTER_EMPLOYEE,
      body: formData,
    );
    Dialogs.hideLoader(context);
    if (addEmployeeResponse.status?.isApiSuccessful ?? false) {
      FlutterToastX.showSuccessToastBottom(context, addEmployeeResponse.message ?? "Attendance marked!");
      Navigator.of(context).popUntil((route) => route.isFirst);
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${addEmployeeResponse.message ?? ""}");
    }
  }
}
