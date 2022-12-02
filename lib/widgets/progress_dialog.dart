import 'package:flutter/material.dart';
import 'package:hrms/widgets/animated_close_button.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../export.dart';


class Dialogs {

  static ProgressDialog? _dialog;


  static void showLoader(BuildContext context, String description) {
    // print(context.toString() + 'nameeeeeeeeeeee');
    _dialog = ProgressDialog(context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        customBody: Container(
          height: 65.0,
          child: Row(
            children: [
              horizontalSpace(20.0),
              Container(width: 24.0, height: 24.0, child: CircularProgressIndicator()),
              horizontalSpace(20.0),
              Expanded(
                child: Text('$description', style: textStylePrimary14px500w, overflow: TextOverflow.ellipsis),
              ),
              AnimatedCloseButton(),
            ],
          ),
        ));
    _dialog?.show();

    // Future.delayed(Duration(seconds: 7), () {
    //   if (_dialog.isShowing()) {
    //     _dialog.hide();
    //   }
    // });
  }

  static void hideLoader(BuildContext context) {
    // Navigator.pop(context);
    if (_dialog != null)
      _dialog?.hide().then((value) {
        print("Hide Loader $value");
        print("Hide Loader ${_dialog?.isShowing()}");
        if (_dialog?.isShowing() ?? false) {
          _dialog?.hide();
        }
      });
  }

}