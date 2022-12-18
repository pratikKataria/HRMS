import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/addClient/basic_detail_client.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_response.dart';

class BankDetailClient extends StatefulWidget {
  const BankDetailClient({Key? key}) : super(key: key);

  @override
  State<BankDetailClient> createState() => _BankDetailClientState();
}

class _BankDetailClientState extends State<BankDetailClient> {
  TextEditingController accountHolderNameTextController = TextEditingController();
  TextEditingController accountTextController = TextEditingController();
  TextEditingController ifscTextController = TextEditingController();
  TextEditingController aadhaarCardTextController = TextEditingController();
  TextEditingController panCardTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Client Bank Detail"),
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
                      headingText: "Account Number",
                      text: "Enter account number",
                      textController: accountTextController,
                      inputTypeNumber: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(17)],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      headingText: "IFSC Code",
                      text: "Enter company name",
                      textController: ifscTextController,
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("^[A-Za-z0-9_.-]*")),
                        LengthLimitingTextInputFormatter(11)
                      ],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      headingText: "Aadhaar Card",
                      text: "Enter aadhaar card",
                      textController: aadhaarCardTextController,
                      inputTypeNumber: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      headingText: "Pan Card",
                      text: "Enter pan",
                      textController: panCardTextController,
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("^[A-Za-z0-9_.-]*")),
                        LengthLimitingTextInputFormatter(10)
                      ],
                    ),
                    verticalSpace(20.0),
                    HrmGradientButton(text: "Confirm").onClick(() {
                      addClientRequest.accountNumber = accountTextController.text.toString();
                      addClientRequest.ifsc = ifscTextController.text.toString();
                      addClientRequest.aadhar = aadhaarCardTextController.text.toString();
                      addClientRequest.pan = panCardTextController.text.toString();

                      registerClient();
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

  Future<void> registerClient() async {
    // await Future.delayed(Duration(milliseconds: 200));
    print("${addClientRequest.toJson()}");
    var formData = FormData.fromMap(addClientRequest.toJson());

    Dialogs.showLoader(context, "Creating new client ...");
    AddEmployeeResponse addEmployeeResponse = await apiController.post<AddEmployeeResponse>(
      EndPoints.REGISTER_CLIENT,
      body: formData,
    );
    await Dialogs.hideLoader(context);
    if (addEmployeeResponse.status?.isApiSuccessful ?? false) {
      FlutterToastX.showSuccessToastBottom(context, addEmployeeResponse.message ?? "Attendance marked!");
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${addEmployeeResponse.message ?? ""}");
    }
  }
}
