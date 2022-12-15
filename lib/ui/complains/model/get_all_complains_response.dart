/// Status : "200"
/// Message : " Getting All Data. Weldone !!"
/// Data : [{"cid":"1","user_id":"26","msg":"Test complaince by it team","file":"uploads/51838bv6.jpeg","status":"close"}]

class GetAllComplainsResponse {
  GetAllComplainsResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetAllComplainsResponse.fromJson(dynamic json) {
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
GetAllComplainsResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => GetAllComplainsResponse(  status: status ?? _status,
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

/// cid : "1"
/// user_id : "26"
/// msg : "Test complaince by it team"
/// file : "uploads/51838bv6.jpeg"
/// status : "close"

class Data {
  Data({
      String? cid, 
      String? userId, 
      String? msg, 
      String? file, 
      String? status,}){
    _cid = cid;
    _userId = userId;
    _msg = msg;
    _file = file;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _cid = json['cid'];
    _userId = json['user_id'];
    _msg = json['msg'];
    _file = json['file'];
    _status = json['status'];
  }
  String? _cid;
  String? _userId;
  String? _msg;
  String? _file;
  String? _status;
Data copyWith({  String? cid,
  String? userId,
  String? msg,
  String? file,
  String? status,
}) => Data(  cid: cid ?? _cid,
  userId: userId ?? _userId,
  msg: msg ?? _msg,
  file: file ?? _file,
  status: status ?? _status,
);
  String? get cid => _cid;
  String? get userId => _userId;
  String? get msg => _msg;
  String? get file => _file;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cid'] = _cid;
    map['user_id'] = _userId;
    map['msg'] = _msg;
    map['file'] = _file;
    map['status'] = _status;
    return map;
  }

}