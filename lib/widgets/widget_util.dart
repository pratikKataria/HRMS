import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';

import '../res/Fonts.dart';

Widget verticalSpace(double height) => SizedBox(
      height: height,
    );

Widget horizontalSpace(double height) => SizedBox(
      width: height,
    );

Widget line({double width = 0.0, Color color = AppColors.lineColor}) => Container(
      width: width,
      height: 1,
      color: color,
    );

Widget placeholder(double width, double height) => Container(width: width, height: height, child: Placeholder());

Center CenterText({String text = "No Data", TextStyle textStyle = textStyleSubText14px500w}) =>
    Center(child: Text(text, style: textStyle));
