import 'package:hrms/export.dart';
import 'package:hrms/ui/attendance/typeOne/model/GetEmployeeByIdResponse.dart';
import 'package:hrms/ui/attendance/typeOne/model/mark_attendance_type_one_response.dart';
import 'package:hrms/ui/scanned/employee_response.dart';
import 'package:intl/intl.dart';

class MarkAttendanceTypeOne extends StatefulWidget {
  final GetEmployeeByIdResponse? employeeResponse;

  const MarkAttendanceTypeOne(this.employeeResponse, {Key? key}) : super(key: key);

  @override
  State<MarkAttendanceTypeOne> createState() => _MarkAttendanceTypeOneState();
}

class _MarkAttendanceTypeOneState extends State<MarkAttendanceTypeOne> {
  TextEditingController jobTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Mark Attendance"),
            verticalSpace(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  HrmInputField(headingText: "Title", text: "Enter job title", textController: jobTitleController),
                  verticalSpace(20.0),

                  //Select employee filter
                  /* Container(
                    height: 45.0,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: AppColors.inputFieldBackgroundColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Select Employee", style: textStyleSubText14px500w),
                        Icon(Icons.filter_list_sharp, size: 20.0),
                      ],
                    ),
                  ),*/

                  verticalSpace(20.0),
                  line(),
                  verticalSpace(20.0),
                  Text("Present Employee", style: textStyle14px500w),
                  verticalSpace(10.0),

                  //employee detail block
                  Container(
                    color: AppColors.inputFieldBackgroundColor,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Name: ${widget.employeeResponse?.data?.first.firstName ?? ""} ${widget.employeeResponse?.data?.first.lastName ?? ""}",
                            style: textStyle14px500w),
                        Text("Employee Id: ${widget.employeeResponse?.data?.first.id ?? ""}", style: textStyle14px500w),
                        verticalSpace(4.0),
                        Text("${widget.employeeResponse?.data?.first.designation ?? ""}", style: textStyleGreen14px500w),
                      ],
                    ),
                  ),

                  verticalSpace(50.0),
                  HrmGradientButton(text: "Approve").onClick(() => markAttendance()),
                ],
              ),
            ),
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

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);

    var formData = FormData.fromMap({
      "Login": "Login",
      "user_id": widget.employeeResponse?.data?.first.id ?? "",
      "project_id": widget.employeeResponse?.data?.first.projectId,
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

}
