import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/manageAccount/add_account_type_screen.dart';
import "package:hrms/ui/manageAccount/model/get_all_types.dart";
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({Key? key}) : super(key: key);

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  TextEditingController accountNameTextController = TextEditingController();
  TextEditingController accountNumberTextController = TextEditingController();
  TextEditingController accountNoteTextController = TextEditingController();
  TextEditingController dobTextController = TextEditingController();

  Data? selectedGender;

  List<Data> listOfAccountTypes = [];

  @override
  void initState() {
    super.initState();

    getAccountTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => AddAccountTypeScreen()));
            getAccountTypes();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Add Account"),

            //fields
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: accountNameTextController,
                      headingText: "Account Name",
                      text: "Enter Account Name",
                      inputFilters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                        LengthLimitingTextInputFormatter(120)
                      ],
                      mandate: true,
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: accountNumberTextController,
                      headingText: "Account Number",
                      text: "Enter account number",
                      mandate: true,
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(17)],
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: accountNoteTextController,
                      headingText: "Note",
                      text: "Enter note",
                      inputFilters: [LengthLimitingTextInputFormatter(120)],
                      mandate: true,
                    ),
                    verticalSpace(20.0),
                    HrmInputFieldDummy(
                            textController: dobTextController,
                            headingText: "Account Type",
                            text: selectedGender?.name ?? "Select account type",
                            mandate: true)
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
                                        ...listOfAccountTypes.map((e) {
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
                                                    Expanded(child: Text(e.name ?? "", style: textStyleSubText14px500w)),
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
                          selectedGender = value;
                          dobTextController.text = selectedGender?.name ?? "";
                        });
                      });
                    }),
                    verticalSpace(20.0),
                  ],
                ),
              ),
            ),
            verticalSpace(20.0),
            HrmGradientButton(text: "Add", radius: 0.0).onClick(() {
              if (validateInputFields()) createAccount();
            }),
          ],
        ),
      ),
    );
  }

  bool validateInputFields() {
    if (accountNameTextController.text.toString().isEmpty) {
      showErrorToast("Please enter Account Name");
      return false;
    }

    if (accountNumberTextController.text.toString().isEmpty) {
      showErrorToast("Please enter Account number");
      return false;
    }

    if (dobTextController.text.toString().isEmpty) {
      showErrorToast("Please enter account type");
      return false;
    }

    return true;
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
  }

  Future<void> createAccount() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting all accounts...");
    var formData = FormData.fromMap({
      'Register': "Register",
      "Add_Account": "add",
      "business_id": "12",
      "name": accountNameTextController.text.toString(),
      "account_number": accountNumberTextController.text.toString(),
      "account_type_id": dobTextController.text.toString(),
      "note": accountNoteTextController.text.toString(),
      "created_by": "12", //todo change this
    });

    GetAllTypes response = await apiController.post<GetAllTypes>(EndPoints.GET_ALL_ACCOUNT, body: formData);
    Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      FlutterToastX.showSuccessToastBottom(context, "Account created successfully");
      Navigator.pop(context);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }

  Future<void> getAccountTypes() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting all accounts...");
    var formData = FormData.fromMap({
      'Register': "Register",
      "Get_Types": "Get_Types",
      "business_id": "12",
    });

    GetAllTypes response = await apiController.post<GetAllTypes>(EndPoints.GET_ALL_ACCOUNT, body: formData);
    Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      listOfAccountTypes.clear();
      listOfAccountTypes.addAll(response.data!);
      // FlutterToastX.showSuccessToastBottom(context, "Add employee using add button");
      // allEmployeesList.addAll(response.data!);
      // allEmployeesList.clear();
      // if (response.data?.isNotEmpty ?? false) allEmployeesList.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
