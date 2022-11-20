import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/util/utility.dart';

class HrmGradientButton extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const HrmGradientButton({this.padding, this.margin, this.text = "", Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 45.0,
        padding: padding,
        margin: margin,
        width: Utility.screenWidth(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.buttonEndGradient, AppColors.buttonStartGradient],
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              color: AppColors.background,
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 5),
            ),
          ],
        ),
        child: Center(child: Text(text, style: textStyleWhite14px600w)),
      ),
    );
  }
}
