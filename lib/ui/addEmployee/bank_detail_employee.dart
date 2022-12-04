import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/addEmployee/aadhaar_verification_screen.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_response.dart';

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
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: panCardTextController,
                      headingText: "Pan Card",
                      text: "Enter pancard",
                      inputTypeNumber: true,
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("^[A-Za-z0-9_.-]*")),
                        LengthLimitingTextInputFormatter(10)
                      ],
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
