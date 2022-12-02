import 'package:hrms/env/environment_variable.dart';

class EndPoints {
  EndPoints._();

  static final String BASE_URL = "https://vipugroup.com/final/";
  static final String ACCESS_TOKEN = EnvironmentVariables.getAccessTokenURL;

  static final String LOGIN = BASE_URL + "Login.php";
 }
