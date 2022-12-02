import 'package:dio/dio.dart';
import 'package:hrms/api/api_error_model.dart';

abstract class ApiErrorParser {

}

abstract class ErrorCodes {
  static const INVALID_SESSION_ID = "Session expired or invalid";
}
