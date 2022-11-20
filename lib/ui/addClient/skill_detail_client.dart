import 'package:flutter/material.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/widget_util.dart';

class SkillDetailClient extends StatefulWidget {
  const SkillDetailClient({Key? key}) : super(key: key);

  @override
  State<SkillDetailClient> createState() => _SkillDetailClientState();
}

class _SkillDetailClientState extends State<SkillDetailClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Client Skill Detail"),
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add Employee", style: textStyle14px600w),
                      Text("Add New+", style: textStylePrimary14px600w),
                    ],
                  ),
                  verticalSpace(20.0),
                  Container(
                    color: AppColors.inputFieldBackgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Rajesh shree vashtav", style: textStyle14px500w),
                            Spacer(),
                            Icon(Icons.delete, color: AppColors.textColorSubText,),
                          ],
                        ),
                        verticalSpace(4.0),
                        Text("Employee Id: 45331233", style: textStyle12px500w),
                        verticalSpace(4.0),
                        Text("Receptionist", style: textStyleGreen14px500w),
                      ],
                    ),
                  ),
                  verticalSpace(20.0),
                  HrmGradientButton(text: "Next").onClick(() => Navigator.pushNamed(context, Screens.CLIENT_BANK_DETAIL)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
