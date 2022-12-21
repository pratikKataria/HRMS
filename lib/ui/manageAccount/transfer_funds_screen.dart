import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/manageAccount/add_account_type_screen.dart';
import "package:hrms/ui/manageAccount/model/get_all_types.dart";
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';

class TransferFundsScreen extends StatefulWidget {
  const TransferFundsScreen({Key? key}) : super(key: key);

  @override
  State<TransferFundsScreen> createState() => _TransferFundsScreenState();
}

class _TransferFundsScreenState extends State<TransferFundsScreen> {
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
            Header(headerText: "Add Account"),

            //fields
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputFieldDummy(
                      headingText: "From Account",
                      text: selectedTransferFromAccountString ?? "Select transfer form account",
                      mandate: true,
                    ).onClick(() {
                      FocusScope.of(context).unfocus();
                      showFromAccountDialog();
                    }),
                    verticalSpace(20.0),
                    HrmInputFieldDummy(
                      headingText: "To Account",
                      text: selectedTransferToAccountString ?? "Select transfer to account",
                      mandate: true,
                    ).onClick(() {
                      FocusScope.of(context).unfocus();
                      showToAccountDialog();
                    }),
                    verticalSpace(20.0),
                    HrmInputFieldDummy(
                      headingText: "Transfer Type",
                      text: selectedTransferTypeString ?? "Select transfer to account",
                      mandate: true,
                    ).onClick(() {
                      FocusScope.of(context).unfocus();
                      showTransferType();
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
              if (validateInputFields()) transferFunds();
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

  void showToAccountDialog() {
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
                      Text("Select To", style: textStyle14px600w),
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
    ).then((value) {
      setState(() {
        selectedTransferToAccountString = value?.name;
      });
    });
  }

  void showTransferType() {
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
                      Text("Select Type", style: textStyle14px600w),
                      verticalSpace(10.0),
                      ...listOfTransferType.map((e) {
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
                                  Expanded(child: Text(e ?? "", style: textStyleSubText14px500w)),
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
        selectedTransferTypeString = value;
      });
    });
  }

  bool validateInputFields() {
    if (amountTextController.text
        .toString()
        .isEmpty) {
      showErrorToast("Please enter amount");
      return false;
    }

    if (noteTextController.text
        .toString()
        .isEmpty) {
      showErrorToast("Please enter note");
      return false;
    }

    if (selectedTransferFromAccountString == null || selectedTransferFromAccountString!.isEmpty) {
      showErrorToast("Please select from account");
      return false;
    }

    if (selectedTransferToAccountString == null || selectedTransferToAccountString!.isEmpty) {
      showErrorToast("Please select to account");
      return false;
    }

    if (selectedTransferTypeString == null || selectedTransferTypeString!.isEmpty) {
      showErrorToast("Please select type");
      return false;
    }
    return true;
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
  }

  Future<void> transferFunds() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting all accounts...");
    String fromIdString = listOfAccounts.where((element) => (element.name == selectedTransferFromAccountString)).first.id??"";
    String toIdString = listOfAccounts.where((element) => (element.name == selectedTransferToAccountString)).first.id??"";
    String userId = await SharedManager.getStringPreference(SharedPrefsKeys.kUserId);

    var formData = FormData.fromMap({
      'Register': "Register",
      "Transfer_Fund": "active",
      "user_id": userId,
      "type": selectedTransferTypeString,
      "amount": amountTextController.text.toString(),
      "note": noteTextController.text.toString(),
      "account_id_from": fromIdString,
      "account_id_to": toIdString,
    });

    GetAllTypes response = await apiController.post<GetAllTypes>(EndPoints.GET_ALL_ACCOUNT, body: formData);
    await Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      FlutterToastX.showSuccessToastBottom(context, "Amount transfer successfully");
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
    await Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      listOfAccounts.clear();
      listOfAccounts.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
