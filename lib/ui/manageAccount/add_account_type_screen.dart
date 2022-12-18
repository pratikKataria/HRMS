import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/manageAccount/model/get_all_account_response.dart';

class AddAccountTypeScreen extends StatefulWidget {
  const AddAccountTypeScreen({Key? key}) : super(key: key);

  @override
  State<AddAccountTypeScreen> createState() => _AddAccountTypeScreenState();
}

class _AddAccountTypeScreenState extends State<AddAccountTypeScreen> {
  TextEditingController accountTypeNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Add Account Type"),

            //fields
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: accountTypeNameController,
                      headingText: "Account Type Name",
                      text: "Enter account type Name",
                      inputFilters: [LengthLimitingTextInputFormatter(120)],
                      mandate: true,
                    ),
                  ],
                ),
              ),
            ),
            verticalSpace(20.0),
            HrmGradientButton(
              text: "Add",
              radius: 0.0,
            ).onClick(() {
              if (validateInputFields()) addType();
            }),
          ],
        ),
      ),
    );
  }

  bool validateInputFields() {
    if (accountTypeNameController.text.toString().isEmpty) {
      showErrorToast("Please enter account type name");
      return false;
    }

    return true;
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
  }

  Future<void> addType() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting all accounts...");
    var formData = FormData.fromMap({
      "Register": "register",
      "Add_Type": accountTypeNameController.text.toString(),
      "user_id": "12", //todo change this
      "business_id": "12",
      "name": accountTypeNameController.text.toString(),
    });

    GetAllAccountResponse response = await apiController.post<GetAllAccountResponse>(EndPoints.GET_ALL_ACCOUNT, body: formData);
    await Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      FlutterToastX.showSuccessToastBottom(context, "Account type added successfully");
      Navigator.pop(context);
      // allEmployeesList.addAll(response.data!);
      // allEmployeesList.clear();
      // if (response.data?.isNotEmpty ?? false) allEmployeesList.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
