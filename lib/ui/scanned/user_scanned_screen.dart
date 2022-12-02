import 'package:hrms/export.dart';
import 'package:hrms/ui/scanned/employee_response.dart';

class UserScannedScreen extends StatefulWidget {
  final String arguments;
  const UserScannedScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  State<UserScannedScreen> createState() => _UserScannedScreenState();
}

class _UserScannedScreenState extends State<UserScannedScreen> {
  EmployeeResponse? response;

  @override
  void initState() {
    getEmployeeDataById(widget.arguments);
    super.initState();
  }

  Future<void> getEmployeeDataById(String userId) async {
    await Future.delayed(Duration(milliseconds: 200));
    Map<String, String> payload = {"GET": "get", "user_id": userId};
    Dialogs.showLoader(context, "Getting employee details ...");
    response = await apiController.get<EmployeeResponse>(EndPoints.GET_USER_PROFILE, payload: payload);
    Dialogs.hideLoader(context);
    if (response?.status?.isApiSuccessful  ?? false) {
      FlutterToastX.showSuccessToastBottom(context, "Mark Attendance one or two");
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response?.message ?? ""}");
      Navigator.pop(context);
    }
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Scanned View"),
            verticalSpace(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: AppColors.inputFieldBackgroundColor,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${response?.data?.first.firstName?? ""} ${response?.data?.first.lastName??""}",
                            style: textStyle14px500w),
                        Text("Employee Id: ${response?.data?.first.id??""}", style: textStyle14px500w),
                        verticalSpace(4.0),
                        Text("${response?.data?.first.designation??""}", style: textStyleGreen14px500w),
                      ],
                    ),
                  ),
                  verticalSpace(20.0),
                  Row(
                    children: [
                      Flexible(
                        child: HrmGradientButton(text: "Attendance T1")
                            .onClick(() => Navigator.pushNamed(context, Screens.ATTENDANCE_TYPE_ONE, arguments: response)),
                      ),
                      horizontalSpace(20.0),
                      Flexible(
                        child: HrmGradientButton(text: "Attendance T2")
                            .onClick(() => Navigator.pushNamed(context, Screens.ATTENDANCE_TYPE_TWO, arguments: response)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            verticalSpace(20.0),
          ],
        ),
      ),
    );
  }
}
