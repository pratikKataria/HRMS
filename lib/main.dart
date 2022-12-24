import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/keys.dart';
import 'package:hrms/route/route_transition.dart';
import 'package:hrms/ui/addClient/address_detail_client.dart';
import 'package:hrms/ui/addClient/bank_detail_client.dart';
import 'package:hrms/ui/addClient/basic_detail_client.dart';
import 'package:hrms/ui/addClient/skill_detail_client.dart';
import 'package:hrms/ui/addEmployee/address_detail_employee.dart';
import 'package:hrms/ui/addEmployee/bank_detail_employee.dart';
import 'package:hrms/ui/addEmployee/skill_detail_employee.dart';
import 'package:hrms/ui/attendance/typeOne/mark_attendence_type_one.dart';
import 'package:hrms/ui/attendance/typeOne/mark_attendence_type_one_version_2.dart';
import 'package:hrms/ui/attendance/typeTwo/mark_attendence_type_two.dart';
import 'package:hrms/ui/attendance/typeTwo/mark_attendence_type_two_version_2.dart';
import 'package:hrms/ui/home/home_screen.dart';
import 'package:hrms/ui/login/login_screen.dart';
import 'package:hrms/ui/manageEmployee/user_attendance_detail_screen.dart';
import 'package:hrms/ui/workorder/get_all_workorder.dart';
import 'package:hrms/util/shared_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool login = await SharedManager.getBooleanPreference(SharedPrefsKeys.kLoggedIn);
  runApp(MyApp(login??false));
}

class MyApp extends StatelessWidget {
  final bool login;

  const MyApp(this.login, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HRM',
      theme: ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: AppColors.white),
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        return RouteTransition(routeName: settings.name ?? "/", arguments: settings.arguments);
      },
      home: login ? HomeScreen(): LoginScreen(),
      // home: BasicDetailClient(),
    );
  }
}