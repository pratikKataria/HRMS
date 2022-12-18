import 'package:hrms/export.dart';
import 'package:hrms/ui/attendance/typeOne/model/GetEmployeeByIdResponse.dart';
import 'package:hrms/ui/complains/model/submit_complain_response.dart';

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

  List<GetEmployeeByIdResponse?> presentEmployees = [];

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
                      textController: complaintNoteController, headingText: "Admin Comments", text: "enter complaint note"),
                  verticalSpace(20.0),
                  /*  HrmInputFieldDummy(
                    textController: aadhaarCardTextController,
                    headingText: fileImageString,
                    text: "Attach image",
                    leftWidget: Icon(Icons.attach_file),
                    inputTypeNumber: true,
                    inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                  ).onClick(() async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                    fileImageString = image?.name;
                    if (image != null) {
                      final File imageFile = File(image.path);
                      filePathString = imageFile.path;
                    }
                    setState(() {});
                  }),*/
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
            HrmGradientButton(text: "Close Complaint", radius: 0.0).onClick(() async {
              addComplaint();
              // getEmployeeDataById(empId);
            }),
          ],
        ),
      ),
    );
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
      "status": "close",
    };
    var formData = FormData.fromMap(map);
    print(map);

    Dialogs.showLoader(context, "Creating complaint ...");
    SubmitComplainResponse markAttendanceTypeTwoResponse = await apiController.post<SubmitComplainResponse>(
      EndPoints.ADD_EMPLOYEE_IN_PROJECT,
      body: formData,
    );
    Dialogs.hideLoader(context);
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
