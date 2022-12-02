import 'package:hrms/export.dart';
import 'package:hrms/ui/attendance/typeOne/mark_attendance_type_one_response.dart';
import 'package:hrms/ui/scanned/employee_response.dart';

class MarkAttendanceTypeOne extends StatefulWidget {
  const MarkAttendanceTypeOne({Key? key}) : super(key: key);

  @override
  State<MarkAttendanceTypeOne> createState() => _MarkAttendanceTypeOneState();
}

class _MarkAttendanceTypeOneState extends State<MarkAttendanceTypeOne> {
  EmployeeResponse? response;


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
                  HrmInputField(headingText: "Title", text: "Enter job title"),
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
                  verticalSpace(50.0),
                  HrmGradientButton(text: "Approve")
                  .onClick(() => markAttendance("22")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> markAttendance(String userId) async {
    // await Future.delayed(Duration(milliseconds: 200));
    Map<String, String> body = {
      "Login": "Login",
      "user_id": userId,
      "project_id": "12",
      "business_id": "12",
      "clock_in_time": "2020-01-01 12:12:00",
      "clock_in_note": "na",
      "clock_out_time": "2020-01-01 06:12:00",
      "clock_out_note": "test",
      "job_title": "test"
    };

    Dialogs.showLoader(context, "Marking attendance please wait ...");
    MarkAttendanceTypeOneResponse attendanceTypeOneResponse = await apiController.post<MarkAttendanceTypeOneResponse>(
      EndPoints.ATTENDANCE_TYPE_ONE,
      body: body,
    );
    Dialogs.hideLoader(context);
    if (response?.status?.isApiSuccessful ?? false) {
      FlutterToastX.showSuccessToastBottom(context, attendanceTypeOneResponse.message??"Attendance marked!");
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${attendanceTypeOneResponse.message ?? ""}");
    }
  }

}
