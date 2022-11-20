import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/widgets/widget_util.dart';

class HrmInputField extends StatelessWidget {
  final String headingText;
  final String text;
  final bool password;
  final bool mandate;
  final Color color;
  final Widget? leftWidget;
  final EdgeInsets? padding;

  const HrmInputField(
      {this.color = AppColors.inputFieldBackgroundColor,
      this.leftWidget,
      this.headingText = "",
      this.text = "",
      this.mandate = false,
      this.password = false,
      this.padding,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(headingText, style: textStyle14px600w),
        verticalSpace(5.0),
        Container(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            children: [
              Expanded(child: inputTextFormField(placeHolderText: text)),
              leftWidget ?? Container(),
              if (mandate)
                Container(width: 6.0, height: 6.0, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.red))
            ],
          ),
        ),
      ],
    );
  }

  TextFormField inputTextFormField({TextEditingController? controller, String? placeHolderText, bool inputTypeNumber = false}) {
    return TextFormField(
      obscureText: password,
      textAlign: TextAlign.left,
      controller: controller,
      maxLines: 1,
      inputFormatters: [inputTypeNumber ? LengthLimitingTextInputFormatter(4) : LengthLimitingTextInputFormatter(256)],
      textCapitalization: TextCapitalization.none,
      keyboardType: inputTypeNumber ? TextInputType.number : TextInputType.emailAddress,
      style: textStyleSubText14px500w,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: placeHolderText,
        hintStyle: textStyleSubText14px500w,
        isDense: true,
        suffixStyle: TextStyle(color: AppColors.textColor),
      ),
    );
  }
}
