/// Status : "200"
/// Message : "Attandance Updated Successfuly. Weldone !!"

class MarkAttendanceTypeOneResponse {
  MarkAttendanceTypeOneResponse({
    String? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  MarkAttendanceTypeOneResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
  }

  String? _status;
  String? _message;

  MarkAttendanceTypeOneResponse copyWith({
    String? status,
    String? message,
  }) =>
      MarkAttendanceTypeOneResponse(
        status: status ?? _status,
        message: message ?? _message,
      );

  String? get status => _status;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    return map;
  }
}
