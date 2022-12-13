import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/ui/addClient/model/add_client_request.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/flutter_toast.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/hrm_input_fields.dart';
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';
import 'package:hrms/widgets/widget_util.dart';

late AddClientRequest addClientRequest;

class BasicDetailClient extends StatefulWidget {
  const BasicDetailClient({Key? key}) : super(key: key);

  @override
  State<BasicDetailClient> createState() => _BasicDetailClientState();
}

class _BasicDetailClientState extends State<BasicDetailClient> {
  TextEditingController clientNameTextController = TextEditingController();
  TextEditingController registrationDateTextController = TextEditingController();
  TextEditingController registrationNumberTextController = TextEditingController();
  TextEditingController gstinTextController = TextEditingController();
  TextEditingController contactPersonTextController = TextEditingController();
  TextEditingController contactPersonMobileNumberTextController = TextEditingController();
  TextEditingController contactPersonEmailIdTextController = TextEditingController();
  String? dob;

  @override
  void initState() {
    addClientRequest = AddClientRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Client Basic Detail"),
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

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: clientNameTextController,
                      headingText: "Client Name",
                      text: "Enter client name",
                      mandate: true,
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                        LengthLimitingTextInputFormatter(80)
                      ],
                    ),

                    verticalSpace(20.0),
                    HrmInputFieldDummy(
                        textController: registrationDateTextController,
                        headingText: "Registration Date",
                        text: dob ?? "DD/MM/YYYY",
                        mandate: true)
                        .onClick(() {
                      FocusScope.of(context).unfocus();
                      _selectDate(context);
                    }),

                    verticalSpace(20.0),
                    HrmInputField(
                      textController: registrationNumberTextController,
                      headingText: "Registration Number",
                      text: "Enter registration number",
                      mandate: true,
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                        LengthLimitingTextInputFormatter(50)
                      ],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: gstinTextController,
                      headingText: "GSTIN",
                      text: "Enter GSTIN number",
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                        LengthLimitingTextInputFormatter(15)
                      ],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: contactPersonTextController,
                      headingText: "Contact Person Name",
                      text: "Enter contact person name",
                      mandate: true,
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                        LengthLimitingTextInputFormatter(50)
                      ],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: contactPersonMobileNumberTextController,
                      headingText: "Contact Person mobile Number",
                      text: "Enter contact person mobile number",
                      mandate: true,
                      inputTypeNumber: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                        textController: contactPersonEmailIdTextController,
                        headingText: "Contact Person Email Id",
                        text: "Enter contact person email id",
                        mandate: true),
                    verticalSpace(20.0),
                  ],
                ),
              ),
            ),
            verticalSpace(20.0),

            HrmGradientButton(text: "Next", margin: EdgeInsets.symmetric(horizontal: 20.0)).onClick(() {
              bool isValidationFailed = !validateInputFields();
              if (isValidationFailed) return;

              addClientRequest.clientName = clientNameTextController.text.toString();
              addClientRequest.registrationDate = registrationDateTextController.text.toString();
              // addClientRequest.register = clientNameTextController.text.toString();
              addClientRequest.gstin = gstinTextController.text.toString();
              addClientRequest.contactPerson = contactPersonTextController.text.toString();
              addClientRequest.contactPersonMobile = contactPersonMobileNumberTextController.text.toString();
              addClientRequest.contactPersonEmail = contactPersonEmailIdTextController.text.toString();

              Navigator.pushNamed(context, Screens.CLIENT_ADDRESS_DETAIL);
            }),
            verticalSpace(20.0),
          ],
        ),
      ),
    );
  }

  bool validateInputFields() {
    if (clientNameTextController.text.isEmpty) {
      showErrorToast("Please enter client Name");
      return false;
    }
    if (registrationDateTextController.text.isEmpty) {
      showErrorToast("Please enter registration date");
      return false;
    }
    if (registrationNumberTextController.text.isEmpty) {
      showErrorToast("Please enter registration number");
      return false;
    }

    // if (gstinTextController.text.isEmpty) {
    //   showErrorToast("Please enter GSTIN number");
    //   return false;
    // }

    if (contactPersonTextController.text.isEmpty) {
      showErrorToast("Please enter contact person name");
      return false;
    }

    if (contactPersonMobileNumberTextController.text.isEmpty) {
      showErrorToast("Please enter contact mobile number");
      return false;
    }

    if (contactPersonMobileNumberTextController.text.toString().length < 10) {
      showErrorToast("Please enter valid contact person mobile");
      return false;
    }

    if (contactPersonEmailIdTextController.text.isEmpty) {
      showErrorToast("Please enter contact person email id");
      return false;
    }

    if (!contactPersonEmailIdTextController.text.toString().isValidEmail) {
      showErrorToast("Please enter valid email id");
      return false;
    }

    return true;
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );

    if (picked == null && dob != null)
      dob = dob;
    else if (picked == null)
      dob = null;
    else
      dob = "${picked.day}/${picked.month}/${picked.year}";

    setState(() {});
    registrationDateTextController.text = dob ?? "";
  }

}
