import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/ui/addClient/basic_detail_client.dart';
import 'package:hrms/ui/addEmployee/address_detail_employee.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/flutter_toast.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/hrm_input_fields.dart';
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';
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
  String? stateName;

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
                    HrmInputFieldDummy(
                      headingText: "State",
                      text: stateName ?? "Select state",
                      mandate: true,
                    ).onClick(() {
                      FocusScope.of(context).unfocus();
                      showStateDialog();
                    }),
                    verticalSpace(20.0),
                    HrmGradientButton(text: "Next").onClick(() {
                      bool isValidationFailed = !validateInputFields();
                      if (isValidationFailed) return;

                      addClientRequest.fullAddress = fullAddressTextController.text.toString();
                      addClientRequest.pincode = pincodeTextController.text.toString();
                      addClientRequest.landmark = landmarkTextController.text.toString();
                      addClientRequest.city = cityTextController.text.toString();
                      addClientRequest.state = stateName;

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

  void showStateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: AppColors.white,
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select State", style: textStyle14px600w),
                    verticalSpace(10.0),
                    ...listOfStates.map((e) {
                      return Container(
                        color: AppColors.inputFieldBackgroundColor,
                        padding: EdgeInsets.all(20.0),
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text(e, style: textStyleSubText14px500w)),
                                horizontalSpace(10.0),
                                Icon(
                                  Icons.check_circle_outline,
                                  color: AppColors.textColorSubText,
                                )
                              ],
                            ),
                          ],
                        ),
                      ).onClick(() {
                        Navigator.pop(context, e);
                      });
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) {
      setState(() {
        stateName = value;
      });
    });
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


    if (stateName == null || stateName!.isEmpty) {
      showErrorToast("Please enter state");
      return false;
    }

    return true;
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
  }
}
