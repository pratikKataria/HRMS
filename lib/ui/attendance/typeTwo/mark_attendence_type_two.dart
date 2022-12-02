import 'package:hrms/export.dart';
import 'package:hrms/ui/attendance/typeTwo/mark_attendance_type_two_response.dart';
import 'package:hrms/ui/scanned/employee_response.dart';

class MarkAttendanceTypeTwo extends StatefulWidget {
  final EmployeeResponse employeeResponse;
  const MarkAttendanceTypeTwo(this.employeeResponse, {Key? key}) : super(key: key);

  @override
  State<MarkAttendanceTypeTwo> createState() => _MarkAttendanceTypeTwoState();
}

class _MarkAttendanceTypeTwoState extends State<MarkAttendanceTypeTwo> {
  TextEditingController blockNoController = TextEditingController();
  TextEditingController robotNoController = TextEditingController();
  TextEditingController inverterNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: ListView(
          children: [
            Header(headerText: "Mark Attendance"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  verticalSpace(20.0),
                  HrmInputField(textController: blockNoController, headingText: "Select Block No.", text: "Block Number"),
                  verticalSpace(20.0),
                  HrmInputField(textController: robotNoController, headingText: "Select Robot No.", text: "Robot Number"),
                  verticalSpace(20.0),
                  HrmInputField(
                    textController: inverterNoController,
                    headingText: "Select Inverter No.",
                    text: "Inverter Number",
                  ),
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
                            "Name: ${widget.employeeResponse.data?.first.firstName ?? ""} ${widget.employeeResponse?.data?.first.lastName ?? ""}",
                            style: textStyle14px500w),
                        Text("Employee Id: ${widget.employeeResponse?.data?.first.id ?? ""}", style: textStyle14px500w),
                        verticalSpace(4.0),
                        Text("${widget.employeeResponse?.data?.first.designation ?? ""}", style: textStyleGreen14px500w),
                      ],
                    ),
                  ),

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
    FocusScope.of(context).unfocus();

    var formData = FormData.fromMap({
      "user_id": widget.employeeResponse.data?.first.id ?? "",
      "business_id": "12",
      "project_id": "20",
      "clock_in_note": "test",
      "blockno": blockNoController.text.toString(),
      "robotno": robotNoController.text.toString(),
      "inverterno": inverterNoController.text.toString(),
      "type": "2",
      "Login": "login"
    });

    print(formData.fields);

    Dialogs.showLoader(context, "Marking attendance please wait ...");
    MarkAttendanceTypeTwoResponse markAttendanceTypeTwoResponse = await apiController.post<MarkAttendanceTypeTwoResponse>(
      EndPoints.ATTENDANCE_TYPE_TWO,
      body: formData,
    );
    Dialogs.hideLoader(context);
    if (markAttendanceTypeTwoResponse.status?.isApiSuccessful ?? false) {
      FlutterToastX.showSuccessToastBottom(context, markAttendanceTypeTwoResponse.message ?? "Attendance marked!");
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${markAttendanceTypeTwoResponse.message ?? ""}");
    }
  }
}
