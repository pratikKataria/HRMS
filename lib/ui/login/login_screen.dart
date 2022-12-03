import 'package:hrms/export.dart';
import 'package:hrms/res/keys.dart';
import 'package:hrms/ui/login/login_response.dart';
import 'package:hrms/util/shared_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

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
                      textController: emailTextEditingController,
                    ),
                    verticalSpace(20.0),
                    HrmInputField(
                      text: "Enter password",
                      headingText: "Password",
                      password: true,
                      leftWidget: Icon(Icons.lock),
                      textController: passwordTextEditingController,
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
    FocusScope.of(context).unfocus();

    if (emailTextEditingController.text.toString().isEmpty) {
      showErrorToast("Please enter email id ");
      return;
    }

    if (!emailTextEditingController.text.toString().isValidEmail) {
      showErrorToast("Please enter valid email id");
      return;
    }

    if (passwordTextEditingController.text.toString().isEmpty) {
      showErrorToast("Please enter password");
      return;
    }

    if (passwordTextEditingController.text.toString().length < 6) {
      showErrorToast("Please enter valid password");
      return;
    }

    Dialogs.showLoader(context, "Checking user detail ...");
    var formData = FormData.fromMap({
      'user_id': emailTextEditingController.text.toString(),
      'password': passwordTextEditingController.text.toString(),
      'Login': "Login"
    });
    LoginResponse response = await apiController.post<LoginResponse>(EndPoints.LOGIN, body: formData);
    Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      FlutterToastX.showSuccessToastBottom(context, "Login successful");
      SharedManager.setBooleanPreference(SharedPrefsKeys.kLoggedIn, true);
      Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
    } else {
      showErrorToast("Failed to Login ${response.message ?? ""}");
    }
  }

  void showErrorToast(String message) {
    FlutterToastX.showErrorToastBottom(context, message);
  }
}
