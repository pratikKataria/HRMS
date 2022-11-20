import 'package:flutter/material.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/hrm_input_fields.dart';
import 'package:hrms/widgets/widget_util.dart';

class BasicDetailClient extends StatefulWidget {
  const BasicDetailClient({Key? key}) : super(key: key);

  @override
  State<BasicDetailClient> createState() => _BasicDetailClientState();
}

class _BasicDetailClientState extends State<BasicDetailClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Client Basic Detail"),
            Container(
              color: AppColors.alert,
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Center(child: Text("Fields marked in the red are compulsory", style: textStyleWhite12px600w)),
            ),

            //progress detail
            verticalSpace(20.0),
            Text("Detail progress", style: textStyleGreen14px500w),
            verticalSpace(20.0),
            Image(image: AssetImage(Assets.imagesImgDetailProcessOne), height: 40.0),
            verticalSpace(10.0),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Client Name", text: "Enter client name", mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Registration Date", text: "Enter registration date", mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Registration Number", text: "Enter registration number", mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "GSTIN", text: "Enter GSTIN number"),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Contact Person Name", text: "Enter contact person name", mandate: true),
                    verticalSpace(20.0),
                    HrmInputField(
                      headingText: "Contact Person mobile Number",
                      text: "Enter contact person mobile number",
                      mandate: true,
                    ),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Contact Person Email Id", text: "Enter contact person email id", mandate: true),
                    verticalSpace(20.0),
                  ],
                ),
              ),
            ),
            verticalSpace(20.0),

            HrmGradientButton(text: "Next", margin: EdgeInsets.symmetric(horizontal: 20.0))
                .onClick(() => Navigator.pushNamed(context, Screens.CLIENT_ADDRESS_DETAIL)),
            verticalSpace(20.0),
          ],
        ),
      ),
    );
  }
}
