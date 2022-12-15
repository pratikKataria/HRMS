/// Status : "200"
/// Message : "Getting Accounts Types Successfuly. Weldone !!"
/// Data : [{"id":"3","name":"Virtual","parent_account_type_id":"","business_id":"12","created_at":"2022-12-12 09:19:41","updated_at":"2022-12-12 09:19:41"}]

class GetAllTypes {
  GetAllTypes({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetAllTypes.fromJson(dynamic json) {
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
GetAllTypes copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => GetAllTypes(  status: status ?? _status,
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

/// id : "3"
/// name : "Virtual"
/// parent_account_type_id : ""
/// business_id : "12"
/// created_at : "2022-12-12 09:19:41"
/// updated_at : "2022-12-12 09:19:41"

class Data {
  Data({
      String? id, 
      String? name, 
      String? parentAccountTypeId, 
      String? businessId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _parentAccountTypeId = parentAccountTypeId;
    _businessId = businessId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parentAccountTypeId = json['parent_account_type_id'];
    _businessId = json['business_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  String? _parentAccountTypeId;
  String? _businessId;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? name,
  String? parentAccountTypeId,
  String? businessId,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  parentAccountTypeId: parentAccountTypeId ?? _parentAccountTypeId,
  businessId: businessId ?? _businessId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get parentAccountTypeId => _parentAccountTypeId;
  String? get businessId => _businessId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['parent_account_type_id'] = _parentAccountTypeId;
    map['business_id'] = _businessId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}