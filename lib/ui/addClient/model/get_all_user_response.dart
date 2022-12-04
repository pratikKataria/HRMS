/// Status : "200"
/// Message : "Getting All Users Successfuly. Weldone !!"
/// Data : [{"id":"17","user_type":"user","surname":"mr","first_name":"test","last_name":"vala","email":"prashant27dangare27@gmail.com","designation":"Manager","project_id_list":{"project_id":["21"]}}]

class GetAllUserResponse {
  GetAllUserResponse({
    String? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetAllUserResponse.fromJson(dynamic json) {
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

  GetAllUserResponse copyWith({
    String? status,
    String? message,
    List<Data>? data,
  }) =>
      GetAllUserResponse(
        status: status ?? _status,
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

/// id : "17"
/// user_type : "user"
/// surname : "mr"
/// first_name : "test"
/// last_name : "vala"
/// email : "prashant27dangare27@gmail.com"
/// designation : "Manager"
/// project_id_list : {"project_id":["21"]}

class Data {
  Data({
    String? id,
    String? userType,
    String? surname,
    String? firstName,
    String? lastName,
    String? email,
    String? designation,
    ProjectIdList? projectIdList,
  }) {
    _id = id;
    _userType = userType;
    _surname = surname;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _designation = designation;
    _projectIdList = projectIdList;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userType = json['user_type'];
    _surname = json['surname'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _designation = json['designation'];
    _projectIdList = json['project_id_list'] != null  ? ProjectIdList.fromJson(json['project_id_list']) : null;
  }

  String? _id;
  String? _userType;
  String? _surname;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _designation;
  ProjectIdList? _projectIdList;

  Data copyWith({
    String? id,
    String? userType,
    String? surname,
    String? firstName,
    String? lastName,
    String? email,
    String? designation,
    ProjectIdList? projectIdList,
  }) =>
      Data(
        id: id ?? _id,
        userType: userType ?? _userType,
        surname: surname ?? _surname,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        email: email ?? _email,
        designation: designation ?? _designation,
        projectIdList: projectIdList ?? _projectIdList,
      );

  String? get id => _id;

  String? get userType => _userType;

  String? get surname => _surname;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get email => _email;

  String? get designation => _designation;

  ProjectIdList? get projectIdList => _projectIdList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_type'] = _userType;
    map['surname'] = _surname;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['designation'] = _designation;
    map['project_id_list'] = _projectIdList;
    return map;
  }
}

/// project_id : ["21"]

class ProjectIdList {
  ProjectIdList({
    List<String>? projectId,
  }) {
    _projectId = projectId;
  }

  ProjectIdList.fromJson(dynamic json) {
    _projectId = json['project_id'] != null ? json['project_id'].cast<String>() : [];
  }

  List<String>? _projectId;

  ProjectIdList copyWith({
    List<String>? projectId,
  }) =>
      ProjectIdList(
        projectId: projectId ?? _projectId,
      );

  List<String>? get projectId => _projectId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['project_id'] = _projectId;
    return map;
  }
}
