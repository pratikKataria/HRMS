/// Status : "200"
/// Message : "Getting User Presents Successfuly. Weldone !!"
/// Data : [{"PRESENT":"1","Halfday":"1","user_id":"44","business_id":"12","project_id":"21"}]

class ViewAttendanceResponse {
  ViewAttendanceResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ViewAttendanceResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    if (json['Data'] != null) {
      _data = [];
      json['Data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<Data>? _data;
ViewAttendanceResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => ViewAttendanceResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    if (_data != null) {
      map['Data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// PRESENT : "1"
/// Halfday : "1"
/// user_id : "44"
/// business_id : "12"
/// project_id : "21"

class Data {
  Data({
      String? present, 
      String? halfday, 
      String? userId, 
      String? businessId, 
      String? projectId,}){
    _present = present;
    _halfday = halfday;
    _userId = userId;
    _businessId = businessId;
    _projectId = projectId;
}

  Data.fromJson(dynamic json) {
    _present = json['PRESENT'];
    _halfday = json['Halfday'];
    _userId = json['user_id'];
    _businessId = json['business_id'];
    _projectId = json['project_id'];
  }
  String? _present;
  String? _halfday;
  String? _userId;
  String? _businessId;
  String? _projectId;
Data copyWith({  String? present,
  String? halfday,
  String? userId,
  String? businessId,
  String? projectId,
}) => Data(  present: present ?? _present,
  halfday: halfday ?? _halfday,
  userId: userId ?? _userId,
  businessId: businessId ?? _businessId,
  projectId: projectId ?? _projectId,
);
  String? get present => _present;
  String? get halfday => _halfday;
  String? get userId => _userId;
  String? get businessId => _businessId;
  String? get projectId => _projectId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PRESENT'] = _present;
    map['Halfday'] = _halfday;
    map['user_id'] = _userId;
    map['business_id'] = _businessId;
    map['project_id'] = _projectId;
    return map;
  }

}