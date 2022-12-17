import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/addEmployee/aadhaar_verification_screen.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_response.dart';
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';
import 'package:image_picker/image_picker.dart';

class BankDetailEmployee extends StatefulWidget {
  const BankDetailEmployee({Key? key}) : super(key: key);

  @override
  State<BankDetailEmployee> createState() => _BankDetailEmployeeState();
}

class _BankDetailEmployeeState extends State<BankDetailEmployee> {
  TextEditingController accountHolderNameTextController = TextEditingController();
  TextEditingController accountTextController = TextEditingController();
  TextEditingController ifscTextController = TextEditingController();
  TextEditingController aadhaarCardTextController = TextEditingController();
  TextEditingController panCardTextController = TextEditingController();

  String? aadhaarImage;
  String? panImage;
  String? signatureImage;

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
                      textController: accountHolderNameTextController,
                      headingText: "Account Holder Name",
                      text: "Enter account holder name",
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                        LengthLimitingTextInputFormatter(24)
                      ],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: accountTextController,
                      headingText: "Account Number",
                      text: "Enter account number",
                      inputTypeNumber: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(17)],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: ifscTextController,
                      headingText: "IFSC Code",
                      text: "Enter IFSC code",
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("^[A-Za-z0-9_.-]*")),
                        LengthLimitingTextInputFormatter(11)
                      ],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: aadhaarCardTextController,
                      headingText: "Aadhaar Card",
                      text: "Enter aadhaar card",
                      inputTypeNumber: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                    ),
                    verticalSpace(10.0),
                    HrmInputFieldDummy(
                      textController: aadhaarCardTextController,
                      headingText: aadhaarImage,
                      text: "Pick Aadhaar image",
                      leftWidget: Icon(Icons.attach_file),
                      inputTypeNumber: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                    ).onClick(() async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                      aadhaarImage = image?.name;
                      if (image != null) {
                        final File imageFile = File(image.path);
                        addEmployeeRequest.aadharImg = imageFile.path;
                      }
                      setState(() {});
                    }),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: panCardTextController,
                      headingText: "Pan Card",
                      text: "Enter pancard",
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("^[A-Za-z0-9_.-]*")),
                        LengthLimitingTextInputFormatter(10)
                      ]
                    ),
                    HrmInputFieldDummy(
                      textController: aadhaarCardTextController,
                      headingText: panImage,
                      text: "Pick pan image",
                      leftWidget: Icon(Icons.attach_file),
                      inputTypeNumber: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                    ).onClick(() async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                      panImage = image?.name;
                      if (image != null) {
                        final File imageFile = File(image.path);
                        addEmployeeRequest.panImg = imageFile.path;
                      }
                      setState(() {});
                    }),
                    verticalSpace(20.0),
                    HrmInputFieldDummy(
                      textController: aadhaarCardTextController,
                      headingText: signatureImage ?? "Signature Image",
                      text: "Pick signature image",
                      leftWidget: Icon(Icons.attach_file),
                      inputTypeNumber: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                    ).onClick(() async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                      signatureImage = image?.name;
                      if (image != null) {
                        final File imageFile = File(image.path);
                        addEmployeeRequest.signatureImg = imageFile.path;
                      }
                      setState(() {});
                    }),
                    verticalSpace(20.0),
                  ],
                ),
              ),
            ),

            HrmGradientButton(text: "Confirm", margin: EdgeInsets.symmetric(horizontal: 20.00)).onClick(() {
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
    );
  }

  Future<void> registerEmployee() async {
    // await Future.delayed(Duration(milliseconds: 200));

    print(addEmployeeRequest.toJson());
    var formData = FormData.fromMap(await addEmployeeRequest.toJson());

    Dialogs.showLoader(context, "Creating new employee ...");
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
