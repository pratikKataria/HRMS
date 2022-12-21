import 'package:hrms/export.dart';
import 'package:hrms/ui/addClient/basic_detail_client.dart';
import 'package:hrms/ui/addClient/model/get_all_user_response.dart';
import 'package:hrms/util/utility.dart';

class SkillDetailClient extends StatefulWidget {
  const SkillDetailClient({Key? key}) : super(key: key);

  @override
  State<SkillDetailClient> createState() => _SkillDetailClientState();
}

class _SkillDetailClientState extends State<SkillDetailClient> {
  Set<Data> allEmployeesList = Set();
  Set<Data> selectedEmployees = Set();
  TextEditingController searchTextController = TextEditingController();

  bool addNew = false;
  String? dob;

  @override
  void initState() {
    super.initState();
    getAllUsers();
    searchTextController.addListener(() => setState(() {}));
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Client Skill Detail"),
            line(width: Utility.screenWidth(context)),

            //progress detail
            // verticalSpace(20.0),
            // Image(image: AssetImage(Assets.imagesIcDetailProcessThree), height: 40.0),
            verticalSpace(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(alignment: Alignment.centerLeft, child: Text("Add Employee in project", style: textStyle14px600w)),
            ),

            HrmInputField(
              text: "Type name to search",
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              leftWidget: Icon(Icons.search),
              textController: searchTextController,
            ),
            verticalSpace(6.0),

            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(border: Border.all(color: AppColors.lineColor, width: 2.0)),
                child: ListView(
                  children: allEmployeesList
                      .difference(selectedEmployees)
                      .where((element) =>
                          (element.firstName ?? "")
                              .toString()
                              .toLowerCase()
                              .contains(searchTextController.text.toString().toLowerCase()) ||
                          (element.lastName ?? "")
                              .toString()
                              .toLowerCase()
                              .contains(searchTextController.text.toString().toLowerCase()))
                      .map((e) => cardViewAddEmployee(e))
                      .toList(),
                ),
              ),
            ),

            verticalSpace(6.0),

            Expanded(
              child: ListView(
                children: selectedEmployees.map((e) => cardViewRemoveEmployee(e)).toList(),
              ),
            ),

            verticalSpace(10.0),
            Row(
              children: [
                Expanded(
                  child: HrmGradientButton(margin: EdgeInsets.symmetric(horizontal: 10.0), text: "Skip").onClick(() {
                    // if (selectedEmployees.isEmpty) {
                    //   FlutterToastX.showErrorToastBottom(context, "Please select at least one employee");
                    //   return;
                    // }
                    //
                    // String selectedEmployeeStringCommaSeparated = selectedEmployees.map((e) => e.id).toList().join(",");
                    addClientRequest.employees = ""; /*selectedEmployeeStringCommaSeparated*/;
                    Navigator.pushNamed(context, Screens.CLIENT_BANK_DETAIL);
                  }),
                ),
                Expanded(
                  child: HrmGradientButton(margin: EdgeInsets.symmetric(horizontal: 10.0), text: "Next").onClick(() {
                    if (selectedEmployees.isEmpty) {
                      FlutterToastX.showErrorToastBottom(context, "Please select at least one employee");
                      return;
                    }

                    String selectedEmployeeStringCommaSeparated = selectedEmployees.map((e) => e.id).toList().join(",");
                    addClientRequest.employees = selectedEmployeeStringCommaSeparated;
                    Navigator.pushNamed(context, Screens.CLIENT_BANK_DETAIL);
                  }),
                ),
              ],
            ),
            verticalSpace(10.0),
          ],
        ),
      ),
    );
  }

  Container cardViewAddEmployee(Data e) {
    return Container(
      color: AppColors.inputFieldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Name: ${e.firstName} ${e.lastName}", style: textStyle14px500w),
              Spacer(),
              Icon(Icons.add_box_outlined, color: AppColors.textColorSubText).onClick(() {
                selectedEmployees.add(e);
                setState(() {});
              }),
            ],
          ),
          verticalSpace(4.0),
          Text("Employee Id: ${e.id}", style: textStyle12px500w),
          verticalSpace(4.0),
          Text("${e.designation ?? "NA"}", style: textStyleGreen14px500w),
        ],
      ),
    );
  }

  Container cardViewRemoveEmployee(Data e) {
    return Container(
      color: AppColors.inputFieldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Name: ${e.firstName} ${e.lastName}", style: textStyle14px500w),
              Spacer(),
              Icon(Icons.remove_circle_outline, color: AppColors.textColorSubText).onClick(() {
                selectedEmployees.remove(e);
                setState(() {});
              }),
            ],
          ),
          verticalSpace(4.0),
          Text("Employee Id: ${e.id}", style: textStyle12px500w),
          verticalSpace(4.0),
          Text("${e.designation ?? "NA"}", style: textStyleGreen14px500w),
        ],
      ),
    );
  }

  Future<void> getAllUsers() async {
    await Future.delayed(Duration(milliseconds: 200));

    Dialogs.showLoader(context, "Getting all user list ...");
    var formData = FormData.fromMap({
      'Register': "Register",
    });

    GetAllUserResponse response = await apiController.post<GetAllUserResponse>(EndPoints.GET_ALL_USER, body: formData);
    await Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      FlutterToastX.showSuccessToastBottom(context, "Add employee using add button");

      allEmployeesList.clear();
      if (response.data?.isNotEmpty ?? false) allEmployeesList.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }
}
