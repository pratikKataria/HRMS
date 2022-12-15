import 'package:hrms/export.dart';
import 'package:hrms/ui/manageAccount/add_account_screen.dart';
import 'package:hrms/ui/manageAccount/model/get_all_account_response.dart';
import 'package:hrms/util/utility.dart';

class AllAccountScreen extends StatefulWidget {
  final String projectId;

  const AllAccountScreen(this.projectId, {Key? key}) : super(key: key);

  @override
  State<AllAccountScreen> createState() => _AllAccountScreenState();
}

class _AllAccountScreenState extends State<AllAccountScreen> {
  Set<Data> allEmployeesList = Set();
  TextEditingController searchTextController = TextEditingController();

  bool addNew = false;
  String? dob;

  @override
  void initState() {
    super.initState();
    getAllAccounts();
    searchTextController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => AddAccountScreen()));
          getAllAccounts();
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Header(headerText: "All Accounts"),
            line(width: Utility.screenWidth(context)),
            verticalSpace(6.0),

            Expanded(child: ListView(children: allEmployeesList.map((e) => cardViewAccounts(e)).toList())),

            verticalSpace(10.0),
            // HrmGradientButton(margin: EdgeInsets.symmetric(horizontal: 20.0), text: "Add New").onClick(() {
            //   // if (selectedEmployees.isEmpty) {
            //   //   FlutterToastX.showErrorToastBottom(context, "Please select at least one employee");
            //   //   return;
            //   // }
            //
            //   // String selectedEmployeeStringCommaSeparated = selectedEmployees.map((e) => e.id).toList().join(",");
            //   // addClientRequest.employees = selectedEmployeeStringCommaSeparated;
            //   Navigator.pushNamed(context, Screens.AADHAAR_CARD_VERIFICATION_SCREEN);
            // }),
            // verticalSpace(10.0),
          ],
        ),
      ),
    );
  }

  Container cardViewAccounts(Data e) {
    return Container(
      color: AppColors.inputFieldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*   "id": "3",
          "business_id": "12",
          "name": "PU PROJECTS",
          "account_number": "123456789122",
          "account_type_id": "3",
          "note": "Add to JAN 2022",
          "created_by": "17",
          "is_closed": "0",
          "deleted_at": null,
          "created_at": "2022-12-12 09:18:26",
          "updated_at": "2022-12-12 09:19:55"*/
          Text("Name: ${e.name}", style: textStyle14px500w),
          Text("Account Number: ${e.accountNumber}", style: textStyle14px500w),
          Text("Note: ${e.note}", style: textStyle14px500w),
          Text("Created by: ${e.createdBy}", style: textStyle14px500w),
        ],
      ),
    );
  }

  Future<void> getAllAccounts() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting all accounts...");
    var formData = FormData.fromMap({
      'Register': "Register",
      "Get_All_Accounts": "Get_All_Accounts",
      "business_id": "12",
    });

    GetAllAccountResponse response = await apiController.post<GetAllAccountResponse>(EndPoints.GET_ALL_ACCOUNT, body: formData);
    Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      // FlutterToastX.showSuccessToastBottom(context, "Add employee using add button");
      allEmployeesList.addAll(response.data!);
      allEmployeesList.clear();
      if (response.data?.isNotEmpty ?? false) allEmployeesList.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }

  Future<void> getAllUsersWithoutDialog() async {
    await Future.delayed(Duration(milliseconds: 200));
    var formData = FormData.fromMap({'Register': "Register"});
    GetAllAccountResponse response = await apiController.post<GetAllAccountResponse>(EndPoints.GET_ALL_ACCOUNT, body: formData);
    if (response.status!.isApiSuccessful) {
      // FlutterToastX.showSuccessToastBottom(context, "Add employee using add button");
      allEmployeesList.clear();

      if (response.data?.isNotEmpty ?? false) allEmployeesList.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
