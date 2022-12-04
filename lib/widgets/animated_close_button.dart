import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/util/extension.dart';

class AnimatedCloseButton extends StatefulWidget {
  const AnimatedCloseButton({Key? key}) : super(key: key);

  @override
  State<AnimatedCloseButton> createState() => _AnimatedCloseButtonState();
}

class _AnimatedCloseButtonState extends State<AnimatedCloseButton> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    timer();
  }

  Future<void> timer() async {
    await Future.delayed(Duration(seconds: 5));
    show = true;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: show
          ? Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(right: 10.0, left: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.colorPrimary,
              ),
              child: Icon(Icons.close, size: 24.0, color: AppColors.white),
            ).onClick(() => Navigator.pop(context))
          : Container(),
    );
  }
}
