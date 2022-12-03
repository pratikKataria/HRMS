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

import 'aadhaar_verification_screen.dart';

class AddressDetailEmployee extends StatefulWidget {
  const AddressDetailEmployee({Key? key}) : super(key: key);

  @override
  State<AddressDetailEmployee> createState() => _AddressDetailEmployeeState();
}

class _AddressDetailEmployeeState extends State<AddressDetailEmployee> {
  TextEditingController fullAddressTextController = TextEditingController();
  TextEditingController pincodeTextController = TextEditingController();
  TextEditingController landmarkTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Employee Address Detail"),
            Container(
              color: AppColors.alert,
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Center(child: Text("Fields marked in the red are compulsory", style: textStyleWhite12px600w)),
            ),

            //progress detail
            verticalSpace(20.0),
            Text("Detail progress", style: textStyleGreen14px500w),
            verticalSpace(20.0),
            Image(image: AssetImage(Assets.imagesIcDetailProcessTwo), height: 40.0),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputField(
                        textController: fullAddressTextController,
                        headingText: "Full Address",
                        text: "Enter full address",
                        mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: pincodeTextController,
                      headingText: "Pincode",
                      text: "Enter pincode",
                      mandate: true,
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: landmarkTextController,
                      headingText: "Landmark",
                      text: "Enter landmark",
                      mandate: true,
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: cityTextController,
                      headingText: "City",
                      text: "City name",
                      mandate: true,
                    ),
                    verticalSpace(20.0),
                    HrmGradientButton(text: "Next").onClick(() {
                      addEmployeeRequest.permanentAddress = fullAddressTextController.text.toString();
                      addEmployeeRequest.pincode = pincodeTextController.text.toString();
                      addEmployeeRequest.landmark = landmarkTextController.text.toString();
                      addEmployeeRequest.city = cityTextController.text.toString();

                      Navigator.pushNamed(context, Screens.EMPLOYEE_SKILL_DETAIL);
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
}
