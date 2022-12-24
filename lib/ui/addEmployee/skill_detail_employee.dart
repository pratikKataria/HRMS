import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/addEmployee/aadhaar_verification_screen.dart';
import 'package:hrms/ui/addEmployee/model/company_list_response.dart';
import 'package:hrms/ui/addEmployee/model/skill_list_response.dart';
import 'package:hrms/util/utility.dart';
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';

class SkillDetailEmployee extends StatefulWidget {
  const SkillDetailEmployee({Key? key}) : super(key: key);

  @override
  State<SkillDetailEmployee> createState() => _SkillDetailEmployeeState();
}

class _SkillDetailEmployeeState extends State<SkillDetailEmployee> {
  bool isSkilled = false;

  TextEditingController skillsTextController = TextEditingController();
  TextEditingController companyTextController = TextEditingController();
  TextEditingController joiningDateTextController = TextEditingController();
  TextEditingController workingdaysTextController = TextEditingController();
  TextEditingController shiftsTimingTextController = TextEditingController();
  TextEditingController departmentTextController = TextEditingController();
  TextEditingController uanTextController = TextEditingController();
  TextEditingController esicTextController = TextEditingController();
  TextEditingController pfEmpContributionTextController = TextEditingController();
  TextEditingController pfEmperContributionTextController = TextEditingController();

  TextEditingController esicEmpContributionTextController = TextEditingController();
  TextEditingController esicEmperContributionTextController = TextEditingController();

  String? doj;
  String selectedShift = "Day";
  String? selectedCompany;
  String? selectedSkill;
  List<String> shiftList = ["A", "B", "C"];
  List<ListOfParentCompanies> listOfCompanies = [];
  List<ListOfSkills> listOfSkills = [];

  @override
  void initState() {
    super.initState();
    getAllCompanyNames();
    getAllSkillList();
    if (kDebugMode) testData();
  }

