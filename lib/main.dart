import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/route/route_transition.dart';
import 'package:hrms/ui/attendance/typeOne/mark_attendence_type_one.dart';
import 'package:hrms/ui/attendance/typeTwo/mark_attendence_type_two.dart';
import 'package:hrms/ui/login/login_screen.dart';
import 'package:hrms/ui/scanned/user_scanned_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HRM',
      theme: ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: AppColors.white),
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        return RouteTransition(routeName: settings.name??"/", arguments: settings.arguments);
      },
      home: LoginScreen(),
    );
  }
}