import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import "package:hrms/ui/manageAccount/model/get_all_types.dart";
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';

class AddExpensesScreen extends StatefulWidget {
  const AddExpensesScreen({Key? key}) : super(key: key);

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  TextEditingController amountTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();

  Data? selectedGender;

  List<Data> listOfAccounts = [];
  List<String> listOfTransferType = ["credit", "debit"];

  String? selectedTransferFromAccountString;
  String? selectedTransferToAccountString;
  String? selectedTransferTypeString;

  @override
  void initState() {
    super.initState();

    getAllAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Add Expenses"),

            //fields
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputFieldDummy(
                      headingText: "Select Account",
                      text: selectedTransferFromAccountString ?? "Select to add expense",
                      mandate: true,
                    ).onClick(() {
                      FocusScope.of(context).unfocus();
                      showFromAccountDialog();
                    }),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: amountTextController,
                      headingText: "Amount",
                      text: "Enter amount",
                      inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(20)],
                      mandate: true,
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      textController: noteTextController,
                      headingText: "Note",
                      text: "Enter note",
                      inputFilters: [LengthLimitingTextInputFormatter(120)],
                      mandate: true,
                    ),
                  ],
                ),
              ),
            ),
            verticalSpace(20.0),
            HrmGradientButton(text: "Add", radius: 0.0).onClick(() {
              FocusScope.of(context).unfocus();
              if (validateInputFields()) addExpenses();
            }),
          ],
        ),
      ),
    );
  }

  void showFromAccountDialog() {
    showDialog<Data>(
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
                      Text("Select From", style: textStyle14px600w),
                      verticalSpace(10.0),
                      ...listOfAccounts.map((e) {
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
    ).then((Data? value) {
      setState(() {
        selectedTransferFromAccountString = value?.name ?? "";
      });
    });
  }

  bool validateInputFields() {
    if (selectedTransferFromAccountString == null || selectedTransferFromAccountString!.isEmpty) {
      showErrorToast("Please select from account");
      return false;
    }

    if (amountTextController.text.toString().isEmpty) {
      showErrorToast("Please enter amount");
      return false;
    }

    if (noteTextController.text.toString().isEmpty) {
      showErrorToast("Please enter note");
      return false;
    }

    return true;
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
  }

  Future<void> addExpenses() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Adding expenses...");
    String fromIdString = listOfAccounts.where((element) => (element.name == selectedTransferFromAccountString)).first.id ?? "";

    var formData = FormData.fromMap({
      "Register": "register",
      "Add_Expances": "Add_Expances",
      "account_id": fromIdString,
      "business_id": "12",
      "amount": amountTextController.text.toString(),
      "user_id": "12", //todo change this
      "note": noteTextController.text.toString(),
    });

    GetAllTypes response = await apiController.post<GetAllTypes>(EndPoints.GET_ALL_ACCOUNT, body: formData);
    Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      FlutterToastX.showSuccessToastBottom(context, "Expenses added successfully");
      Navigator.pop(context);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }

  Future<void> getAllAccounts() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting all accounts...");
    var formData = FormData.fromMap({
      "Get_All_Accounts": "Get_All_Accounts",
      "business_id": "12",
      "Register": "register",
    });

    GetAllTypes response = await apiController.post<GetAllTypes>(EndPoints.GET_ALL_ACCOUNT, body: formData);
    Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      listOfAccounts.clear();
      listOfAccounts.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
