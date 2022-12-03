/// user_id : ""
/// business_id : "12"
/// project_id : "20"
/// clock_in_note : "test"
/// blockno : ""
/// robotno : ""
/// inverterno : ""
/// type : "2"
/// Login : "login"
/// job_title : ""

class MarkAttendenceTypeTwoRequest {

  String? name;
  String? empId;

  MarkAttendenceTypeTwoRequest({
      String? userId, 
      String? businessId, 
      String? projectId, 
      String? clockInNote, 
      String? blockno, 
      String? robotno, 
      String? inverterno, 
      String? type, 
      String? login, 
      String? jobTitle,}){
    _userId = userId;
    _businessId = businessId;
    _projectId = projectId;
    _clockInNote = clockInNote;
    _blockno = blockno;
    _robotno = robotno;
    _inverterno = inverterno;
    _type = type;
    _login = login;
    _jobTitle = jobTitle;
}

  MarkAttendenceTypeTwoRequest.fromJson(dynamic json) {
    _userId = json['user_id'];
    _businessId = json['business_id'];
    _projectId = json['project_id'];
    _clockInNote = json['clock_in_note'];
    _blockno = json['blockno'];
    _robotno = json['robotno'];
    _inverterno = json['inverterno'];
    _type = json['type'];
    _login = json['Login'];
    _jobTitle = json['job_title'];
  }
  String? _userId;
  String? _businessId;
  String? _projectId;
  String? _clockInNote;
  String? _blockno;
  String? _robotno;
  String? _inverterno;
  String? _type;
  String? _login;
  String? _jobTitle;

MarkAttendenceTypeTwoRequest copyWith({  String? userId,
  String? businessId,
  String? projectId,
  String? clockInNote,
  String? blockno,
  String? robotno,
  String? inverterno,
  String? type,
  String? login,
  String? jobTitle,
}) => MarkAttendenceTypeTwoRequest(  userId: userId ?? _userId,
  businessId: businessId ?? _businessId,
  projectId: projectId ?? _projectId,
  clockInNote: clockInNote ?? _clockInNote,
  blockno: blockno ?? _blockno,
  robotno: robotno ?? _robotno,
  inverterno: inverterno ?? _inverterno,
  type: type ?? _type,
  login: login ?? _login,
  jobTitle: jobTitle ?? _jobTitle,
);
  String? get userId => _userId;
  String? get businessId => _businessId;
  String? get projectId => _projectId;
  String? get clockInNote => _clockInNote;
  String? get blockno => _blockno;
  String? get robotno => _robotno;
  String? get inverterno => _inverterno;
  String? get type => _type;
  String? get login => _login;
  String? get jobTitle => _jobTitle;




  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['business_id'] = _businessId;
    map['project_id'] = _projectId;
    map['clock_in_note'] = _clockInNote;
    map['blockno'] = _blockno;
    map['robotno'] = _robotno;
    map['inverterno'] = _inverterno;
    map['type'] = _type;
    map['Login'] = _login;
    map['job_title'] = _jobTitle;
    return map;
  }

  set userId(String? value) {
    _userId = value;
  }

  set businessId(String? value) {
    _businessId = value;
  }

  set projectId(String? value) {
    _projectId = value;
  }

  set clockInNote(String? value) {
    _clockInNote = value;
  }

  set blockno(String? value) {
    _blockno = value;
  }

  set robotno(String? value) {
    _robotno = value;
  }

  set inverterno(String? value) {
    _inverterno = value;
  }

  set type(String? value) {
    _type = value;
  }

  set login(String? value) {
    _login = value;
  }

  set jobTitle(String? value) {
    _jobTitle = value;
  }
}