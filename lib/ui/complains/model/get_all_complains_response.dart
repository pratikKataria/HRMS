/// Status : "200"
/// Message : " Getting All Data. Well done !!"
/// Data : [{"cid":"20","user_id":"22","msg":"pratik 2020","admin_note":"Test 2020","file":"uploads/19345","status":"Close"}]

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

/// cid : "20"
/// user_id : "22"
/// msg : "pratik 2020"
/// admin_note : "Test 2020"
/// file : "uploads/19345"
/// status : "Close"

class Data {
  Data({
      String? cid, 
      String? userId, 
      String? msg, 
      String? adminNote, 
      String? file, 
      String? status,}){
    _cid = cid;
    _userId = userId;
    _msg = msg;
    _adminNote = adminNote;
    _file = file;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _cid = json['cid'];
    _userId = json['user_id'];
    _msg = json['msg'];
    _adminNote = json['admin_note'];
    _file = json['file'];
    _status = json['status'];
  }
  String? _cid;
  String? _userId;
  String? _msg;
  String? _adminNote;
  String? _file;
  String? _status;
Data copyWith({  String? cid,
  String? userId,
  String? msg,
  String? adminNote,
  String? file,
  String? status,
}) => Data(  cid: cid ?? _cid,
  userId: userId ?? _userId,
  msg: msg ?? _msg,
  adminNote: adminNote ?? _adminNote,
  file: file ?? _file,
  status: status ?? _status,
);
  String? get cid => _cid;
  String? get userId => _userId;
  String? get msg => _msg;
  String? get adminNote => _adminNote;
  String? get file => _file;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cid'] = _cid;
    map['user_id'] = _userId;
    map['msg'] = _msg;
    map['admin_note'] = _adminNote;
    map['file'] = _file;
    map['status'] = _status;
    return map;
  }

}