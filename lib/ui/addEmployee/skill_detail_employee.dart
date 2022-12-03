import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/ui/addEmployee/aadhaar_verification_screen.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/hrm_input_fields.dart';
import 'package:hrms/widgets/widget_util.dart';

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
  TextEditingController pfEmpContributionTextController = TextEditingController();
  TextEditingController pfEmperContributionTextController = TextEditingController();
  TextEditingController esicEmpContributionTextController = TextEditingController();
  TextEditingController esicEmperContributionTextController = TextEditingController();

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

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    Container(
                      height: 40.0,
                      padding: EdgeInsets.only(left: 20.0, right: 10.0),
                      decoration: BoxDecoration(
                        color: AppColors.inputFieldBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(alignment: Alignment.centerLeft, child: Text("Skilled", style: textStyleSubText14px500w)),
                          CupertinoSwitch(
                            value: isSkilled,
                            activeColor: AppColors.colorPrimary,
                            onChanged: (value) {
                              setState(() {
                                isSkilled = !isSkilled;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    verticalSpace(20.0),
                    HrmInputField(textController: skillsTextController, headingText: "Select Skill", text: "Enter skill"),
                    verticalSpace(20.0),
                    HrmInputField(
                        textController: companyTextController, headingText: "Company", text: "Enter company name", mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(
                        textController: joiningDateTextController,
                        headingText: "Joining Date",
                        text: "Enter joining date",
                        mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(
                        textController: workingdaysTextController, headingText: "Working days", text: "Enter working days"),
                    verticalSpace(20.0),
                    HrmInputField(textController: shiftsTimingTextController, headingText: "Shifts Timing", text: "Enter timing"),
                    verticalSpace(20.0),
                    HrmInputField(textController: departmentTextController, headingText: "Department", text: "Enter department"),
                    verticalSpace(20.0),
                    Container(
                      height: 40.0,
                      padding: EdgeInsets.only(left: 20.0, right: 10.0),
                      decoration: BoxDecoration(
                        color: AppColors.inputFieldBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(alignment: Alignment.centerLeft, child: Text("Provident Fund (PF)", style: textStyleSubText14px500w)),
                          CupertinoSwitch(
                            value: false,
                            activeColor: AppColors.colorPrimary,
                            onChanged: (value) {
                              setState(() {
                                isSkilled = !isSkilled;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    verticalSpace(20.0),
                    HrmInputField(textController: uanTextController, headingText: "UAN", text: "Enter UAN"),
                    verticalSpace(20.0),
                    Row(
                      children: [
                        Expanded(
                            child: HrmInputField(
                                textController: esicEmpContributionTextController,
                                headingText: "Employee Contribution",
                                text: "ex. 4.5%")),
                        horizontalSpace(20.0),
                        Expanded(
                            child: HrmInputField(
                                textController: esicEmperContributionTextController,
                                headingText: "Employer Contribution",
                                text: "ex. 4.5%")),
                      ],
                    ),
                    verticalSpace(20.0),
                    HrmGradientButton(text: "Next").onClick(() {
                      addEmployeeRequest.skills = skillsTextController.text.toString();
                      addEmployeeRequest.company = companyTextController.text.toString();
                      addEmployeeRequest.workingdays = joiningDateTextController.text.toString();
                      addEmployeeRequest.shiftTime = workingdaysTextController.text.toString();
                      addEmployeeRequest.department = shiftsTimingTextController.text.toString();
                      addEmployeeRequest.pf = departmentTextController.text.toString();
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
            ),
          ],
        ),
      ),
    );
  }
}
