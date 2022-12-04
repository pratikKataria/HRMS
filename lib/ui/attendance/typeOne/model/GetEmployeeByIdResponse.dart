/// Status : "200"
/// Message : "Getting All Workorders..."
/// Data : [{"id":"21","user_type":"user","surname":"vinod@123","first_name":"vinod","last_name":"sharma","email":"vinode@gmail.com","designation":"manager","project_id":"20"}]

class GetEmployeeByIdResponse {
  GetEmployeeByIdResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetEmployeeByIdResponse.fromJson(dynamic json) {
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
GetEmployeeByIdResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => GetEmployeeByIdResponse(  status: status ?? _status,
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

/// id : "21"
/// user_type : "user"
/// surname : "vinod@123"
/// first_name : "vinod"
/// last_name : "sharma"
/// email : "vinode@gmail.com"
/// designation : "manager"
/// project_id : "20"

class Data {
  Data({
      String? id, 
      String? userType, 
      String? surname, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? designation, 
      String? projectId,}){
    _id = id;
    _userType = userType;
    _surname = surname;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _designation = designation;
    _projectId = projectId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userType = json['user_type'];
    _surname = json['surname'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _designation = json['designation'];
    _projectId = json['project_id'];
  }
  String? _id;
  String? _userType;
  String? _surname;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _designation;
  String? _projectId;
Data copyWith({  String? id,
  String? userType,
  String? surname,
  String? firstName,
  String? lastName,
  String? email,
  String? designation,
  String? projectId,
}) => Data(  id: id ?? _id,
  userType: userType ?? _userType,
  surname: surname ?? _surname,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  designation: designation ?? _designation,
  projectId: projectId ?? _projectId,
);
  String? get id => _id;
  String? get userType => _userType;
  String? get surname => _surname;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get designation => _designation;
  String? get projectId => _projectId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_type'] = _userType;
    map['surname'] = _surname;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['designation'] = _designation;
    map['project_id'] = _projectId;
    return map;
  }

}