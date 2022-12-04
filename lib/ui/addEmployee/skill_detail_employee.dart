import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hrms/export.dart';
import 'package:hrms/ui/addClient/skill_detail_client.dart';
import 'package:hrms/util/utility.dart';
import 'package:hrms/widgets/hrm_input_fields_dummy.dart';

// late AddEmployeeRequest addEmployeeRequest = AddEmployeeRequest();

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
  List<String> shiftList = ["Day", "Night"];

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
                    if (isSkilled) ...[
                      verticalSpace(10.0),
                      HrmInputField(
                        textController: skillsTextController,
                        headingText: "Select Skill",
                        text: "Enter skill (ex: Carpenter, Painter)",
                        mandate: true,
                        inputFilters: [LengthLimitingTextInputFormatter(256)],
                      ),
                      verticalSpace(20.0),
                      HrmInputField(
                        textController: companyTextController,
                        headingText: "Company",
                        text: "Enter company name",
                        mandate: true,
                        inputFilters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                          LengthLimitingTextInputFormatter(64)
                        ],
                      ),
                      verticalSpace(20.0),

                      HrmInputFieldDummy(
                        textController: joiningDateTextController,
                        headingText: "Joining Date",
                        text: doj ?? "DD/MM/YYYY",
                      ).onClick(() {
                        FocusScope.of(context).unfocus();
                        _selectDate(context);
                      }),
                      verticalSpace(20.0),
                      HrmInputField(
                          textController: workingdaysTextController,
                          headingText: "Working days",
                          text: "Enter working days",
                          inputTypeNumber: true,
                          inputFilters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
                          inputLength: 10),

                      verticalSpace(20.0),
                      HrmInputFieldDummy(
                        textController: shiftsTimingTextController,
                        headingText: "Shifts Timing",
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
                            child: HrmInputField(
                              textController: pfEmpContributionTextController,
                              headingText: "Employee Contribution",
                              text: "ex. 4.5%",
                              inputTypeNumber: true,
                              inputFilters: [
                                FilteringTextInputFormatter.allow(RegExp("^[+-]?(([1-9][0-9]*)?[0-9](\.[0-9]*)?|\.[0-9]+)")),
                                LengthLimitingTextInputFormatter(4)
                              ],
                            ),
                          ),
                          horizontalSpace(20.0),
                          Expanded(
                            child: HrmInputField(
                              textController: pfEmperContributionTextController,
                              headingText: "Employer Contribution",
                              text: "ex. 4.5%",
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
                            child: HrmInputField(
                              textController: esicEmpContributionTextController,
                              headingText: "Employee Contribution",
                              text: "ex. 4.5%",
                              inputTypeNumber: true,
                              inputFilters: [
                                FilteringTextInputFormatter.allow(RegExp("^[+-]?(([1-9][0-9]*)?[0-9](\.[0-9]*)?|\.[0-9]+)")),
                                LengthLimitingTextInputFormatter(4)
                              ],
                            ),
                          ),
                          horizontalSpace(20.0),
                          Expanded(
                            child: HrmInputField(
                              textController: esicEmperContributionTextController,
                              headingText: "Employer Contribution",
                              text: "ex. 4.5%",
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
              bool isValidationFailed = !validateInputFields();
              if (isValidationFailed) return;

              addEmployeeRequest.skills = skillsTextController.text.toString();
              addEmployeeRequest.company = companyTextController.text.toString();
              addEmployeeRequest.doj = joiningDateTextController.text.toString();
              addEmployeeRequest.workingdays = workingdaysTextController.text.toString();
              addEmployeeRequest.shiftTime = selectedShift;
              addEmployeeRequest.department = departmentTextController.text.toString();
              // addEmployeeRequest.pf = departmentTextController.text.toString();
              addEmployeeRequest.uan = uanTextController.text.toString();
              addEmployeeRequest.pfemployeecontribution = pfEmpContributionTextController.text.toString();
              addEmployeeRequest.pfemployercontribution = pfEmperContributionTextController.text.toString();
              addEmployeeRequest.esicemployeecontribution = esicEmpContributionTextController.text.toString();
              addEmployeeRequest.esicemployercontribution = esicEmperContributionTextController.text.toString();
              // addEmployeeRequest.joiningDate = landmarkTextController.text.toString();

              Navigator.pushNamed(context, Screens.EMPLOYEE_BANK_DETAIL);
            }),
            verticalSpace(20.0),
          ],
        ),
      ),
    );
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
    if (skillsTextController.text.isEmpty) {
      showErrorToast("Please enter skill");
      return false;
    }
    if (companyTextController.text.isEmpty) {
      showErrorToast("Please enter company name");
      return false;
    }
    if (joiningDateTextController.text.isEmpty) {
      showErrorToast("Please enter joining date");
      return false;
    }
    //if (workingdaysTextController.text.isEmpty){ showErrorToast("Please enter working days"); return false;}
    //if (shiftsTimingTextController.text.isEmpty){ showErrorToast("Please enter shift timing"); return false;}
    //if (departmentTextController.text.isEmpty){ showErrorToast("Please enter department"); return false;}
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
}
