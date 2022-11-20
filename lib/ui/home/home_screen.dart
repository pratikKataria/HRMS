import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hrms/generated/assets.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/util/extension.dart';
import 'package:hrms/widgets/widget_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [Assets.imagesIcBannerPlaceholder, Assets.imagesImgLogin];

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
                    Container(),
                    Text("HRM", style: textStyleRegular16px600w),
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
                    height: 160.0,
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
                      itemCount: 2,
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
                                    .onClick(() => Navigator.pushNamed(context, Screens.CLIENT_BASIC_DETAIL))),
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
                              Text("Bombay Hospital", style: textStyleWhite14px500w),
                              Icon(Icons.filter_list_sharp, size: 20.0, color: AppColors.white),
                            ],
                          ),
                        ),
                        verticalSpace(20.0),
                        Row(
                          children: [
                            Flexible(child: categoryCard("Manage\nEmployee", Assets.imagesIcManageEmployee, "Edit")),
                            horizontalSpace(20.0),
                            Flexible(child: Container()),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(child: Container()),
                            horizontalSpace(20.0),
                            Flexible(child: categoryCard("Payment&\nInvoices", Assets.imagesIcPaymentInvoice, "View")),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(child: categoryCard("Manage\nExpenses", Assets.imagesIcManageExpenses, "View")),
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
                            Flexible(child: categoryCard("Register\nEmployee", Assets.imagesIcViewReports, "View")),
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
          )
        ],
      ),
    );
  }
}
