import 'package:hrms/export.dart';
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
  String? selectedTransferFromAccountString;
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
            Header(headerText: "Add Account"),

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
                  ],
                ),
              ),
            ),
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
        getBalanceByAccount();
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

  Future<void> getBalanceByAccount() async {
    String fromIdString = listOfAccounts.where((element) => (element.name == selectedTransferFromAccountString)).first.id ?? "";
    Dialogs.showLoader(context, "Checking account balance...");
    var formData = FormData.fromMap({
      "Register": "register", // todo change this
      "account_id": fromIdString, // todo change this
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
