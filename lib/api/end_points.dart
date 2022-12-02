import 'package:hrms/env/environment_variable.dart';

class EndPoints {
  EndPoints._();

  static final String BASE_URL = "https://vipugroup.com/final/";
  static final String ACCESS_TOKEN = EnvironmentVariables.getAccessTokenURL;

  static final String LOGIN = BASE_URL + "Login.php";
  static final String GET_USER_PROFILE = BASE_URL + "Get_user_profile.php";
  static final String ATTENDANCE_TYPE_ONE = BASE_URL + "Attandance_by_qr_type1.php";
  static final String ATTENDANCE_TYPE_TWO = BASE_URL + "Attandance_by_qr_type2.php";

}
