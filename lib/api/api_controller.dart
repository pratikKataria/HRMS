import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hrms/logging/simple_log.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_request.dart';
import 'package:hrms/ui/addEmployee/model/add_employee_response.dart';
import 'package:hrms/ui/attendance/typeOne/mark_attendance_type_one_response.dart';
import 'package:hrms/ui/attendance/typeTwo/mark_attendance_type_two_response.dart';
import 'package:hrms/ui/login/login_response.dart';
import 'package:hrms/ui/scanned/employee_response.dart';

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
        "Type: Response\n Api Call: $url\n Inputs: $body\n Payload: ${payload.toString()}\n Header: km\n Response:${response.toString()}\n");

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
    return throw Exception("Unknown class");
  }
}
