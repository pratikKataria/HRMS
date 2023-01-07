import 'package:hrms/env/environment_variable.dart';

class EndPoints {
  EndPoints._();

  static final String BASE_URL = "https://vipugroup.com/final/";
  static final String ACCESS_TOKEN = EnvironmentVariables.getAccessTokenURL;

  static final String LOGIN = BASE_URL + "Login.php";
  static final String GET_USER_PROFILE = BASE_URL + "Get_user_profile.php";
  static final String ATTENDANCE_TYPE_ONE = BASE_URL + "Attandance_by_qr_type1.php";
  static final String ATTENDANCE_TYPE_TWO = BASE_URL + "Attandance_by_qr_type2.php";
  static final String REGISTER_EMPLOYEE = BASE_URL + "Register_User.php";
  static final String REGISTER_CLIENT = BASE_URL + "Register_Project.php";
  static final String GET_ALL_USER = BASE_URL + "Get_All_Users.php";
  static final String GET_ALL_USER_V2 = BASE_URL + "Get_All_Users2.php";
  static final String DELETE_USER = BASE_URL + "Manage_Employees.php";
  static final String COMPLAINS = BASE_URL + "Manage_Employees.php";
  static final String GET_ALL_PROJECTS = BASE_URL + "Get_All_Projects.php?GET=GET";
  static final String ATTENDANCE_REPORT = BASE_URL + "Attendance_Report.php";
  static final String GET_ALL_WORK_ORDER = BASE_URL + "Get_all_workorders.php";
  static final String GET_ALL_ACCOUNT = BASE_URL + "Accounts_management.php";
  static final String SUBMIT_COMPLAINTS = BASE_URL + "Submit_Compliance.php";
  static final String ADD_EMPLOYEE_IN_PROJECT = BASE_URL + "Add_Users_In_Project.php";
  static final String TRANSACTIONS = BASE_URL + "Get_transection_by_type.php";
  static final String AADHAAR_VERIFICATION = BASE_URL + "Send_Aadhar_otp.php";
  static final String AADHAAR_VERIFY_OTP = BASE_URL + "Submit_Aadhar_otp.php";
}
