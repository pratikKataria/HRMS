import 'package:flutter/material.dart';
import 'package:hrms/res/AppColors.dart';
import 'package:hrms/res/keys.dart';
import 'package:hrms/route/route_transition.dart';
import 'package:hrms/ui/addEmployee/skill_detail_employee.dart';
import 'package:hrms/ui/home/home_screen.dart';
import 'package:hrms/ui/login/login_screen.dart';
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
      home: login ? HomeScreen() : LoginScreen(),
    );
  }
}