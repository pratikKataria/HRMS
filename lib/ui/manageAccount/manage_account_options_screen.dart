import 'package:hrms/export.dart';
import 'package:hrms/ui/addClient/model/get_all_user_response.dart';
import 'package:hrms/ui/manageAccount/all_account_screen.dart';
import 'package:hrms/ui/manageAccount/transfer_funds_screen.dart';
import 'package:hrms/util/utility.dart';

class ManageAccountOptionsScreen extends StatefulWidget {
  final String projectId;

  const ManageAccountOptionsScreen(this.projectId, {Key? key}) : super(key: key);

  @override
  State<ManageAccountOptionsScreen> createState() => _ManageAccountOptionsScreenState();
}

class _ManageAccountOptionsScreenState extends State<ManageAccountOptionsScreen> {
  Set<Data> allEmployeesList = Set();
  TextEditingController searchTextController = TextEditingController();

  bool addNew = false;
  String? dob;

  @override
  void initState() {
    super.initState();
    getAllUsers();
    searchTextController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Header(headerText: "Manage Account"),
            line(width: Utility.screenWidth(context)),
            verticalSpace(6.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(border: Border.all(color: AppColors.lineColor, width: 2.0)),
              child: Text("View / Add Account", style: textStyle12px600w),
            )
                .onClick(() => Navigator.push(context, MaterialPageRoute(builder: (context) => AllAccountScreen(widget.projectId)))),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(border: Border.all(color: AppColors.lineColor, width: 2.0)),
              child: Text("Transfer funds", style: textStyle12px600w),
            )
                .onClick(() => Navigator.push(context, MaterialPageRoute(builder: (context) => TransferFundsScreen()))),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(border: Border.all(color: AppColors.lineColor, width: 2.0)),
              child: Text("Add / Remove / Edit Employee", style: textStyle12px600w),
            ).onClick(() => Navigator.pushNamed(context, Screens.MANAGE_EMPLOYEE, arguments: widget.projectId)),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(border: Border.all(color: AppColors.lineColor, width: 2.0)),
              child: Text("View Attendance", style: textStyle12px600w),
            ).onClick(() => Navigator.pushNamed(context, Screens.VIEW_ATTENDANCE, arguments: widget.projectId)),
            Spacer(),
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

  Container cardViewAddEmployee(Data e) {
    return Container(
      color: AppColors.inputFieldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Name: ${e.firstName} ${e.lastName}", style: textStyle14px500w),
              Spacer(),
              Icon(Icons.add_box_outlined, color: AppColors.textColorSubText).onClick(() {
                // selectedEmployees.add(e);
                setState(() {});
              }),
            ],
          ),
          verticalSpace(4.0),
          Text("Employee Id: ${e.id}", style: textStyle12px500w),
          verticalSpace(4.0),
          Text("${e.designation ?? "NA"}", style: textStyleGreen14px500w),
        ],
      ),
    );
  }

  Container cardViewRemoveEmployee(Data e) {
    return Container(
      color: AppColors.inputFieldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${e.firstName} ${e.lastName}", style: textStyle14px500w),
                verticalSpace(4.0),
                Text("Employee Id: ${e.id}", style: textStyle12px500w),
                verticalSpace(4.0),
                Text("${e.designation ?? "NA"}", style: textStyleGreen14px500w),
              ],
            ),
          ),
          Column(
            children: [
              Icon(Icons.remove_circle_outline, color: AppColors.textColorSubText).onClick(() {
                deleteEmployee(e.id!);
              }),
              verticalSpace(4.0),
              Container(
                padding: EdgeInsets.all(2.2),
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.8, color: Colors.grey.shade700)),
                child: Icon(Icons.edit_outlined, color: AppColors.textColorSubText, size: 12.0).onClick(() {
                  removeEmployeeFromProject(e.id!, e.projectIdList!.projectId!.first);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> getAllUsers() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting all user list ...");
    var formData = FormData.fromMap({
      'Register': "Register",
    });

    GetAllUserResponse response = await apiController.post<GetAllUserResponse>(EndPoints.GET_ALL_USER, body: formData);
    Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      // FlutterToastX.showSuccessToastBottom(context, "Add employee using add button");

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
    GetAllUserResponse response = await apiController.post<GetAllUserResponse>(EndPoints.GET_ALL_USER, body: formData);
    if (response.status!.isApiSuccessful) {
      // FlutterToastX.showSuccessToastBottom(context, "Add employee using add button");
      allEmployeesList.clear();
      if (response.data?.isNotEmpty ?? false) allEmployeesList.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }

  Future<void> deleteEmployee(String userId) async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Deleting user ...");
    var formData = FormData.fromMap({
      'Register': "Register",
      'manage': userId,
      'Delete': "1",
      'user_id': userId,
    });

    GetAllUserResponse response = await apiController.post<GetAllUserResponse>(EndPoints.DELETE_USER, body: formData);
    Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      FlutterToastX.showSuccessToastBottom(context, "User deleted successfully");
      getAllUsersWithoutDialog();
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }

  Future<void> removeEmployeeFromProject(String userId, String projectId) async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Deleting user ...");
    var formData = FormData.fromMap({
      'Register': "Register",
      'manage': userId,
      'Remove': "1",
      'user_id': userId,
      'project_id': projectId,
    });

    GetAllUserResponse response = await apiController.post<GetAllUserResponse>(EndPoints.DELETE_USER, body: formData);
    Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      FlutterToastX.showSuccessToastBottom(context, "User deleted successfully");
      getAllUsersWithoutDialog();
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
