import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hrms/logging/simple_log.dart';
import 'package:hrms/ui/login/login_response.dart';

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
}

class JsonConverter {
  static T fromJson<T>(dynamic value) {
    if (T == LoginResponse) {
      return LoginResponse.fromJson(value) as T;
    }
    return throw Exception("Unknown class");
  }
}
