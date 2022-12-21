import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hrms/res/keys.dart';
import 'package:hrms/ui/complains/all_complain_screen.dart';
import 'package:hrms/ui/home/model/get_all_projects_response.dart';
import 'package:hrms/ui/manageAccount/manage_account_options_screen.dart';
import 'package:hrms/util/shared_manager.dart';

import '../../export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [Assets.imagesIcBannerPlaceholder, Assets.imagesBannerTwo, Assets.imagesBannerThree];
  List<Data?> listOfProjects = [];
  String selectedProject = "";
  String selectedProjectId = "";

  @override
  void initState() {
    super.initState();
    getAllProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //header
            Container(
              height: 55.0,
              color: AppColors.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Logout", style: textStyleRegular16px600w).onClick(() {
                      SharedManager.setBooleanPreference(SharedPrefsKeys.kLoggedIn, false);
                      SharedManager.setStringPreference(SharedPrefsKeys.kUserId, "");
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Screens.LOGIN_SCREEN);
                    }),
                    // Text("HRM", style: textStyleRegular16px600w),
                    Image.asset(Assets.imagesVipuGroupHalfLogo, width: 28.0),
                    Image.asset(Assets.imagesIcScanner, height: 28.0)
                        .onClick(() => Navigator.pushNamed(context, Screens.QR_SCANNER_SCREEN)),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  verticalSpace(20.0),

                  Container(
                    height: 175.0,
                    child: Swiper(
                      scale: 0.9,
                      viewportFraction: 0.8,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 150.0,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: AppColors.baseLightColor,
                            image: DecorationImage(image: AssetImage(images[index]), fit: BoxFit.fill),
                          ),
                        );
                      },
                      itemCount: 3,
                    ),
                  ),

                  verticalSpace(20.0),
                  line(),

                  //other
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(20.0),
                        Text("Add Employee & Create Project", style: textStyle14px500w),
                        verticalSpace(20.0),
                        Row(
                          children: [
                            Flexible(
                              child: categoryCard("Register\nEmployee", Assets.imagesIcRegisterEmployee, "Add")
                                  .onClick(() => Navigator.pushNamed(context, Screens.AADHAAR_CARD_VERIFICATION_SCREEN)),
                            ),
                            horizontalSpace(20.0),
                            Flexible(
                                child: categoryCard("Register\nDepartment", Assets.imagesIcRegisterClient, "Add")
                                    .onClick(() async {
                                        await Navigator.pushNamed(context, Screens.CLIENT_BASIC_DETAIL);
                                        getAllProjectsWithoutLoader();
                                    })),
                          ],
                        ),
                      ],
                    ),
                  ),

                  verticalSpace(20.0),
                  line(),
                  verticalSpace(20.0),

                  Container(
                    height: 400.0,
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesIcHomeLine))),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        projectFilter().onClick(() {
                          showAlertDialog();
                        }),
                        verticalSpace(20.0),
                        Row(
                          children: [
                            Flexible(
                              child: categoryCard("Manage\nEmployee", Assets.imagesIcManageEmployee, "Edit").onClick(() =>
                                  Navigator.pushNamed(context, Screens.MANAGE_EMPLOYEE_OPTIONS, arguments: selectedProjectId)),
                            ),
                            horizontalSpace(20.0),
                            Flexible(child: Container()),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(child: Container()),
                            horizontalSpace(20.0),
                            // Flexible(child: categoryCard("Payment&\nInvoices", Assets.imagesIcPaymentInvoice, "View")),
                            Flexible(
                              child: categoryCard("Manage\nAccount", Assets.imagesIcManageExpenses, "View")
                                  .onClick(() => Navigator.push(context, MaterialPageRoute(builder: (context) => ManageAccountOptionsScreen(selectedProjectId)))),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Flexible(
                            //   child: categoryCard("Manage\nAccount", Assets.imagesIcManageExpenses, "View")
                            //       .onClick(() => Navigator.push(context, MaterialPageRoute(builder: (context) => ManageAccountOptionsScreen(selectedProjectId)))),
                            // ),
                            Flexible(
                                child: categoryCard("Complains/\nSuggestion", Assets.imagesIcViewReports, "View").onClick(() =>
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => AllComplainsScreen(selectedProjectId))))),
                            horizontalSpace(20.0),
                            Flexible(child: Container()),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(child: Container()),
                            horizontalSpace(20.0),
                            Flexible(child: categoryCard("Payout&\nAdv. Payment", Assets.imagesIcPayouts, "Update")),
                          ],
                        ),
                        Row(
                          children: [
                            // Flexible(
                            //     child: categoryCard("Complains/\nSuggestion", Assets.imagesIcViewReports, "View").onClick(() =>
                            //         Navigator.push(context,
                            //             MaterialPageRoute(builder: (context) => ComplainsOptionsScreen(selectedProjectId))))),
                            Flexible(child: categoryCard("Payment&\nInvoices", Assets.imagesIcPaymentInvoice, "View")),
                            horizontalSpace(20.0),
                            Flexible(child: Container()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container projectFilter() {
    return Container(
      height: 30.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.buttonStartGradient, AppColors.buttonEndGradient],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.background,
            spreadRadius: 2.0,
            blurRadius: 8.0,
            offset: Offset(2, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(selectedProject, style: textStyleWhite14px500w),
          Icon(Icons.filter_list_sharp, size: 20.0, color: AppColors.white),
        ],
      ),
    );
  }

  Container categoryCard(String text, String image, String type) {
    return Container(
      height: 68.0,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [BoxShadow(color: AppColors.boxShadow, blurRadius: 10.0, offset: Offset(0.0, 5.0), spreadRadius: 1.0)],
      ),
      child: Row(
        children: [
          Container(
              color: AppColors.homeCard,
              height: 68.0,
              width: 40,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(image)),
          horizontalSpace(10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: textStyle12px500w),
                verticalSpace(5.0),
                Row(
                  children: [
                    Spacer(),
                    Text(type, style: textStylePrimary12px500w),
                    horizontalSpace(5.0),
                    Icon(Icons.arrow_forward_sharp, color: AppColors.colorPrimary, size: 16.0),
                    horizontalSpace(8.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog() {
    SimpleDialog dialog = SimpleDialog(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
          child: Text("Select Project", style: textStyle14px600w),
        ),
        verticalSpace(10.0),
        ...listOfProjects.map((e) {
          return Container(
            color: AppColors.inputFieldBackgroundColor,
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child: Text(e?.clientName ?? "Not Found", style: textStyleSubText14px500w)),
                    horizontalSpace(10.0),
                    Icon(Icons.check_circle_outline, color: AppColors.textColorSubText)
                  ],
                ),
              ],
            ),
          ).onClick(() {
            Navigator.pop(context, e?.clientName);
          });
        }).toList(),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    ).then((value) {
      setState(() {
        selectedProject = value ?? selectedProject;
      });
    });
    ;
  }

  Future<void> getAllProjects() async {
    await Future.delayed(Duration(milliseconds: 200));
    Dialogs.showLoader(context, "Getting projects ...");
    GetAllProjectsResponse response = await apiController.get<GetAllProjectsResponse>(EndPoints.GET_ALL_PROJECTS);
    await Dialogs.hideLoader(context);
    if (response.status?.isApiSuccessful ?? false) {
      listOfProjects.clear();
      listOfProjects.addAll(response.data!);
      if (listOfProjects.isNotEmpty) selectedProject = listOfProjects?.first?.clientName ?? "";
      if (listOfProjects.isNotEmpty) selectedProjectId = listOfProjects?.first?.projectId ?? "";
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
    setState(() {});
  }

  Future<void> getAllProjectsWithoutLoader() async {
    await Future.delayed(Duration(milliseconds: 200));
    // Dialogs.showLoader(context, "Getting projects ...");
    GetAllProjectsResponse response = await apiController.get<GetAllProjectsResponse>(EndPoints.GET_ALL_PROJECTS);
    // await Dialogs.hideLoader(context);
    if (response.status?.isApiSuccessful ?? false) {
      listOfProjects.clear();
      listOfProjects.addAll(response.data!);
      if (listOfProjects.isNotEmpty) selectedProject = listOfProjects?.first?.clientName ?? "";
      if (listOfProjects.isNotEmpty) selectedProjectId = listOfProjects?.first?.projectId ?? "";
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
    setState(() {});
  }

}
