import 'package:hrms/export.dart';
import 'package:hrms/ui/addClient/model/get_all_user_response.dart';
import 'package:hrms/ui/attendance/typeOne/model/job_title_response.dart';
import 'package:hrms/ui/attendance/typeOne/model/mark_attendance_type_one_response.dart';
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';
import 'package:intl/intl.dart';

class MarkAttendanceTypeOneV2 extends StatefulWidget {
  final String projectId;
  const MarkAttendanceTypeOneV2(this.projectId,{Key? key}) : super(key: key);

  @override
  State<MarkAttendanceTypeOneV2> createState() => _MarkAttendanceTypeOneV2State();
}

class _MarkAttendanceTypeOneV2State extends State<MarkAttendanceTypeOneV2> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController searchTextController = TextEditingController();

  Set<Data> allEmployeesList = Set();
  Set<Data> selectedEmployees = Set();

  String? selectedJob;
  List<JobTitleList> listOfJobs = [];


  @override
  void initState() {
    super.initState();

    getAllUsers();
    getJobTitle();
    searchTextController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Mark Attendance"),
            HrmInputFieldDummy (
              headingText: "Title",
              text: selectedJob ?? "Select Title",
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              mandate: true,
            ).onClick(() {
              showJobDialog();
            }),

            verticalSpace(10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(alignment: Alignment.centerLeft, child: Text("Add Employee in project", style: textStyle14px600w)),
            ),

            HrmInputField(
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
                      .difference(selectedEmployees)
                      .where((element) =>
                          (element.firstName ?? "")
                              .toString()
                              .toLowerCase()
                              .contains(searchTextController.text.toString().toLowerCase()) ||
                          (element.lastName ?? "")
                              .toString()
                              .toLowerCase()
                              .contains(searchTextController.text.toString().toLowerCase()))
                      .map((e) => cardViewAddEmployee(e))
                      .toList(),
                ),
              ),
            ),

            verticalSpace(6.0),

            Expanded(
              child: ListView(
                children: selectedEmployees.map((e) => cardViewRemoveEmployee(e)).toList(),
              ),
            ),

            verticalSpace(20.0),
            HrmGradientButton(text: "Approve", radius: 0,).onClick(() => markAttendance()),
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

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);

    String userId = selectedEmployees.map((e) => e.id).toList().join(",");


    var formData = FormData.fromMap({
      "Login": "Login",
      "user_id": userId,
      "project_id":  widget.projectId??"",
      "business_id": "12",
      "clock_in_time": formattedDate,
      "clock_in_note": "na",
      "clock_out_note": "test",
      "job_title": jobTitleController.text.toString(),
      "status": "IN",
    });

    Dialogs.showLoader(context, "Marking attendance please wait ...");
    MarkAttendanceTypeOneResponse attendanceTypeOneResponse = await apiController.post<MarkAttendanceTypeOneResponse>(
      EndPoints.ATTENDANCE_TYPE_ONE,
      body: formData,
    );
    await Dialogs.hideLoader(context);
    if (attendanceTypeOneResponse.status?.isApiSuccessful ?? false) {
      FlutterToastX.showSuccessToastBottom(context, attendanceTypeOneResponse.message ?? "Attendance marked!");
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${attendanceTypeOneResponse.message ?? ""}");
    }
  }

  Future<void> getAllUsers() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting all user list ...");
    var formData = FormData.fromMap({
      'Register': "Register",
      'project_id': widget.projectId??"",
    });

    GetAllUserResponse response = await apiController.post<GetAllUserResponse>(EndPoints.GET_ALL_USER_V2, body: formData);
    await Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      FlutterToastX.showSuccessToastBottom(context, "Add employee using add button");

      allEmployeesList.clear();
      if (response.data?.isNotEmpty ?? false) allEmployeesList.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }


  void showJobDialog() {
    showDialog<JobTitleList>(
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
                    Text("Select Job", style: textStyle14px600w),
                    verticalSpace(10.0),
                    ...listOfJobs.map((e) {
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
                                Expanded(child: Text("${e.jobTitle}", style: textStyleSubText14px500w)),
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
        selectedJob = value?.jobTitle;
        jobTitleController.text = selectedJob??"";
        // print("index of $stateName is ${listOfStates.indexOf(stateName!)}");
      });
    });
  }

  Future<void> getJobTitle() async {
    await Future.delayed(Duration(milliseconds: 200));
    // Dialogs.showLoader(context, "Getting job list ...");
    JobTitleResponse addEmployeeResponse = await apiController.get<JobTitleResponse>(
      "https://vipugroup.com/final/Get_Job_list.php?project_id=12&business_id=12&GET=GET",
    );
    // await Dialogs.hideLoader(context);
    if (addEmployeeResponse.status?.isApiSuccessful ?? false) {
      listOfJobs.addAll(addEmployeeResponse.jobTitleList!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${addEmployeeResponse.message ?? ""}");
    }
  }
}
