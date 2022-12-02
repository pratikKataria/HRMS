import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrms/api/api_controller_expo.dart';
import 'package:hrms/api/end_points.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/ui/login/login_response.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/flutter_toast.dart';
import 'package:hrms/widgets/hrm_gradient_button.dart';
import 'package:hrms/widgets/hrm_input_fields.dart';
import 'package:hrms/widgets/widget_util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 210.0,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesImgLogin), fit: BoxFit.fill)),
            ),
            verticalSpace(10.0),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Go ", style: textStyleRegular16px500w),
                  TextSpan(text: "Beyond\n", style: textStyle14px500wF2),
                  TextSpan(text: "with\n", style: textStyleRegular16px500w),
                  TextSpan(text: "HRMS", style: textStyleDark16px600wh2),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(8.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputField(
                      text: "Enter email address",
                      headingText: "Email Address",
                      leftWidget: Text("@", style: textStyle14px600w),
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      text: "Enter password",
                      headingText: "Password",
                      password: true,
                      leftWidget: Icon(Icons.lock),
                    ),
                    verticalSpace(20.0),
                    HrmGradientButton(text: "Login").onClick(() => doLogin()),
                    Column(
                      children: <Widget>[
                        verticalSpace(20.0),
                        Text("Forgot Password?", style: textStyle14px500w),
                        verticalSpace(20.0),
                        FittedBox(child: Text("By clicking on login button you are accepting our", style: textStyle12px500w)),
                        verticalSpace(4.0),
                        Text("Terms and Conditions", style: textStylePrimary12px500wUnderline),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> doLogin() async {
    var formData = FormData.fromMap({'user_id': "vinode2@gmail.com", 'password': "1234568", 'Login': "Login"});
    LoginResponse response = await apiController.post<LoginResponse>(EndPoints.LOGIN, body: formData);
    if (response.status!.isApiSuccessful) {
      FlutterToastX.showSuccessToastBottom(context, "Login successful");
      Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed to Login ${response.message ?? ""}");
    }
  }
}
