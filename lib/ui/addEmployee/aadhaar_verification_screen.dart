import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_request.dart';
import 'package:hrms/ui/addEmployee/model/adhaar_card_send_otp_response.dart';
import 'package:hrms/ui/addEmployee/model/verify_aadhar_response.dart';

late AddEmployeeRequest addEmployeeRequest;

class AadhaarVerificationScreen extends StatefulWidget {
  AadhaarVerificationScreen({Key? key}) : super(key: key) {
    addEmployeeRequest = AddEmployeeRequest();
  }

  @override
  State<AadhaarVerificationScreen> createState() => _AadhaarVerificationScreenState();
}

class _AadhaarVerificationScreenState extends State<AadhaarVerificationScreen> {
  TextEditingController aadhaarTextController = TextEditingController();
  TextEditingController otpTextController = TextEditingController();
  String? refId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Aadhaar Detail"),
            Container(
              color: AppColors.alert,
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Center(child: Text("Fields marked in the red are compulsory", style: textStyleWhite12px600w)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  verticalSpace(20.0),
                  HrmInputField(
                    textController: aadhaarTextController,
                    headingText: "Aadhaar Card",
                    text: "Enter aadhaar card",
                    inputTypeNumber: true,
                    inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                    mandate: true,
                  ),
                  verticalSpace(20.0),
                  if (refId != null)
                    HrmInputField(
                      textController: otpTextController,
                      headingText: "OTP",
                      text: "Enter otp",
                      inputTypeNumber: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                      mandate: true,
                    ),
                  if (refId != null) verticalSpace(20.0),
                  verticalSpace(20.0),
                  HrmGradientButton(text: "Verify").onClick(() {
                    addEmployeeRequest.aadharNumber = aadhaarTextController.text.toString();

                    if (aadhaarTextController.text.isEmpty) {
                      FlutterToastX.showErrorToastBottom(context, "Please enter aadhaar card");
                      return;
                    }

                    if (aadhaarTextController.text.length < 12) {
                      FlutterToastX.showErrorToastBottom(context, "Please enter valid aadhar card");
                      return;
                    }

                    if (refId == null)
                      sendAadhaarOtp(aadhaarTextController.text.toString());
                    else
                      verifyAadharOtp(otpTextController.text.toString(), refId ?? "");

                    // Navigator.pushNamed(context, Screens.EMPLOYEE_BASIC_DETAIL);
                  }),
                  verticalSpace(20.0),
                  HrmGradientButton(text: "Continue without OTP").onClick(() {
                    addEmployeeRequest.aadharNumber = "";

                    if (aadhaarTextController.text.isEmpty) {
                      FlutterToastX.showErrorToastBottom(context, "Please enter aadhaar card");
                      return;
                    }

                    if (aadhaarTextController.text.length < 12) {
                      FlutterToastX.showErrorToastBottom(context, "Please enter valid aadhar card");
                      return;
                    }

                    Navigator.pushNamed(context, Screens.EMPLOYEE_BASIC_DETAIL);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendAadhaarOtp(String aadhaarNo) async {
    FocusScope.of(context).unfocus();
    await Future.delayed(Duration(milliseconds: 200));
    Dialogs.showLoader(context, "Sending otp to register mobile number ...");
    Map<String, String> body = {"aadhar": aadhaarNo};
    var formData = FormData.fromMap(body);
    AdhaarCardSendOtpResponse response = await apiController.post<AdhaarCardSendOtpResponse>(EndPoints.AADHAAR_VERIFICATION, body: formData);
    await Dialogs.hideLoader(context);

    if (response.status == "SUCCESS") {
      refId = response.refId;
      // listOfProjects.clear();
      // listOfProjects.addAll(response.data!);
      // if (listOfProjects.isNotEmpty) selectedProject = listOfProjects?.first?.clientName ?? "";
      // if (listOfProjects.isNotEmpty) selectedProjectId = listOfProjects?.first?.projectId ?? "";
    } else {
      FlutterToastX.showErrorToastCenter(context, "Failed: ${response.toJson() ?? ""}");
    }
    setState(() {});
  }

  Future<void> verifyAadharOtp(String otp, String refId) async {
    FocusScope.of(context).unfocus();
    await Future.delayed(Duration(milliseconds: 200));

    if (otp.isEmpty) {
      FlutterToastX.showErrorToastCenter(context, "Please enter otp");
      return;
    }

    if (otp.length < 6) {
      FlutterToastX.showErrorToastCenter(context, "Please enter valid otp");
      return;
    }

    Map<String, String> body = {
      "otp": otp,
      "ref_id": refId,
    };
    var formData = FormData.fromMap(body);
    Dialogs.showLoader(context, "Verifying aadhaar otp ...");
    VerifyAadharResponse response = await apiController.post<VerifyAadharResponse>(EndPoints.AADHAAR_VERIFY_OTP, body: formData);
    await Dialogs.hideLoader(context);

    if (response.status == "VALID") {
      addEmployeeRequest.permanentAddress = response.address;
      addEmployeeRequest.dob = response.dob;
      addEmployeeRequest.gender = response.gender;

      if (response.name?.isNotEmpty ?? false) {
        addEmployeeRequest.firstName = response.name;
        List<String>? fullName = response.name?.split(" ");
        if ((fullName?.length ?? 0) > 1) {
          addEmployeeRequest.firstName = fullName?.first ?? "";
          addEmployeeRequest.lastName = fullName?.last ?? "";
        }
      }

      addEmployeeRequest.pincode = response.splitAddress?.pincode;
      addEmployeeRequest.city = response.splitAddress?.vtc;
      addEmployeeRequest.state = response.splitAddress?.state;

      Navigator.pushNamed(context, Screens.EMPLOYEE_BASIC_DETAIL);
    } else {
      FlutterToastX.showErrorToastCenter(context, "Failed: ${response.toJson() ?? "some error occured"}");
    }
    this.refId = null;
    otpTextController.clear();
    setState(() {});
  }
}
