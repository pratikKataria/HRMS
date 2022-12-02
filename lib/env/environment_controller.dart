import 'package:hrms/env/environment_variable.dart';

abstract class EnvironmentController {
  static int get getCurrentEnv => EnvironmentVariables.DEV;
// static int get getCurrentEnv => EnvironmentValues.PROD;
}
