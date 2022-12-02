import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hrms/route/screens.dart';
import 'package:hrms/ui/addClient/address_detail_client.dart';
import 'package:hrms/ui/addClient/bank_detail_client.dart';
import 'package:hrms/ui/addClient/basic_detail_client.dart';
import 'package:hrms/ui/addClient/skill_detail_client.dart';
import 'package:hrms/ui/addEmployee/aadhaar_verification_screen.dart';
import 'package:hrms/ui/addEmployee/address_detail_employee.dart';
import 'package:hrms/ui/addEmployee/bank_detail_employee.dart';
import 'package:hrms/ui/addEmployee/basic_detail_employee.dart';
import 'package:hrms/ui/addEmployee/skill_detail_employee.dart';
import 'package:hrms/ui/attendance/typeOne/mark_attendence_type_one.dart';
import 'package:hrms/ui/attendance/typeTwo/mark_attendence_type_two.dart';
import 'package:hrms/ui/home/home_screen.dart';
import 'package:hrms/ui/login/login_screen.dart';
import 'package:hrms/ui/scanned/user_scanned_screen.dart';
import 'package:hrms/ui/scanner/qr_scanner_screen.dart';

/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.
class RouteTransition extends PageRouteBuilder {
  final String routeName;
  final dynamic arguments;

  RouteTransition({required this.routeName, this.arguments})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {

            switch (routeName) {
              case "/": return LoginScreen();
              case Screens.LOGIN_SCREEN: return LoginScreen();
              case Screens.HOME_SCREEN: return HomeScreen();
              case Screens.QR_SCANNER_SCREEN: return QrScannerScreen();
              case Screens.QR_SCANNED_SCREEN: return UserScannedScreen(arguments as String);
              case Screens.EMPLOYEE_BASIC_DETAIL: return BasicDetailEmployee();
              case Screens.EMPLOYEE_ADDRESS_DETAIL: return AddressDetailEmployee();
              case Screens.EMPLOYEE_SKILL_DETAIL: return SkillDetailEmployee();
              case Screens.EMPLOYEE_BANK_DETAIL: return BankDetailEmployee();
              case Screens.CLIENT_BASIC_DETAIL: return BasicDetailClient();
              case Screens.CLIENT_ADDRESS_DETAIL: return AddressDetailClient();
              case Screens.CLIENT_SKILL_DETAIL: return SkillDetailClient();
              case Screens.CLIENT_BANK_DETAIL: return BankDetailClient();
              case Screens.ATTENDANCE_TYPE_ONE: return MarkAttendanceTypeOne();
              case Screens.ATTENDANCE_TYPE_TWO: return MarkAttendanceTypeTwo();
              case Screens.AADHAAR_CARD_VERIFICATION_SCREEN: return AadhaarVerificationScreen();
            }
            return LoginScreen();
          },
          transitionDuration: Duration(milliseconds: 700),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              fillColor: Theme.of(context).cardColor,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
        );
}
