import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/addEmployee/aadhaar_verification_screen.dart';
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';

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

  String? dob;
  String selectedGender = "M";

  List<String> genderList = ["M", "F"];

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
                      inputFilters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")), LengthLimitingTextInputFormatter(64)],
                      mandate: true,
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: lastNameTextController,
                      headingText: "Last Name",
                      text: "Enter last Name",
                      mandate: true,
                      inputFilters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")), LengthLimitingTextInputFormatter(64)],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                        textController: mobileNumberTextController,
                        headingText: "Mobile Number",
                        text: "Enter 10 digit mobile number",
                        mandate: true,
                        inputTypeNumber: true,
                        inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                        inputLength: 10),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: emContactNumberTextController,
                      headingText: "Emergency Contact Number",
                      text: "Brother/Father/Friend mobile number",
                      mandate: true,
                      inputTypeNumber: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                        textController: emailTextController,
                        headingText: "Email Address",
                        text: "Enter email address"/*,
                        mandate: true*/),
                    verticalSpace(20.0),
                    HrmInputFieldDummy(
                            textController: dobTextController,
                            headingText: "Date of Birth",
                            text: dob ?? "DD/MM/YYYY",
                            mandate: true)
                        .onClick(() {
                      FocusScope.of(context).unfocus();
                      _selectDate(context);
                    }),
                    verticalSpace(20.0),
                    HrmInputFieldDummy(
                            textController: dobTextController, headingText: "Gender", text: selectedGender, mandate: true)
                        .onClick(() {
                      FocusScope.of(context).unfocus();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: Wrap(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                    color: AppColors.white,
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Select Gender", style: textStyle14px600w),
                                        verticalSpace(10.0),
                                        ...genderList.map((e) {
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
                                                    Container(child: Text(e, style: textStyleSubText14px500w)),
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
                              ],
                            ),
                          );
                        },
                      ).then((value) {
                        setState(() {
                          selectedGender = value ?? "M";
                        });
                      });
                    }),
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
              addEmployeeRequest.gender = selectedGender;
              print(addEmployeeRequest.toJson());

              Navigator.pushNamed(context, Screens.EMPLOYEE_ADDRESS_DETAIL);
            }),
            verticalSpace(20.0),
          ],
        ),
      ),
    );
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
    dobTextController.text = dob ?? "";
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

    if (mobileNumberTextController.text.toString().length < 10) {
      showErrorToast("Please enter valid mobile number");
      return false;
    }

    if (emContactNumberTextController.text.toString().isEmpty) {
      showErrorToast("Please enter emergency contact number");
      return false;
    }

    if (emContactNumberTextController.text.toString().length < 10) {
      showErrorToast("Please enter valid emergency contact number");
      return false;
    }
/*

    if (emailTextController.text.toString().isEmpty) {
      showErrorToast("Please enter email id");
      return false;
    }

    if (!emailTextController.text.toString().isValidEmail) {
      showErrorToast("Please enter valid email id");
      return false;
    }
    
*/

    if (dobTextController.text.toString().isEmpty) {
      showErrorToast("Please enter dob");
      return false;
    }

    return true;
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
  }
}
