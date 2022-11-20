import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/Fonts.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/util/utility.dart';
import 'package:hrms/widgets/header.dart';
import 'package:hrms/widgets/widget_util.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  String scannedValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(headerText: "Qr Scanner"),
            verticalSpace(40.0),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: Utility.screenWidth(context) * 0.85,
                height: Utility.screenHeight(context) / 2,
                child: MobileScanner(
                    allowDuplicates: false,
                    onDetect: (barcode, args) {
                      if (barcode.rawValue == null) {
                        debugPrint('Failed to scan Barcode');
                      } else {
                        final String code = barcode.rawValue!;
                        Navigator.pushReplacementNamed(context, Screens.QR_SCANNED_SCREEN);
                        debugPrint('Barcode found! $code');
                      }
                    }),
              ),
            ),
            verticalSpace(20.0),
            Text("Scan employee Id here", style: textStyleSubText14px500w),
          ],
        ),
      ),
    );
  }
}
