import 'package:hrms/export.dart';
import 'package:hrms/ui/manageEmployee/model/user_attendance_detail_response.dart';
import 'package:hrms/util/utility.dart';

class UserAttendanceDetailScreen extends StatefulWidget {
  final String projectId;
  final String userId;
  final String fromDate;
  final String toDate;

  const UserAttendanceDetailScreen(this.projectId, this.userId, this.fromDate, this.toDate, {Key? key}) : super(key: key);

  @override
  State<UserAttendanceDetailScreen> createState() => _UserAttendanceDetailScreenState();
}

class _UserAttendanceDetailScreenState extends State<UserAttendanceDetailScreen> {
  List<UserDetailData> listOfData = [];

  @override
  void initState() {
    super.initState();
    getUserAttendanceDetail();
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
            Header(headerText: "View Attendance"),
            line(width: Utility.screenWidth(context)),
            verticalSpace(20.0),
            Expanded(
              child: ListView(
                children: [
                  ...listOfData.map((e) => cardViewAddEmployee(e)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container cardViewAddEmployee(UserDetailData e) {
    return Container(
      color: AppColors.inputFieldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Emp Id: ${e.id} ", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Job Title: ${e.jobTitle} ", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Clock In: ${e.clockInTime} ", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Clock out: ${e.clockOutTime} ", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Half Day: ${e.halfday} ", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Type: ${e.type} ", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Block No: ${e.blockno} ", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Robot No: ${e.robotno} ", style: textStyle14px500w),
          verticalSpace(4.0),
          Text("Inverter No: ${e.inverterno} ", style: textStyle14px500w),
        ],
      ),
    );
  }

  Future<void> getUserAttendanceDetail() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting user detail ...");
    Map<String, String> data = {
      "GET": "GET",
      "date_from": widget.fromDate,
      "date_till": widget.toDate,
      "project_id": widget.projectId,
      "user_id": widget.userId,
      "All_data": "All_data",
    };

    UserAttendanceDetailResponse response =
        await apiController.get<UserAttendanceDetailResponse>(EndPoints.ATTENDANCE_REPORT, payload: data);
    await Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      listOfData.clear();
      listOfData.addAll(response.userDetailData!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
