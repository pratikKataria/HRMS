import 'package:flutter/material.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/ui/addEmployee/aadhaar_verification_screen.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/flutter_toast.dart';
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
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController mobileNumberTextController = TextEditingController();
  TextEditingController emContactNumberTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController dobTextController = TextEditingController();

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
                    HrmInputField(
                        textController: firstNameTextController,
                        headingText: "First Name",
                        text: "Enter First Name",
                        mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(
                        textController: lastNameTextController, headingText: "Last Name", text: "Enter last Name", mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(
                        textController: mobileNumberTextController,
                        headingText: "Mobile Number",
                        text: "Enter 10 digit mobile number",
                        mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: emContactNumberTextController,
                      headingText: "Emergency Contact Number",
                      text: "Brother/Father/Friend mobile number",
                      mandate: true,
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                        textController: emailTextController,
                        headingText: "Email Address",
                        text: "Enter email address",
                        mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: dobTextController,
                      headingText: "Date of Birth",
                      text: "DD/MM/YYYY",
                      mandate: true,
                    ),
                    verticalSpace(20.0),
                  ],
                ),
              ),
            ),
            verticalSpace(20.0),
            HrmGradientButton(text: "Next", margin: EdgeInsets.symmetric(horizontal: 20.0)).onClick(() {

              bool isValidationFailed = !validateInputFields();
              if (isValidationFailed) return;

              addEmployeeRequest.firstName = firstNameTextController.text.toString();
              addEmployeeRequest.lastName = lastNameTextController.text.toString();
              addEmployeeRequest.contactNo = mobileNumberTextController.text.toString();
              addEmployeeRequest.emergencynumber = emContactNumberTextController.text.toString();
              addEmployeeRequest.email = emailTextController.text.toString();
              addEmployeeRequest.dob = dobTextController.text.toString();
              print(addEmployeeRequest.toJson());

              Navigator.pushNamed(context, Screens.EMPLOYEE_ADDRESS_DETAIL);
            }),
            verticalSpace(20.0),
          ],
        ),
      ),
    );
  }

  bool validateInputFields() {
    if (firstNameTextController.text.toString().isEmpty) {
      showErrorToast("Please enter first name");
      return false;
    }

    if (lastNameTextController.text.toString().isEmpty) {
      showErrorToast("Please enter last name");
      return false;
    }

    if (mobileNumberTextController.text.toString().isEmpty) {
      showErrorToast("Please enter mobile number");
      return false;
    }

    if (emContactNumberTextController.text.toString().isEmpty) {
      showErrorToast("Please enter emergency contact number");
      return false;
    }

    if (emailTextController.text.toString().isEmpty) {
      showErrorToast("Please enter email id");
      return false;
    }

    if (dobTextController.text.toString().isEmpty) {
      showErrorToast("Please enter email id");
      return false;
    }

    return true;
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
  }
}
