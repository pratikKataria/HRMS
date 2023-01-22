/// Status : "200"
/// Message : "Getting All Roles Successfuly. Well done !!"
/// Data : [{"name":"Admin#12","is_default":"1"},{"name":"Cashier#12#12#12","is_default":"0"},{"name":"Supervisor#12","is_default":"0"},{"name":"Ub-Skilled Employee#12","is_default":"0"},{"name":"Skilled Employee#12","is_default":"0"},{"name":"client_login#12","is_default":"0"},{"name":"Supervisor_Pro#12","is_default":"0"}]

class RolesResponse {
  RolesResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  RolesResponse.fromJson(dynamic json) {
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
RolesResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => RolesResponse(  status: status ?? _status,
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

/// name : "Admin#12"
/// is_default : "1"

class Data {
  Data({
      String? name, 
      String? isDefault,}){
    _name = name;
    _isDefault = isDefault;
}

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _isDefault = json['is_default'];
  }
  String? _name;
  String? _isDefault;
Data copyWith({  String? name,
  String? isDefault,
}) => Data(  name: name ?? _name,
  isDefault: isDefault ?? _isDefault,
);
  String? get name => _name;
  String? get isDefault => _isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['is_default'] = _isDefault;
    return map;
  }

}