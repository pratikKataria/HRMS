import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/strings.dart';
import 'package:hrms/widgets/flutter_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Utility {
  static double screenWidth(BuildContext context) {
    // print('${MediaQuery.of(context).size.width/1.55}');
    return MediaQuery.of(context).size.width;
  }

  static bool isWeb(BuildContext context) {
    return kIsWeb;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static var paddingSize15Box = const SizedBox(
    height: 15,
  );
  static var paddingSize10Box = const SizedBox(
    height: 10,
  );

  static var paddingSize30Box = const SizedBox(
    height: 30,
  );

  static void portrait() => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  static void statusBarAndNavigationBarColor() => SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.white, // status bar color
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.background, // status bar icon color
      ));

  static void statusBarAndNavigationBarColorDark() => SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.textColorBlack, // status bar color
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.textColorBlack, // status bar icon color
      ));

  static void urlLauncher(BuildContext context, String? link) {
    if (link == null) {
      FlutterToastX.showErrorToastBottom(context, "No link found !!");
      return;
    }

    if (link.isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "No link found !!");
      return;
    }

    final Uri _url = Uri.parse(link);
    launchUrl(_url, mode: LaunchMode.externalApplication);
  }

  static convertMemoryImage(String? source) {
    if (source == null || source.isEmpty) return base64Decode(Strings.kDefImage);
    try {
      return base64Decode(source);
    } catch (e) {
      return base64Decode(Strings.kDefImage);
    }
  }

  static Future<String> pickImg(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpeg', "jpg"],
      );
      File file = File(result?.files.single.path ?? "");
      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      return base64Image;
    } catch (e) {
      FlutterToastX.showErrorToastBottom(context, e.toString());
      return "";
    }
  }
}
