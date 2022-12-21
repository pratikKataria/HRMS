import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';

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

  String? stateName;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) testData();
  }

  testData() {
    fullAddressTextController.text = "Address test test address";
    pincodeTextController.text = "451115";
    landmarkTextController.text = "landmark";
    cityTextController.text = "8717805155";
    stateName = "MP";
  }

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

                      addEmployeeRequest.permanentAddress = fullAddressTextController.text.toString();
                      addEmployeeRequest.pincode = pincodeTextController.text.toString();
                      addEmployeeRequest.landmark = landmarkTextController.text.toString();
                      addEmployeeRequest.city = cityTextController.text.toString();
                      addEmployeeRequest.state = stateName;

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

List<String> listOfStates = [
  "Andaman and Nicobar Islands",
  "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chandigarh",
  "Chhattisgarh",
  "Dadra and Nagar Haveli",
  "Daman and Diu",
  "Delhi",
  "Goa",
  "Gujarat",
  "Haryana",
  "Himachal Pradesh",
  "Jammu and Kashmir",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Lakshadweep",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Orissa",
  "Pondicherry",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttaranchal",
  "Uttar Pradesh",
  "West Bengal"
];
