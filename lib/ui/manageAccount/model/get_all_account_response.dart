/// Status : "200"
/// Message : "Getting All Accounts Successfuly. Weldone !!"
/// Data : [{"id":"3","business_id":"12","name":"PU PROJECTS","account_number":"123456789122","account_type_id":"3","note":"Add to JAN 2022","created_by":"17","is_closed":"0","deleted_at":null,"created_at":"2022-12-12 09:18:26","updated_at":"2022-12-12 09:19:55"},{"id":"4","business_id":"12","name":"VIPU GROUPS","account_number":"112233445566","account_type_id":"3","note":"ADD ON 12 DEC","created_by":"17","is_closed":"0","deleted_at":null,"created_at":"2022-12-12 09:22:00","updated_at":"2022-12-12 09:22:00"},{"id":"5","business_id":"12","name":"SHUBHAM","account_number":"4587845875","account_type_id":"4","note":"SUPER VISOR ACCOUNT FOR DAILY EXPENSES","created_by":"17","is_closed":"0","deleted_at":null,"created_at":"2022-12-12 09:26:43","updated_at":"2022-12-12 09:26:43"},{"id":"6","business_id":"12","name":"ANUJ","account_number":"4545454121","account_type_id":"4","note":"ACCOUNT FOR MANAGER EXPENSES","created_by":"17","is_closed":"0","deleted_at":null,"created_at":"2022-12-12 09:27:36","updated_at":"2022-12-12 09:27:36"},{"id":"7","business_id":"12","name":"Mohit","account_number":"1232455","account_type_id":"4","note":"test account","created_by":"12","is_closed":"0","deleted_at":null,"created_at":"2022-12-12 04:28:43","updated_at":null},{"id":"8","business_id":"12","name":"Mohit","account_number":"1232455","account_type_id":"4","note":"test expences","created_by":"17","is_closed":"0","deleted_at":null,"created_at":"2022-12-13 12:21:45","updated_at":null},{"id":"9","business_id":"12","name":"Mohit","account_number":"1232455","account_type_id":"4","note":"test account","created_by":"0","is_closed":"0","deleted_at":null,"created_at":"2022-12-13 12:22:08","updated_at":null}]

class GetAllAccountResponse {
  GetAllAccountResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetAllAccountResponse.fromJson(dynamic json) {
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
GetAllAccountResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => GetAllAccountResponse(  status: status ?? _status,
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
/// business_id : "12"
/// name : "PU PROJECTS"
/// account_number : "123456789122"
/// account_type_id : "3"
/// note : "Add to JAN 2022"
/// created_by : "17"
/// is_closed : "0"
/// deleted_at : null
/// created_at : "2022-12-12 09:18:26"
/// updated_at : "2022-12-12 09:19:55"

class Data {
  Data({
      String? id, 
      String? businessId, 
      String? name, 
      String? accountNumber, 
      String? accountTypeId, 
      String? note, 
      String? createdBy, 
      String? isClosed, 
      dynamic deletedAt, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _businessId = businessId;
    _name = name;
    _accountNumber = accountNumber;
    _accountTypeId = accountTypeId;
    _note = note;
    _createdBy = createdBy;
    _isClosed = isClosed;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _businessId = json['business_id'];
    _name = json['name'];
    _accountNumber = json['account_number'];
    _accountTypeId = json['account_type_id'];
    _note = json['note'];
    _createdBy = json['created_by'];
    _isClosed = json['is_closed'];
    _deletedAt = json['deleted_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _businessId;
  String? _name;
  String? _accountNumber;
  String? _accountTypeId;
  String? _note;
  String? _createdBy;
  String? _isClosed;
  dynamic _deletedAt;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? businessId,
  String? name,
  String? accountNumber,
  String? accountTypeId,
  String? note,
  String? createdBy,
  String? isClosed,
  dynamic deletedAt,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  businessId: businessId ?? _businessId,
  name: name ?? _name,
  accountNumber: accountNumber ?? _accountNumber,
  accountTypeId: accountTypeId ?? _accountTypeId,
  note: note ?? _note,
  createdBy: createdBy ?? _createdBy,
  isClosed: isClosed ?? _isClosed,
  deletedAt: deletedAt ?? _deletedAt,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get businessId => _businessId;
  String? get name => _name;
  String? get accountNumber => _accountNumber;
  String? get accountTypeId => _accountTypeId;
  String? get note => _note;
  String? get createdBy => _createdBy;
  String? get isClosed => _isClosed;
  dynamic get deletedAt => _deletedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['business_id'] = _businessId;
    map['name'] = _name;
    map['account_number'] = _accountNumber;
    map['account_type_id'] = _accountTypeId;
    map['note'] = _note;
    map['created_by'] = _createdBy;
    map['is_closed'] = _isClosed;
    map['deleted_at'] = _deletedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}