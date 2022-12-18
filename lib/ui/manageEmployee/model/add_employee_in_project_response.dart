/// Status : "200"
/// Message : "User Added Successfuly. Weldone !!"
/// Data : ["",null]

class AddEmployeeInProjectResponse {
  AddEmployeeInProjectResponse({
      String? status, 
      String? message, 
      List<String>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  AddEmployeeInProjectResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _data = json['Data'] != null ? json['Data'].cast<String>() : [];
  }
  String? _status;
  String? _message;
  List<String>? _data;
AddEmployeeInProjectResponse copyWith({  String? status,
  String? message,
  List<String>? data,
}) => AddEmployeeInProjectResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
  String? get message => _message;
  List<String>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    map['Data'] = _data;
    return map;
  }

}