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
                child: Text('$description', style: textStyle14px500w, overflow: TextOverflow.ellipsis),
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

  static Future<Object?>? hideLoader(BuildContext context) async {
    // Navigator.pop(context);
    await Future.delayed(Duration(milliseconds: 200));
    if (_dialog != null)
      return await _dialog?.hide().then((value) async {
        if (_dialog?.isShowing() ?? false) {
          return await _dialog?.hide();
        }
      });
    await Future.delayed(Duration(milliseconds: 200));
    return Future(() => true);
  }
// print("Hide Loader $value");
// print("Hide Loader ${_dialog?.isShowing()}");
}