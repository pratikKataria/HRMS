import 'package:hrms/export.dart';
import 'package:hrms/ui/attendance/typeOne/model/GetEmployeeByIdResponse.dart';
import 'package:hrms/ui/attendance/typeOne/model/job_title_response.dart';
import 'package:hrms/ui/attendance/typeTwo/mark_attendance_type_two_response.dart';
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';

class MarkAttendanceTypeTwo extends StatefulWidget {
  final GetEmployeeByIdResponse? employeeResponse;

  const MarkAttendanceTypeTwo(this.employeeResponse, {Key? key}) : super(key: key);

  @override
  State<MarkAttendanceTypeTwo> createState() => _MarkAttendanceTypeTwoState();
}

class _MarkAttendanceTypeTwoState extends State<MarkAttendanceTypeTwo> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController blockNoController = TextEditingController();
  TextEditingController robotNoController = TextEditingController();
  TextEditingController inverterNoController = TextEditingController();

  List<GetEmployeeByIdResponse?> presentEmployees = [];

  String? selectedJob;
  List<JobTitleList> listOfJobs = [];

  @override
  void initState() {
    super.initState();
    presentEmployees.add(widget.employeeResponse);
    getJobTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Mark Attendance"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  verticalSpace(20.0),
                  HrmInputFieldDummy(headingText: "Title", text: selectedJob ?? "Select Title", mandate: true).onClick(() {
                    showJobDialog();
                  }),

                  verticalSpace(20.0),
                  HrmInputField(
                      textController: blockNoController, headingText: "Select Block No.", text: "Block Number", mandate: true),
                  verticalSpace(20.0),
                  HrmInputField(
                      textController: robotNoController, headingText: "Select Robot No.", text: "Robot Number", mandate: true),
                  verticalSpace(20.0),
                  HrmInputField(
                      textController: inverterNoController,
                      headingText: "Select Inverter No.",
                      text: "Inverter Number",
                      mandate: true),
                  verticalSpace(20.0),
                  line(),
                  verticalSpace(20.0),
                  Text("Present Employee", style: textStyle14px500w),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: presentEmployees
                    .map((e) => Container(
                          color: AppColors.inputFieldBackgroundColor,
                          padding: EdgeInsets.all(20.0),
                          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: ${e?.data?.first.firstName ?? ""} ${e?.data?.first.lastName ?? ""}",
                                  style: textStyle14px500w),
                              Text("Employee Id: ${e?.data?.first.id ?? ""}", style: textStyle14px500w),
                              verticalSpace(4.0),
                              Text("${e?.data?.first.designation ?? ""}", style: textStyleGreen14px500w),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            verticalSpace(10.0),
            // if (!employeeAdded)
            //   HrmGradientButton(text: "Add", margin: EdgeInsets.symmetric(horizontal: 20.0)).onClick(() {
            //     presentEmployees.add(widget.employeeResponse);
            //     setState(() {});
            //   }),

              Row(
                children: [
                horizontalSpace(20.0),
                Expanded(
                  child: HrmGradientButton(text: "Add More").onClick(() async {
                    String? empId = await Navigator.pushNamed(context, Screens.MULTI_QR_SCANNER_SCREEN) as String;
                    getEmployeeDataById(empId);
                  }),
                ),
                horizontalSpace(10.0),
                Expanded(child: HrmGradientButton(text: "Approve").onClick(() => markAttendance())),
                horizontalSpace(20.0),
              ],
              ),
            verticalSpace(10.0),
          ],
        ),
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

    String userId = presentEmployees.map((e) => e?.data?.first.id).toList().join(",");

    Map<String, dynamic> map = {
      "user_id": userId,
      "business_id": "12",
      "project_id": widget.employeeResponse?.data?.first.projectId,
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
    await Dialogs.hideLoader(context);
    if (markAttendanceTypeTwoResponse.status?.isApiSuccessful ?? false) {
      FlutterToastX.showSuccessToastBottom(context, markAttendanceTypeTwoResponse.message ?? "Attendance marked!");
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, Screens.VIEW_WORKORDER_SCREEN, arguments: widget.employeeResponse?.data?.first.projectId);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${markAttendanceTypeTwoResponse.message ?? ""}");
    }
  }

  Future<void> getEmployeeDataById(String userId) async {
    await Future.delayed(Duration(milliseconds: 400));
    Map<String, String> payload = {"GET": "get", "user_id": userId};
    Dialogs.showLoader(context, "Getting employee details ...");
    GetEmployeeByIdResponse response =
        await apiController.get<GetEmployeeByIdResponse>(EndPoints.GET_USER_PROFILE, payload: payload);
    await Dialogs.hideLoader(context);
    if (response.status?.isApiSuccessful ?? false) {
      presentEmployees.add(response);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
      Navigator.pop(context);
    }
    setState(() {});
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
        jobTitleController.text = selectedJob ?? "";
        // print("index of $stateName is ${listOfStates.indexOf(stateName!)}");
      });
    });
  }

  Future<void> getJobTitle() async {
    await Future.delayed(Duration(milliseconds: 200));
    Dialogs.showLoader(context, "Getting job list ...");
    JobTitleResponse addEmployeeResponse = await apiController.get<JobTitleResponse>(
      "https://vipugroup.com/final/Get_Job_list.php?project_id=12&business_id=12&GET=GET",
    );
    await Dialogs.hideLoader(context);
    if (addEmployeeResponse.status?.isApiSuccessful ?? false) {
      listOfJobs.addAll(addEmployeeResponse.jobTitleList!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${addEmployeeResponse.message ?? ""}");
    }
  }
}
