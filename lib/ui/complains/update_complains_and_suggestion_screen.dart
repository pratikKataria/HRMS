import 'package:hrms/export.dart';
import 'package:hrms/ui/attendance/typeOne/model/GetEmployeeByIdResponse.dart';
import 'package:hrms/ui/complains/model/submit_complain_response.dart';
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';

class UpdateComplainsAndSuggestionScreen extends StatefulWidget {
  final String? complaintId;

  // final GetEmployeeByIdResponse? employeeResponse;

  const UpdateComplainsAndSuggestionScreen(this.complaintId, {Key? key}) : super(key: key);

  @override
  State<UpdateComplainsAndSuggestionScreen> createState() => _UpdateComplainsAndSuggestionScreenState();
}

class _UpdateComplainsAndSuggestionScreenState extends State<UpdateComplainsAndSuggestionScreen> {
  TextEditingController complaintNoteController = TextEditingController();
  TextEditingController aadhaarCardTextController = TextEditingController();

  String? fileImageString;
  String? filePathString;
  String selectedType = "Open";

  List<GetEmployeeByIdResponse?> presentEmployees = [];
  List<String> listOfTypes = ["Open", "Close", "Under-Review"];

  @override
  void initState() {
    super.initState();
    // presentEmployees.add(widget.employeeResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Update Complain"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  verticalSpace(20.0),
                  HrmInputField(
                    textController: complaintNoteController,
                    headingText: "Admin Comments",
                    text: "Enter complaint note",
                    mandate: true,
                  ),
                  verticalSpace(20.0),
                  HrmInputFieldDummy(
                    headingText: "Select Status",
                    text: selectedType,
                    mandate: true,
                  ).onClick(() {
                    FocusScope.of(context).unfocus();
                    showComplaintStatusDialog();
                  }),
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
            HrmGradientButton(text: "Update", radius: 0.0).onClick(() async {
              addComplaint();
              // getEmployeeDataById(empId);
            }),
          ],
        ),
      ),
    );
  }

  void showComplaintStatusDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Wrap(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  color: AppColors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select From", style: textStyle14px600w),
                      verticalSpace(10.0),
                      ...listOfTypes.map((e) {
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
                                  Expanded(child: Text(e ?? "", style: textStyleSubText14px500w)),
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
            ],
          ),
        );
      },
    ).then((value) {
      setState(() {
        selectedType = value ?? selectedType;
      });
    });
  }

  Future<void> addComplaint() async {
    // await Future.delayed(Duration(milliseconds: 200));
    FocusScope.of(context).unfocus();

    if (complaintNoteController.text.toString().isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please enter complain note");
      return;
    }

    Map<String, dynamic> map = {
      "Register": "Register",
      "admin_note": complaintNoteController.text.toString(),
      "com_id": widget.complaintId,
      "update": "update",
      "status": selectedType,
    };
    var formData = FormData.fromMap(map);
    print(map);

    Dialogs.showLoader(context, "Creating complaint ...");
    SubmitComplainResponse markAttendanceTypeTwoResponse = await apiController.post<SubmitComplainResponse>(
      EndPoints.SUBMIT_COMPLAINTS,
      body: formData,
    );
    await Dialogs.hideLoader(context);
    if (markAttendanceTypeTwoResponse.status?.isApiSuccessful ?? false) {
      FlutterToastX.showSuccessToastBottom(context, markAttendanceTypeTwoResponse.message ?? "Attendance marked!");
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
      Navigator.pop(context);
      // Navigator.pop(context);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${markAttendanceTypeTwoResponse.message ?? ""}");
    }
  }
}
