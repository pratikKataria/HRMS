import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/ui/addClient/basic_detail_client.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/flutter_toast.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/hrm_input_fields.dart';
import 'package:hrms/widgets/widget_util.dart';

class AddressDetailClient extends StatefulWidget {
  const AddressDetailClient({Key? key}) : super(key: key);

  @override
  State<AddressDetailClient> createState() => _AddressDetailClientState();
}

class _AddressDetailClientState extends State<AddressDetailClient> {
  TextEditingController fullAddressTextController = TextEditingController();
  TextEditingController pincodeTextController = TextEditingController();
  TextEditingController landmarkTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Client Address Detail"),
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
            verticalSpace(10.0),

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
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                        LengthLimitingTextInputFormatter(24)
                      ],
                    ),
                    verticalSpace(20.0),
                    HrmGradientButton(text: "Next").onClick(() {
                      // bool isValidationFailed = !validateInputFields();
                      // if (isValidationFailed) return;

                      addClientRequest.fullAddress = fullAddressTextController.text.toString();
                      addClientRequest.pincode = pincodeTextController.text.toString();
                      addClientRequest.landmark = landmarkTextController.text.toString();
                      addClientRequest.city = cityTextController.text.toString();

                      Navigator.pushNamed(context, Screens.CLIENT_SKILL_DETAIL);
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
