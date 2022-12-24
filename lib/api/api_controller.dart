import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hrms/logging/simple_log.dart';
import 'package:hrms/ui/addClient/model/get_all_user_response.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_response.dart';
import 'package:hrms/ui/addEmployee/model/company_list_response.dart';
import 'package:hrms/ui/addEmployee/model/skill_list_response.dart';
import 'package:hrms/ui/attendance/typeOne/model/GetEmployeeByIdResponse.dart';
import 'package:hrms/ui/attendance/typeOne/model/job_title_response.dart';
import 'package:hrms/ui/attendance/typeOne/model/mark_attendance_type_one_response.dart';
import 'package:hrms/ui/attendance/typeTwo/mark_attendance_type_two_response.dart';
import 'package:hrms/ui/complains/model/get_all_complains_response.dart';
import 'package:hrms/ui/complains/model/submit_complain_response.dart';
import 'package:hrms/ui/home/model/get_all_projects_response.dart';
import 'package:hrms/ui/login/login_response.dart';
import 'package:hrms/ui/manageAccount/model/get_all_account_response.dart';
import 'package:hrms/ui/manageAccount/model/get_all_transactions.dart';
import 'package:hrms/ui/manageAccount/model/get_all_types.dart';
import 'package:hrms/ui/manageAccount/model/get_balance_response.dart';
import 'package:hrms/ui/manageEmployee/model/add_employee_in_project_response.dart';
import 'package:hrms/ui/manageEmployee/model/user_attendance_detail_response.dart';
import 'package:hrms/ui/manageEmployee/model/view_attendance_response.dart';
import 'package:hrms/ui/scanned/employee_response.dart';
import 'package:hrms/ui/workorder/model/get_all_work_order.dart';

import 'dio_http.dart';

class ApiController {
  static ApiController _instance = ApiController.internal();

  ApiController.internal();

  factory ApiController() {
    return _instance;
  }

  static ApiController getInstance() {
    if (_instance == null) _instance = ApiController.internal();
    return _instance;
  }

  Future<T> post<T>(String url, {Map<String, dynamic>? headers, body, encoding, payload}) async {
    // Map<String, dynamic> headersMap = {"Authorization": await AuthUser.getInstance().token()};
    // if (headers != null) headersMap.addAll(headers);

    if (body is FormData) {
      body.fields.forEach((element) {
        print("${element.value}  :  ${element.key}");
      });
    }

    SimpleLogger.debug(ApiController, "Type: Request\n Api Call: $url\n Inputs: $body\n Payload: ${payload.toString()}\n");

    Response response = await dio.post(
      url,
      data: body,
      queryParameters: payload,
      options: Options(
        contentType: ContentType.json.toString(),
        receiveTimeout: 300000,
        sendTimeout: 300000,
        method: "POST",
        // headers: headersMap,
      ),
    );

    SimpleLogger.debug(ApiController,
        "Type: Response\n Api Call: $url\n Inputs: $body\n Payload: ${payload.toString()}\n Header: km\n Response:${response.toString()}\n");

    return JsonConverter.fromJson<T>(response.data);
  }

  Future<T> get<T>(String url, {Map? headers, body, encoding, payload}) async {
    // Map<String, String> headerMap = headers ?? {};
    // headerMap["NoEncryption"] = 'true';
    SimpleLogger.debug(ApiController, "Type: Request\n Api Call: $url\n Inputs: $body\n Payload: ${payload.toString()}\n");

    Response response = await dio.get(url,
        queryParameters: payload,
        options: Options(
          contentType: ContentType.json.toString(),
          receiveTimeout: 300000,
          sendTimeout: 300000,
          method: "GET",
          // headers: headerMap,
        ));

    SimpleLogger.debug(ApiController,
        "Type: Response\n Api Call: $url\n Inputs: $body\n Payload: ${payload.toString()}\n Header: \n Response:${response.toString()}\n");

    return JsonConverter.fromJson<T>(response.data);
  }
}

class JsonConverter {
  static T fromJson<T>(dynamic value) {
    if (T == LoginResponse) return LoginResponse.fromJson(value) as T;
    if (T == EmployeeResponse) return EmployeeResponse.fromJson(value) as T;
    if (T == MarkAttendanceTypeOneResponse) return MarkAttendanceTypeOneResponse.fromJson(value) as T;
    if (T == MarkAttendanceTypeTwoResponse) return MarkAttendanceTypeTwoResponse.fromJson(value) as T;
    if (T == AddEmployeeResponse) return AddEmployeeResponse.fromJson(value) as T;
    if (T == GetAllUserResponse) return GetAllUserResponse.fromJson(value) as T;
    if (T == GetEmployeeByIdResponse) return GetEmployeeByIdResponse.fromJson(value) as T;
    if (T == GetAllProjectsResponse) return GetAllProjectsResponse.fromJson(value) as T;
    if (T == ViewAttendanceResponse) return ViewAttendanceResponse.fromJson(value) as T;
    if (T == GetAllWorkOrderResponse) return GetAllWorkOrderResponse.fromJson(value) as T;
    if (T == GetAllAccountResponse) return GetAllAccountResponse.fromJson(value) as T;
    if (T == GetAllTypes) return GetAllTypes.fromJson(value) as T;
    if (T == GetBalanceResponse) return GetBalanceResponse.fromJson(value) as T;
    if (T == SubmitComplainResponse) return SubmitComplainResponse.fromJson(value) as T;
    if (T == GetAllComplainsResponse) return GetAllComplainsResponse.fromJson(value) as T;
    if (T == AddEmployeeInProjectResponse) return AddEmployeeInProjectResponse.fromJson(value) as T;
    if (T == GetAllTransactions) return GetAllTransactions.fromJson(value) as T;
    if (T == UserAttendanceDetailResponse) return UserAttendanceDetailResponse.fromJson(value) as T;
    if (T == CompanyListResponse) return CompanyListResponse.fromJson(value) as T;
    if (T == SkillListResponse) return SkillListResponse.fromJson(value) as T;
    if (T == JobTitleResponse) return JobTitleResponse.fromJson(value) as T;
    return throw Exception("Unknown class");
  }
}
