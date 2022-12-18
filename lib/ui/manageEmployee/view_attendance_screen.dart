import 'package:hrms/export.dart';
import 'package:hrms/ui/manageEmployee/model/view_attendance_response.dart';
import 'package:hrms/util/utility.dart';

class ViewAttendanceScreen extends StatefulWidget {
  final String projectId;

  const ViewAttendanceScreen(this.projectId, {Key? key}) : super(key: key);

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  String fromDateString = "";
  String toDateString = "";

  List<Data> listOfData = [];

  @override
  void initState() {
    super.initState();
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
            Header(headerText: "Manage Employee"),
            line(width: Utility.screenWidth(context)),
            verticalSpace(6.0),
            Row(
              children: [
                horizontalSpace(20.0),
                fromDate().onClick(() async {
                  fromDateString = await _selectDate();
                  setState(() {});
                  getAllUsers();
                }),
                horizontalSpace(20.0),
                toDate().onClick(() async {
                  toDateString = await _selectDate();
                  setState(() {});
                  getAllUsers();
                }),
                horizontalSpace(20.0),
              ],
            ),
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

  Column fromDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColors.buttonStartGradient, AppColors.buttonEndGradient],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.background,
                spreadRadius: 2.0,
                blurRadius: 8.0,
                offset: Offset(2, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("From Date", style: textStyleWhite14px500w),
              horizontalSpace(20.0),
              Icon(Icons.filter_list_sharp, size: 20.0, color: AppColors.white),
            ],
          ),
        ),
        verticalSpace(4.0),
        Text(fromDateString ?? "", style: textStyle14px500w)
      ],
    );
  }

  Column toDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColors.buttonStartGradient, AppColors.buttonEndGradient],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.background,
                spreadRadius: 2.0,
                blurRadius: 8.0,
                offset: Offset(2, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("To Date", style: textStyleWhite14px500w),
              horizontalSpace(20.0),
              Icon(Icons.filter_list_sharp, size: 20.0, color: AppColors.white),
            ],
          ),
        ),
        verticalSpace(4.0),
        Text(toDateString ?? "", style: textStyle14px500w)
      ],
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
          Text("Present: ${e.present}", style: textStyle14px500w),
          Text("Halfday: ${e.halfday}", style: textStyle14px500w),
          Text("user_id: ${e.userId} ", style: textStyle14px500w),
        ],
      ),
    );
  }

  Future<String> _selectDate() async {
    //2022-12-01 09:24:00
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );

    return "${picked?.year ?? "YY"}-${picked?.month ?? "MM"}-${picked?.day ?? "DD"} 09:24:00";
  }

  Future<void> getAllUsers() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting attendance ...");
      Map<String, String> data = {
      "GET": "GET",
      "date_from": fromDateString,
      "date_till": toDateString,
      "project_id": widget.projectId,
    };

    // Map<String, String> data = {
    //   "GET": "GET",
    //   "date_from": "2022-12-01 09:24:00",
    //   "date_till": "2022-12-30 09:24:00",
    //   "project_id": "20",
    // };

    ViewAttendanceResponse response = await apiController.get<ViewAttendanceResponse>(EndPoints.ATTENDANCE_REPORT, payload: data);
    Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      listOfData.clear();
      listOfData.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
