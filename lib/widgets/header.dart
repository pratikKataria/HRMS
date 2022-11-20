import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/util/extension.dart';

class Header extends StatelessWidget {
  String headerText;

  Header({Key? key, this.headerText = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_back, color: AppColors.textColorSubText, size: 20.0),
                    Text("Back", style: textStyle12px500w),
                  ],
                ).onClick(() => Navigator.pop(context)),
                Text(headerText, style: textStyle12px500w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