  testData() {
    skillsTextController.text = "Android";
    companyTextController.text = "TCS";
    joiningDateTextController.text = "25/05/1999";
    workingdaysTextController.text = "25";
    shiftsTimingTextController.text = "Day";
    esicEmpContributionTextController.text = "4";
    esicEmperContributionTextController.text = "5";
    doj = "25/05/1999";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Employee Skills Detail"),
            Container(
              color: AppColors.alert,
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Center(child: Text("Fields marked in the red are compulsory", style: textStyleWhite12px600w)),
            ),

            //progress detail
            verticalSpace(20.0),
            Text("Detail progress", style: textStyleGreen14px500w),
            verticalSpace(20.0),
            Image(image: AssetImage(Assets.imagesIcDetailProcessThree), height: 40.0),
            verticalSpace(10.0),

            verticalSpace(20.0),
            skillSwitch(),
            verticalSpace(10.0),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    /*if (isSkilled)*/ ...[
                      verticalSpace(10.0),
                      HrmInputFieldDummy(
                        textController: skillsTextController,
                        headingText:  "Select Skill",
                        text: selectedSkill ?? "Enter skill (ex: Carpenter, Painter)",
                        mandate: true,
                        inputFilters: [LengthLimitingTextInputFormatter(256)],
                      ).onClick(() {
                        showSkillDialog();
                      }),
                      verticalSpace(20.0),
                      HrmInputFieldDummy(
                        textController: companyTextController,
                        headingText: "Company",
                        text: selectedCompany ?? "Enter company name",
                        mandate: true,
                        inputFilters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                          LengthLimitingTextInputFormatter(64)
                        ],
                      ).onClick(() {
                        showCompanyDialog();
                      }),
                      verticalSpace(20.0),

                      HrmInputFieldDummy(
                        textController: joiningDateTextController,
                        headingText: "Joining Date",
                        text: doj ?? "DD/MM/YYYY",
                        mandate: true,
                      ).onClick(() {
                        FocusScope.of(context).unfocus();
                        _selectDate(context);
                      }),
                      verticalSpace(20.0),
                      HrmInputField(
                          textController: workingdaysTextController,
                          headingText: "Working days",
                          text: "Enter working days",
                          mandate: true,
                          inputTypeNumber: true,
                          inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
                          inputLength: 10),

                      verticalSpace(20.0),
                      HrmInputFieldDummy(
                        textController: shiftsTimingTextController,
                        headingText: "Shifts Timing",
                        mandate: true,
                        text: selectedShift,
                      ).onClick(() {
                        FocusScope.of(context).unfocus();
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
                                          Text("Select Shift Time", style: textStyle14px600w),
                                          verticalSpace(10.0),
                                          ...shiftList.map((e) {
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
                                                      Container(child: Text(e, style: textStyleSubText14px500w)),
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
                            selectedShift = value ?? "Day";
                          });
                        });
                      }),

                      verticalSpace(20.0),
                      HrmInputField(
                        textController: departmentTextController,
                        headingText: "Department",
                        text: "Enter department",
                        mandate: true,
                        inputFilters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                          LengthLimitingTextInputFormatter(64)
                        ],
                      ),
                      verticalSpace(20.0),

                      Text("Optional fields", style: textStyle14px600w),
                      verticalSpace(10.0),
                      line(width: Utility.screenWidth(context)),

                      //
                      verticalSpace(20.0),
                      HrmInputField(
                        textController: uanTextController,
                        headingText: "UAN",
                        text: "Enter UAN",
                        inputTypeNumber: true,
                        inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                      ),
                      verticalSpace(20.0),
                      Row(
                        children: [
                          Expanded(
                            child: HrmInputFieldDummy(
                              textController: pfEmpContributionTextController,
                              headingText: "Employee Contribution",
                              text: "12% Fixed",
                              inputTypeNumber: true,
                              inputFilters: [
                                FilteringTextInputFormatter.allow(RegExp("^[+-]?(([1-9][0-9]*)?[0-9](\.[0-9]*)?|\.[0-9]+)")),
                                LengthLimitingTextInputFormatter(4)
                              ],
                            ),
                          ),
                          horizontalSpace(20.0),
                          Expanded(
                            child: HrmInputFieldDummy(
                              textController: pfEmperContributionTextController,
                              headingText: "Employer Contribution",
                              text: "13% Fixed",
                              inputTypeNumber: true,
                              inputFilters: [
                                FilteringTextInputFormatter.allow(RegExp("^[+-]?(([1-9][0-9]*)?[0-9](\.[0-9]*)?|\.[0-9]+)")),
                                LengthLimitingTextInputFormatter(4)
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(20.0),
                      verticalSpace(20.0),
                      line(width: Utility.screenWidth(context)),
                      verticalSpace(20.0),

                      HrmInputField(
                        textController: esicTextController,
                        headingText: "ESIC",
                        text: "Enter esic",
                        inputTypeNumber: true,
                        inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(17)],
                      ),
                      verticalSpace(20.0),
                      Row(
                        children: [
                          Expanded(
                            child: HrmInputFieldDummy(
                              textController: esicEmpContributionTextController,
                              headingText: "Employee Contribution",
                              text: "0.75% Fixed",
                              inputTypeNumber: true,
                              inputFilters: [
                                FilteringTextInputFormatter.allow(RegExp("^[+-]?(([1-9][0-9]*)?[0-9](\.[0-9]*)?|\.[0-9]+)")),
                                LengthLimitingTextInputFormatter(4)
                              ],
                            ),
                          ),
                          horizontalSpace(20.0),
                          Expanded(
                            child: HrmInputFieldDummy(
                              textController: esicEmperContributionTextController,
                              headingText: "Employer Contribution",
                              text: "3.25% Fixed",
                              inputTypeNumber: true,
                              inputFilters: [
                                FilteringTextInputFormatter.allow(RegExp("^[+-]?(([1-9][0-9]*)?[0-9](\.[0-9]*)?|\.[0-9]+)")),
                                LengthLimitingTextInputFormatter(4)
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(20.0),
                    ],
                  ],
                ),
              ),
            ),

            //Next
            HrmGradientButton(margin: EdgeInsets.symmetric(horizontal: 20.0), text: "Next").onClick(() {
              if (isSkilled) {
                bool isValidationFailed = !validateInputFields();
                if (isValidationFailed) return;
              }

              addEmployeeRequest.skilled = isSkilled ? "1" : "0";
              addEmployeeRequest.skills = selectedSkill;
              addEmployeeRequest.company = selectedCompany;
              addEmployeeRequest.doj = joiningDateTextController.text.toString();
              addEmployeeRequest.workingdays = workingdaysTextController.text.toString();
              addEmployeeRequest.shiftTime = selectedShift;
              addEmployeeRequest.department = departmentTextController.text.toString();
              // addEmployeeRequest.pf = departmentTextController.text.toString();
              addEmployeeRequest.uan = uanTextController.text.toString();
              addEmployeeRequest.pfemployeecontribution = "12%";
              addEmployeeRequest.pfemployercontribution = "13%";
              addEmployeeRequest.esicemployeecontribution = "0.75%";
              addEmployeeRequest.esicemployercontribution = "3.25%";
              // addEmployeeRequest.joiningDate = landmarkTextController.text.toString();

              Navigator.pushNamed(context, Screens.EMPLOYEE_BANK_DETAIL);
            }),
            verticalSpace(20.0),
          ],
        ),
      ),
    );
  }

  void showCompanyDialog() {
    showDialog<ListOfParentCompanies>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: AppColors.white,
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select company", style: textStyle14px600w),
                    verticalSpace(10.0),
                    ...listOfCompanies.map((e) {
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
                                Expanded(child: Text("${e.companyName}", style: textStyleSubText14px500w)),
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
          ),
        );
      },
    ).then((value) {
      setState(() {
        selectedCompany = value?.companyName;
        // print("index of $stateName is ${listOfStates.indexOf(stateName!)}");
      });
    });
  }

  void showSkillDialog() {
    showDialog<ListOfSkills>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: AppColors.white,
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select skill", style: textStyle14px600w),
                    verticalSpace(10.0),
                    ...listOfSkills.map((e) {
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
                                Expanded(child: Text("${e.skills}", style: textStyleSubText14px500w)),
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
          ),
        );
      },
    ).then((value) {
      setState(() {
        selectedSkill = value?.skills;
        // print("index of $stateName is ${listOfStates.indexOf(stateName!)}");
      });
    });
  }

  Container skillSwitch() {
    return Container(
      height: 40.0,
      padding: EdgeInsets.only(left: 20.0, right: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(color: AppColors.inputFieldBackgroundColor, borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(alignment: Alignment.centerLeft, child: Text("Skilled", style: textStyleSubText14px500w)),
          CupertinoSwitch(
            value: isSkilled,
            activeColor: AppColors.colorPrimary,
            onChanged: (value) {
              isSkilled = !isSkilled;
              addEmployeeRequest.skilled = isSkilled ? "1" : "0";
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  bool validateInputFields() {
    if (skillsTextController.text.isEmpty) { showErrorToast("Please enter skill"); return false;}
    if (companyTextController.text.isEmpty) { showErrorToast("Please enter company name"); return false; }
    if (joiningDateTextController.text.isEmpty) { showErrorToast("Please enter joining date"); return false;}
    if (workingdaysTextController.text.isEmpty){ showErrorToast("Please enter working days"); return false;}
    // if (shiftsTimingTextController.text.isEmpty){ showErrorToast("Please enter shift timing"); return false;}
    if (departmentTextController.text.isEmpty){ showErrorToast("Please enter department"); return false;}
    //if (uanTextController.text.isEmpty){ showErrorToast("Please enter uan"); return false;}
    //if (pfEmpContributionTextController.text.isEmpty){ showErrorToast("Please enter pf employee contribution "); return false;}
    //if (pfEmperContributionTextController.text.isEmpty){ showErrorToast("Please enter pf employer contribution"); return false;}
    //if (esicEmpContributionTextController.text.isEmpty){ showErrorToast("Please enter pf esic employee contribution"); return false;}
    //if (esicEmperContributionTextController.text.isEmpty){ showErrorToast("Please enter esic employer contribution"); return false;}

    return true;
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );

    if (picked == null && doj != null)
      doj = doj;
    else if (picked == null)
      doj = null;
    else
      doj = "${picked.day}/${picked.month}/${picked.year}";

    setState(() {});
    joiningDateTextController.text = doj ?? "";
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
  }

  Future<void> getAllCompanyNames() async {
    await Future.delayed(Duration(milliseconds: 200));
    Dialogs.showLoader(context, "Getting company list ...");
    CompanyListResponse addEmployeeResponse = await apiController.get<CompanyListResponse>(
      "https://vipugroup.com/final/Get_Company_List.php?project_id=12&business_id=12&GET=GET",
    );
    await Dialogs.hideLoader(context);
    if (addEmployeeResponse.status?.isApiSuccessful ?? false) {
      listOfCompanies.addAll(addEmployeeResponse.listOfParentCompanies!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${addEmployeeResponse.message ?? ""}");
    }
  }

  Future<void> getAllSkillList() async {
    await Future.delayed(Duration(milliseconds: 200));
    // Dialogs.showLoader(context, "Getting company list ...");
    SkillListResponse addEmployeeResponse = await apiController.get<SkillListResponse>(
      "https://vipugroup.com/final/Get_skills_list.php?project_id=12&business_id=12&GET=GET",
    );
    // await Dialogs.hideLoader(context);
    if (addEmployeeResponse.status?.isApiSuccessful ?? false) {
      listOfSkills.addAll(addEmployeeResponse.listOfSkills!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${addEmployeeResponse.message ?? ""}");
    }
  }
}
