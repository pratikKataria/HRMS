import 'package:hrms/export.dart';
import 'package:hrms/ui/manageAccount/model/get_all_transactions.dart';
import "package:hrms/ui/manageAccount/model/get_all_types.dart";
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';

import 'model/get_balance_response.dart';

class GetBalanceScreen extends StatefulWidget {
  const GetBalanceScreen({Key? key}) : super(key: key);

  @override
  State<GetBalanceScreen> createState() => _GetBalanceScreenState();
}

class _GetBalanceScreenState extends State<GetBalanceScreen> {
  List<Data> listOfAccounts = [];
  List<TransactionData> listOfTransactions = [];
  List<String> listOfTransactionType = ["opening_balance", "fund_transfer", "deposit", "expenses"];

  String? selectedTransferFromAccountString;
  String? selectedTransactionTypeString;
  String? selectedAccountId;
  String fromDateString = "";
  String toDateString = "";

  num? amountString;

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
            Header(headerText: "Check Balance"),

            //fields
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputFieldDummy(
                      headingText: "Select Account",
                      text: selectedTransferFromAccountString ?? "Select account to get available balance",
                      mandate: true,
                    ).onClick(() {
                      FocusScope.of(context).unfocus();
                      showFromAccountDialog();
                    }),
                    verticalSpace(20.0),
                    verticalSpace(20.0),
                    Center(child: Text("${amountString ?? "0.0"}", style: textStyleBlue28px600w)),
                    Center(child: Text("Available balance", style: textStyleRegular16px600w)),
                    verticalSpace(20.0),
                    Text("Transaction History", style: textStyle14px600w),
                    verticalSpace(20.0),
                    Row(
                      children: [
                        Expanded(
                          child: fromDate().onClick(() async {
                            fromDateString = await _selectDate();
                            if (fromDateString.isNotEmpty) FlutterToastX.showSuccessToastBottom(context, "Select To Date");
                            setState(() {});
                          }),
                        ),
                        horizontalSpace(10.0),
                        Expanded(
                          child: toDate().onClick(() async {
                            toDateString = await _selectDate();
                            setState(() {});
                            if (fromDateString == null || fromDateString.isEmpty) {
                              showErrorToast("Please select from Date");
                              return;
                            }

                            if (selectedAccountId == null || selectedAccountId!.isEmpty) {
                              showErrorToast("Please select account to view transactions");
                              return;
                            }
                            getTransactions();
                          }),
                        ),
                      ],
                    ),
                    verticalSpace(20.0),
                    HrmInputFieldDummy(
                      headingText: "Select Transaction Type",
                      text: selectedTransactionTypeString ?? "Select transaction type",
                      mandate: true,
                    ).onClick(() {
                      FocusScope.of(context).unfocus();
                      showTransactionTypes();
                    }),
                    ...listOfTransactions.map((e) => cardViewAccounts(e)).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column fromDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColors.buttonStartGradient, AppColors.buttonEndGradient],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.background,
                spreadRadius: 2.0,
                blurRadius: 8.0,
                offset: Offset(2, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("From Date", style: textStyleWhite14px500w),
              horizontalSpace(20.0),
              Icon(Icons.filter_list_sharp, size: 20.0, color: AppColors.white),
            ],
          ),
        ),
        verticalSpace(4.0),
        Text(fromDateString ?? "", style: textStyle14px500w)
      ],
    );
  }

  Column toDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColors.buttonStartGradient, AppColors.buttonEndGradient],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.background,
                spreadRadius: 2.0,
                blurRadius: 8.0,
                offset: Offset(2, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("To Date", style: textStyleWhite14px500w),
              horizontalSpace(20.0),
              Icon(Icons.filter_list_sharp, size: 20.0, color: AppColors.white),
            ],
          ),
        ),
        verticalSpace(4.0),
        Text(toDateString ?? "", style: textStyle14px500w)
      ],
    );
  }

  Future<String> _selectDate() async {
    //2022-12-01 09:24:00
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );

    if (picked == null) {
      return "";
    }

    return "${picked?.year ?? "YY"}-${picked?.month ?? "MM"}-${picked?.day ?? "DD"}";
  }

  Container cardViewAccounts(TransactionData e) {
    return Container(
      color: AppColors.inputFieldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Type: ${e.type ?? "N/A"}", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Amount: ${e.amount ?? "N/A"}", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Reff no: ${e.reffNo ?? "N/A"}", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Transaction Id: ${e.transactionId ?? "N/A"}", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Transaction Payment Id: ${e.transactionPaymentId ?? "N/A"}", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Transfer Transaction Id: ${e.transactionId ?? "N/A"}", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Note: ${e.note ?? "N/A"}", style: textStyle14px500w),
        ],
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
        selectedTransferFromAccountString = value?.name ?? selectedTransferFromAccountString;
        selectedAccountId = value?.id ?? selectedAccountId;
        getBalanceByAccount();
      });
    });
  }

  void showTransactionTypes() {
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
                      Text("Select From", style: textStyle14px600w),
                      verticalSpace(10.0),
                      ...listOfTransactionType.map((e) {
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
        selectedTransactionTypeString = value ?? selectedTransactionTypeString;
        setState(() {});
      });
    });
  }

  bool validateInputFields() {
    if (selectedTransferFromAccountString == null || selectedTransferFromAccountString!.isEmpty) {
      showErrorToast("Please select from account");
      return false;
    }
    return true;
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
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

  Future<void> getTransactions() async {
    Dialogs.showLoader(context, "Getting transaction details...");

    Map<String, String> map = {
      "GET": "GET",
      "account_id": selectedAccountId ?? "",
      "date_from": "$fromDateString 09:24:00",
      "date_till": "$toDateString 09:24:00",
      "transection_type": selectedTransactionTypeString??"",
    };

    GetAllTransactions response = await apiController.get<GetAllTransactions>(EndPoints.TRANSACTIONS, payload: map);
    await Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      listOfTransactions.clear();
      listOfTransactions.addAll(response.transactionData!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }

  Future<void> getBalanceByAccount() async {
    String fromIdString = listOfAccounts.where((element) => (element.name == selectedTransferFromAccountString)).first.id ?? "";
    Dialogs.showLoader(context, "Checking account balance...");
    // String userId = await SharedManager.getStringPreference(SharedPrefsKeys.kUserId);

    var formData = FormData.fromMap({
      "Register": "register",
      "account_id": fromIdString,
      "business_id": "12",
      "Get_Balance": "Get_Balance",
    });

    GetBalanceResponse response = await apiController.post<GetBalanceResponse>(EndPoints.GET_ALL_ACCOUNT, body: formData);
    await Future.delayed(Duration(milliseconds: 200));
    await Dialogs.hideLoader(context);
    await Future.delayed(Duration(milliseconds: 200));
    if (response.status!.isApiSuccessful) {
      amountString = response.balance;
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
