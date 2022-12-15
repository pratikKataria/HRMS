import 'package:hrms/export.dart';
import 'package:hrms/ui/complains/complains_and_suggestion_screen.dart';
import 'package:hrms/ui/complains/model/get_all_complains_response.dart';
import 'package:hrms/ui/manageAccount/add_account_screen.dart';
import 'package:hrms/util/utility.dart';

class ComplainsOptionsScreen extends StatefulWidget {
  final String projectId;

  const ComplainsOptionsScreen(this.projectId, {Key? key}) : super(key: key);

  @override
  State<ComplainsOptionsScreen> createState() => _ComplainsOptionsScreenState();
}

class _ComplainsOptionsScreenState extends State<ComplainsOptionsScreen> {
  Set<Data> allEmployeesList = Set();

  bool addNew = false;
  String? dob;

  @override
  void initState() {
    super.initState();
    getAllComplains();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => ComplainsAndSuggestionScreen()));
          getAllComplains();
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Header(headerText: "All Complains"),
            line(width: Utility.screenWidth(context)),
            verticalSpace(6.0),

            Expanded(child: ListView(children: allEmployeesList.map((e) => cardViewAccounts(e)).toList())),

            verticalSpace(10.0),
            // HrmGradientButton(margin: EdgeInsets.symmetric(horizontal: 20.0), text: "Add New").onClick(() {
            //   // if (selectedEmployees.isEmpty) {
            //   //   FlutterToastX.showErrorToastBottom(context, "Please select at least one employee");
            //   //   return;
            //   // }
            //
            //   // String selectedEmployeeStringCommaSeparated = selectedEmployees.map((e) => e.id).toList().join(",");
            //   // addClientRequest.employees = selectedEmployeeStringCommaSeparated;
            //   Navigator.pushNamed(context, Screens.AADHAAR_CARD_VERIFICATION_SCREEN);
            // }),
            // verticalSpace(10.0),
          ],
        ),
      ),
    );
  }

  Container cardViewAccounts(Data e) {
    return Container(
      color: AppColors.inputFieldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Cid: ${e.cid}", style: textStyle14px500w),
          Text("user_id: ${e.userId}", style: textStyle14px500w),
          Text("Title: ${e.msg}", style: textStyle14px500w),
          Text("Status: ${e.status}", style: textStyle14px500w),
        ],
      ),
    );
  }

  Future<void> getAllComplains() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting all complains...");
    var formData = FormData.fromMap({
      'Register': "Register",
      "All": "All",
    });

    GetAllComplainsResponse response = await apiController.post<GetAllComplainsResponse>(EndPoints.SUBMIT_COMPLAINTS, body: formData);
    await Future.delayed(Duration(milliseconds: 200));
    Dialogs.hideLoader(context);
    await Future.delayed(Duration(milliseconds: 200));
    if (response.status!.isApiSuccessful) {
      // FlutterToastX.showSuccessToastBottom(context, "Add employee using add button");
      allEmployeesList.addAll(response.data!);
      allEmployeesList.clear();
      if (response.data?.isNotEmpty ?? false) allEmployeesList.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
