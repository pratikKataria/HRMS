import 'package:flutter/services.dart';
import 'package:hrms/export.dart';

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
                      inputTypeNumber: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
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
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                        LengthLimitingTextInputFormatter(24)
                      ],
                    ),
                    verticalSpace(20.0),
                    HrmGradientButton(text: "Next").onClick(() {
                      bool isValidationFailed = !validateInputFields();
                      if (isValidationFailed) return;

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

  bool validateInputFields() {
    if (fullAddressTextController.text.toString().isEmpty) {
      showErrorToast("Please enter full address");
      return false;
    }

    if (pincodeTextController.text.toString().isEmpty) {
      showErrorToast("Please enter pincode");
      return false;
    }

    if (pincodeTextController.text.toString().length < 6) {
      showErrorToast("Please enter valid pincode");
      return false;
    }

    if (landmarkTextController.text.toString().isEmpty) {
      showErrorToast("Please enter landmark");
      return false;
    }

    if (cityTextController.text.toString().isEmpty) {
      showErrorToast("Please enter city");
      return false;
    }

    return true;
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
  }
}
