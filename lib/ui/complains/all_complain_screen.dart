import 'package:hrms/export.dart';
import 'package:hrms/ui/complains/complains_and_suggestion_screen.dart';
import 'package:hrms/ui/complains/model/get_all_complains_response.dart';
import 'package:hrms/ui/complains/update_complains_and_suggestion_screen.dart';
import 'package:hrms/util/utility.dart';

class AllComplainsScreen extends StatefulWidget {
  final String projectId;

  const AllComplainsScreen(this.projectId, {Key? key}) : super(key: key);

  @override
  State<AllComplainsScreen> createState() => _AllComplainsScreenState();
}

class _AllComplainsScreenState extends State<AllComplainsScreen> {
  Set<Data> listOfAllComplaints = Set();

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
        child: Icon(Icons.add),
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

            Expanded(
                child: ListView(
                    children: listOfAllComplaints
                        .map((e) => cardViewComplain(e).onClick(() async {
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateComplainsAndSuggestionScreen(e.cid)));
                              getAllComplainsWithoutLoader();
                            }))
                        .toList())),

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

  Container cardViewComplain(Data e) {
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
          verticalSpace(8.0),
          Center(child: Text("click to update", style: textStyleSubText10px400w)),
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

    GetAllComplainsResponse response = await apiController.post<GetAllComplainsResponse>(EndPoints.ADD_EMPLOYEE_IN_PROJECT, body: formData);
    await Future.delayed(Duration(milliseconds: 200));
    Dialogs.hideLoader(context);
    await Future.delayed(Duration(milliseconds: 200));
    if (response.status!.isApiSuccessful) {
      // FlutterToastX.showSuccessToastBottom(context, "Add employee using add button");
      listOfAllComplaints.addAll(response.data!);
      listOfAllComplaints.clear();
      if (response.data?.isNotEmpty ?? false) listOfAllComplaints.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }

  Future<void> getAllComplainsWithoutLoader() async {
    await Future.delayed(Duration(milliseconds: 200));

    var formData = FormData.fromMap({
      'Register': "Register",
      "All": "All",
    });

    GetAllComplainsResponse response =
        await apiController.post<GetAllComplainsResponse>(EndPoints.ADD_EMPLOYEE_IN_PROJECT, body: formData);
    if (response.status!.isApiSuccessful) {
      // FlutterToastX.showSuccessToastBottom(context, "Add employee using add button");
      listOfAllComplaints.addAll(response.data!);
      listOfAllComplaints.clear();
      if (response.data?.isNotEmpty ?? false) listOfAllComplaints.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
