import 'package:hrms/export.dart';
import 'package:hrms/ui/workorder/model/get_all_work_order.dart';
import 'package:hrms/util/utility.dart';

class GetAllWorkOrderScreen2 extends StatefulWidget {
  final String projectId;

  const GetAllWorkOrderScreen2(this.projectId, {Key? key}) : super(key: key);

  @override
  State<GetAllWorkOrderScreen2> createState() => _GetAllWorkOrderScreen2State();
}

class _GetAllWorkOrderScreen2State extends State<GetAllWorkOrderScreen2> {
  String fromDateString = "";

  List<Data> listOfData = [];

  @override
  void initState() {
    DateTime now = DateTime.now();

    fromDateString =  "${now.year }-${now.month}-${now.day}";
    getAllWorkOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Header(headerText: "Manage Employee"),
            line(width: Utility.screenWidth(context)),
            fromDate().onClick(() async {
              fromDateString = await _selectDate();
              if (fromDateString.isEmpty) {
                FlutterToastX.showErrorToast(context, "Please select till date");
                return;
              }

              getAllWorkOrder();

              setState(() {});
            }),
            verticalSpace(6.0),
            Expanded(
              child: ListView(
                children: [
                  ...listOfData.map((e) => cardViewAddEmployee(e)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column fromDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
              Text("Till Date", style: textStyleWhite14px500w),
              horizontalSpace(20.0),
              Icon(Icons.filter_list_sharp, size: 20.0, color: AppColors.white),
            ],
          ),
        ),
        verticalSpace(4.0),
        Text(fromDateString ?? "", style: textStyle14px500w)
      ],
    );
  }

  Container cardViewAddEmployee(Data e) {
    return Container(
      color: AppColors.inputFieldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Block No. : ${e.blocno}", style: textStyle14px500w),
                Text("Users : ${e.userIdCount}", style: textStyle14px500w),
                Text("Created At: ${e.createdAt} ", style: textStyle14px500w),
              ],
            ),
          ),
          Icon(Icons.download, color: AppColors.textColorSubText).onClick(() {

            Utility.urlLauncher(context, "https://vipugroup.com/final/Download_workorder_pdf.php?genrate=&blockno=${e.blocno}&robotno=${e.roboNo}&inverterno=${e.inverterNo}&date=$fromDateString");
            setState(() {});
          }),
        ],
      ),
    );
  }

  Future<String> _selectDate() async {
    //2022-12-01 09:24:00
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );

    return "${picked?.year ?? "YY"}-${picked?.month ?? "MM"}-${picked?.day ?? "DD"}";
  }

  Future<void> getAllWorkOrder() async {
    await Future.delayed(Duration(milliseconds: 800));

    Dialogs.showLoader(context, "Getting workorder ...");
    // Map<String, String> data = {
    //   "GET": "GET",
    //   "date_from": fromDateString,
    //   "date_till": toDateString,
    //   "project_id": widget.projectId,
    // };

    Map<String, String> data = {
      "GET": "GET",
      "date": fromDateString,
      "project_id": widget.projectId,
      "business_id": "12",
    };

    GetAllWorkOrderResponse response = await apiController.get<GetAllWorkOrderResponse>(EndPoints.GET_ALL_WORK_ORDER, payload: data);
    await Dialogs.hideLoader(context);
    if (response.status!.isApiSuccessful) {
      listOfData.clear();
      listOfData.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }
  }

  Future<void> getData() async {
    await Future.delayed(Duration(milliseconds: 800));

    Dialogs.showLoader(context, "Getting workorder ...");

    Map<String, String> body = {
      "GET": "GET",
      "project_id": widget.projectId,
      "business_id": "12",
    };

    String response = await apiController.get<String>(EndPoints.GET_ALL_WORK_ORDER, payload: body);
    await Dialogs.hideLoader(context);
    /*   if (response.status!.isApiSuccessful) {
      listOfData.clear();
      listOfData.addAll(response.data!);
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.message ?? ""}");
    }*/
  }
}
