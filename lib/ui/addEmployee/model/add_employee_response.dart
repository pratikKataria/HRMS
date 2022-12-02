/// Status : "300"
/// Message : "User Not Created Successfuly !! Email Id May Be Registered."

class AddEmployeeResponse {
  AddEmployeeResponse({
      String? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  AddEmployeeResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
  }
  String? _status;
  String? _message;
AddEmployeeResponse copyWith({  String? status,
  String? message,
}) => AddEmployeeResponse(  status: status ?? _status,
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