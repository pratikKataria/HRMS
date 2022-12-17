import 'package:hrms/export.dart';
import 'package:hrms/ui/addClient/model/get_all_user_response.dart';
import 'package:hrms/ui/attendance/typeTwo/mark_attendance_type_two_response.dart';

class MarkAttendanceTypeTwoV2 extends StatefulWidget {
  final String? projectId;

  const MarkAttendanceTypeTwoV2(this.projectId, {Key? key}) : super(key: key);

  @override
  State<MarkAttendanceTypeTwoV2> createState() => _MarkAttendanceTypeTwoV2State();
}

class _MarkAttendanceTypeTwoV2State extends State<MarkAttendanceTypeTwoV2> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController blockNoController = TextEditingController();
  TextEditingController robotNoController = TextEditingController();
  TextEditingController inverterNoController = TextEditingController();
  TextEditingController searchTextController = TextEditingController();

  Set<Data> allEmployeesList = Set();
  Set<Data> selectedEmployees = Set();

  bool addEmployeeToggle = false;

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
      body: WillPopScope(
        onWillPop: () {
          if (addEmployeeToggle) {
            addEmployeeToggle = !addEmployeeToggle;
            setState(() {});
            return Future(() => false);
          }
          Navigator.pop(context);
          return Future(() => false);
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(headerText: "Mark Attendance"),
              if (!addEmployeeToggle) ...[
                HrmInputField(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    textController: jobTitleController,
                    headingText: "Enter job title",
                    text: "Job Title",
                    mandate: true),
                verticalSpace(14.0),
                HrmInputField(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    textController: blockNoController,
                    headingText: "Select Block No.",
                    text: "Block Number",
                    mandate: true),
                verticalSpace(14.0),
                HrmInputField(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    textController: robotNoController,
                    headingText: "Select Robot No.",
                    text: "Robot Number",
                    mandate: true),
                verticalSpace(14.0),
                HrmInputField(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    textController: inverterNoController,
                    headingText: "Select Inverter No.",
                    text: "Inverter Number",
                    mandate: true),
                verticalSpace(20.0),
                Text("       Present Employee", style: textStyle14px600w),
                verticalSpace(4.0),
                Expanded(
                  child: ListView(children: selectedEmployees.map((e) => cardViewRemoveEmployee(e)).toList()),
                ),
              ],
              if (addEmployeeToggle) ...[
                HrmInputField(
                  headingText: "Search Employee",
                  text: "Type name to search",
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  leftWidget: Icon(Icons.search),
                  textController: searchTextController,
                ),
                verticalSpace(6.0),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(border: Border.all(color: AppColors.lineColor, width: 2.0)),
                    child: ListView(
                      children: allEmployeesList
                          // .difference(selectedEmployees)
                          .where((element) =>
                              (element.firstName ?? "")
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchTextController.text.toString().toLowerCase()) ||
                              (element.lastName ?? "")
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchTextController.text.toString().toLowerCase()))
                          .map((e) => selectedEmployees.contains(e) ? cardViewCheckedEmployee(e) : cardViewAddEmployee(e))
                          .toList(),
                    ),
                  ),
                ),
                // verticalSpace(6.0),
                // Expanded(
                //   child: ListView(children: selectedEmployees.map((e) => cardViewRemoveEmployee(e)).toList()),
                // ),
              ],
              verticalSpace(10.0),
              HrmGradientButton(
                      margin: EdgeInsets.symmetric(horizontal: 40.0), text: !addEmployeeToggle ? "Add Employee" : "Close")
                  .onClick(() => setState(() => addEmployeeToggle = !addEmployeeToggle)),
              verticalSpace(20.0),
              if (addEmployeeToggle == false) HrmGradientButton(text: "Approve", radius: 0).onClick(() => markAttendance()),
            ],
          ),
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
                selectedEmployees.add(e);
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

  Container cardViewCheckedEmployee(Data e) {
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
              Icon(Icons.check_box, color: AppColors.textColorGreen).onClick(() {
                selectedEmployees.remove(e);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Name: ${e.firstName} ${e.lastName}", style: textStyle14px500w),
              Spacer(),
              Icon(Icons.remove_circle_outline, color: AppColors.textColorSubText).onClick(() {
                selectedEmployees.remove(e);
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

  Future<void> markAttendance() async {
    // await Future.delayed(Duration(milliseconds: 200));
    FocusScope.of(context).unfocus();

    if (jobTitleController.text.toString().isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please enter job title");
      return;
    }

    if (blockNoController.text.toString().isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please enter block number");
      return;
    }

    if (robotNoController.text.toString().isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please enter robot no");
      return;
    }

    if (inverterNoController.text.toString().isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please enter inverter no");
      return;
    }

    if (selectedEmployees.isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please select employee");
      return;
    }

    String userId = selectedEmployees.map((e) => e.id).toList().join(",");

    Map<String, dynamic> map = {
      "user_id": userId,
      "business_id": "12",
      "project_id": widget.projectId,
      "clock_in_note": "test",
      "blockno": blockNoController.text.toString(),
      "robotno": robotNoController.text.toString(),
      "inverterno": inverterNoController.text.toString(),
      "type": "2",
      "Login": "login",
      "job_title": jobTitleController.text.toString(),
      "status": "IN"
    };
    var formData = FormData.fromMap(map);
    print(map);

    Dialogs.showLoader(context, "Marking attendance please wait ...");
    MarkAttendanceTypeTwoResponse markAttendanceTypeTwoResponse = await apiController.post<MarkAttendanceTypeTwoResponse>(
      EndPoints.ATTENDANCE_TYPE_TWO,
      body: formData,
    );
    Dialogs.hideLoader(context);
    if (markAttendanceTypeTwoResponse.status?.isApiSuccessful ?? false) {
      FlutterToastX.showSuccessToastBottom(context, markAttendanceTypeTwoResponse.message ?? "Attendance marked!");
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
      Navigator.pop(context); // manage employee
      Navigator.pop(context); // current pop
      Navigator.pushNamed(context, Screens.VIEW_WORKORDER_SCREEN, arguments: widget.projectId);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${markAttendanceTypeTwoResponse.message ?? ""}");
    }
  }

  // Future<void> getEmployeeDataById(String userId) async {
  //   await Future.delayed(Duration(milliseconds: 200));
  //   Map<String, String> payload = {"GET": "get", "user_id": userId};
  //   Dialogs.showLoader(context, "Getting employee details ...");
  //   GetEmployeeByIdResponse response =
  //       await apiController.get<GetEmployeeByIdResponse>(EndPoints.GET_USER_PROFILE, payload: payload);
  //   Dialogs.hideLoader(context);
  //   if (response.status?.isApiSuccessful ?? false) {
  //     presentEmployees.add(response);
  //     setState(() {});
  //   } else {
  //     FlutterToastX.showErrorToastBottom(context, "Failed: ${response?.message ?? ""}");
  //     Navigator.pop(context);
  //   }
  //   setState(() {});
  // }

  Future<void> getAllUsers() async {
    await Future.delayed(Duration(milliseconds: 400));

    Dialogs.showLoader(context, "Getting all user list ...");
    var formData = FormData.fromMap({
      'Register': "Register",
    });

    GetAllUserResponse response = await apiController.post<GetAllUserResponse>(EndPoints.GET_ALL_USER, body: formData);
    Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      FlutterToastX.showSuccessToastBottom(context, "Add employee using add button");

      allEmployeesList.clear();
      if (response.data?.isNotEmpty ?? false) allEmployeesList.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
