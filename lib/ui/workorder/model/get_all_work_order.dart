/// Status : "200"
/// Message : "Getting All Workorders..."
/// Data : [{"user_id_count":"2","created_at":"2022-12-01 07:12:56","blocno":"","business_id":"12","project_id":"12"},{"user_id_count":"3","created_at":"2022-12-01 07:12:56","blocno":"1","business_id":"12","project_id":"12"}]

class GetAllWorkOrderResponse {
  GetAllWorkOrderResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetAllWorkOrderResponse.fromJson(dynamic json) {
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
GetAllWorkOrderResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => GetAllWorkOrderResponse(  status: status ?? _status,
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

/// user_id_count : "2"
/// created_at : "2022-12-01 07:12:56"
/// blocno : ""
/// business_id : "12"
/// project_id : "12"

class Data {
  String roboNo = "";
  String inverterNo = "";
  Data({
      String? userIdCount, 
      String? createdAt, 
      String? blocno, 
      String? businessId, 
      String? projectId,}){
    _userIdCount = userIdCount;
    _createdAt = createdAt;
    _blocno = blocno;
    _businessId = businessId;
    _projectId = projectId;
}

  Data.fromJson(dynamic json) {
    _userIdCount = json['user_id_count'];
    _createdAt = json['created_at'];
    _blocno = json['blocno'];
    _businessId = json['business_id'];
    _projectId =  json['project_id'];
    roboNo =  json['robotno'];
    inverterNo = json['inverterno'];
  }
  String? _userIdCount;
  String? _createdAt;
  String? _blocno;
  String? _businessId;
  String? _projectId;
Data copyWith({  String? userIdCount,
  String? createdAt,
  String? blocno,
  String? businessId,
  String? projectId,
}) => Data(  userIdCount: userIdCount ?? _userIdCount,
  createdAt: createdAt ?? _createdAt,
  blocno: blocno ?? _blocno,
  businessId: businessId ?? _businessId,
  projectId: projectId ?? _projectId,
);
  String? get userIdCount => _userIdCount;
  String? get createdAt => _createdAt;
  String? get blocno => _blocno;
  String? get businessId => _businessId;
  String? get projectId => _projectId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id_count'] = _userIdCount;
    map['created_at'] = _createdAt;
    map['blocno'] = _blocno;
    map['business_id'] = _businessId;
    map['project_id'] = _projectId;
    return map;
  }

}