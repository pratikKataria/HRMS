import 'package:hrms/export.dart';
import 'package:hrms/ui/addClient/model/add_client_request.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_response.dart';

class BankDetailClient extends StatefulWidget {
  const BankDetailClient({Key? key}) : super(key: key);

  @override
  State<BankDetailClient> createState() => _BankDetailClientState();
}

class _BankDetailClientState extends State<BankDetailClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Client Bank Detail"),
            Container(
              color: AppColors.alert,
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Center(child: Text("Fields marked in the red are compulsory", style: textStyleWhite12px600w)),
            ),

            //progress detail
            verticalSpace(20.0),
            Text("Detail progress", style: textStyleGreen14px500w),
            verticalSpace(20.0),
            Image(image: AssetImage(Assets.imagesIcDetailProcessFour), height: 40.0),
            verticalSpace(10.0),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Account Number", text: "Enter skill"),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "IFSC Code", text: "Enter company name"),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Aadhaar Card", text: "Enter joining date"),
                    verticalSpace(20.0),
                    HrmInputField(headingText: "Pan Card", text: "Enter working days"),
                    verticalSpace(20.0),
                    HrmGradientButton(text: "Confirm").onClick(() => Navigator.of(context).popUntil((route) => route.isFirst)),
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

  Future<void> registerClient(String userId) async {
    // await Future.delayed(Duration(milliseconds: 200));
    AddClientRequest addClientRequest = AddClientRequest();
    var formData = FormData.fromMap(addClientRequest.toJson());

    Dialogs.showLoader(context, "Marking attendance please wait ...");
    AddEmployeeResponse addEmployeeResponse = await apiController.post<AddEmployeeResponse>(
      EndPoints.REGISTER_CLIENT,
      body: formData,
    );
    Dialogs.hideLoader(context);
    if (addEmployeeResponse.status?.isApiSuccessful ?? false) {
      FlutterToastX.showSuccessToastBottom(context, addEmployeeResponse.message ?? "Attendance marked!");
      // Navigator.pushReplacementNamed(context, Screens.HOME_SCREEN);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${addEmployeeResponse.message ?? ""}");
    }
  }
}
