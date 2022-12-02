class AddClientResponse {
  AddClientResponse({
    String? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  AddClientResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
  }

  String? _status;
  String? _message;

  AddClientResponse copyWith({
    String? status,
    String? message,
  }) =>
      AddClientResponse(
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
