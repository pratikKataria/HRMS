import 'package:hrms/export.dart';
import 'package:hrms/ui/attendance/typeTwo/mark_attendance_type_two_response.dart';

class MarkAttendanceTypeTwo extends StatefulWidget {
  const MarkAttendanceTypeTwo({Key? key}) : super(key: key);

  @override
  State<MarkAttendanceTypeTwo> createState() => _MarkAttendanceTypeTwoState();
}

class _MarkAttendanceTypeTwoState extends State<MarkAttendanceTypeTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
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
                  HrmInputField(headingText: "Select Block No.", text: "Block Number"),
                  verticalSpace(20.0),
                  HrmInputField(headingText: "Select Robot No.", text: "Robot Number"),
                  verticalSpace(20.0),
                  HrmInputField(headingText: "Select Inverter No.", text: "Inverter Number"),
                  verticalSpace(20.0),
                  line(),
                  verticalSpace(20.0),
                  Text("Present Employee", style: textStyle14px500w),
                  verticalSpace(50.0),
                  HrmGradientButton(text: "Approve").onClick(() => markAttendance("21")),
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
    var formData = FormData.fromMap({
      "user_id": "1212",
      "business_id": "12",
      "project_id": "20",
      "clock_in_note": "test",
      "blockno": "1",
      "robotno": "120",
      "inverterno": "450",
      "type": "2",
      "Login": "login"
    });

    Dialogs.showLoader(context, "Marking attendance please wait ...");
    MarkAttendanceTypeTwoResponse markAttendanceTypeTwoResponse = await apiController.post<MarkAttendanceTypeTwoResponse>(
      EndPoints.ATTENDANCE_TYPE_TWO,
      body: formData,
    );
    Dialogs.hideLoader(context);
    if (markAttendanceTypeTwoResponse.status?.isApiSuccessful ?? false) {
      FlutterToastX.showSuccessToastBottom(context, markAttendanceTypeTwoResponse.message ?? "Attendance marked!");
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${markAttendanceTypeTwoResponse.message ?? ""}");
    }
  }
}
