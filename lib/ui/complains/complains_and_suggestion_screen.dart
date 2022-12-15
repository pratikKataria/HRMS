import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/attendance/typeOne/model/GetEmployeeByIdResponse.dart';
import 'package:hrms/ui/attendance/typeTwo/mark_attendance_type_two_response.dart';
import 'package:hrms/ui/complains/model/submit_complain_response.dart';
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';
import 'package:image_picker/image_picker.dart';

class ComplainsAndSuggestionScreen extends StatefulWidget {
  // final GetEmployeeByIdResponse? employeeResponse;

  const ComplainsAndSuggestionScreen(/*this.employeeResponse,*/ {Key? key}) : super(key: key);

  @override
  State<ComplainsAndSuggestionScreen> createState() => _ComplainsAndSuggestionScreenState();
}

class _ComplainsAndSuggestionScreenState extends State<ComplainsAndSuggestionScreen> {
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Add Complain"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  verticalSpace(20.0),
                  HrmInputField(textController: complaintNoteController, headingText: "Complain Note", text: "enter complaint note"),
                  verticalSpace(20.0),
                  HrmInputFieldDummy(
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
            HrmGradientButton(text: "Submit", radius: 0.0).onClick(() async {
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
      "Add": "Add",
      "user_id": "26", //todo change this
      "msg": complaintNoteController.text.toString(),
      // "file": "1",
      "file": filePathString == null ? "" : await MultipartFile.fromFile(filePathString ?? "", filename: "aadharImage.jpg"),
    };
    var formData = FormData.fromMap(map);
    print(map);

    Dialogs.showLoader(context, "Creating complain ...");
    SubmitComplainResponse markAttendanceTypeTwoResponse = await apiController.post<SubmitComplainResponse>(
      EndPoints.SUBMIT_COMPLAINTS,
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

  Future<void> submitComplains() async {
    await Future.delayed(Duration(milliseconds: 200));
    // Map<String, String> payload = {"GET": "get", "user_id": userId};
    Dialogs.showLoader(context, "Getting employee details ...");
    GetEmployeeByIdResponse response = await apiController.get<GetEmployeeByIdResponse>(EndPoints.COMPLAINS);
    Dialogs.hideLoader(context);
    if (response.status?.isApiSuccessful ?? false) {
      presentEmployees.add(response);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response?.message ?? ""}");
      Navigator.pop(context);
    }
    setState(() {});
  }
}
