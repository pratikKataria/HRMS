/// Status : "200"
/// Message : "Getting User Presents Successfuly. Weldone !!"
/// UserDetailData : [{"id":"12","created_by":"","user_id":"21","business_id":"12","project_id":"12","job_title":"do gi vo bhi BP BP","clock_in_time":"2022-12-03 01:51:55","clock_out_time":"2022-12-03 07:23:47","halfday":"","type":"1","blockno":"","robotno":"","inverterno":"","essentials_shift_id":"","ip_address":"","clock_in_note":"na","clock_out_note":"test","created_at":"","updated_at":""}]

class UserAttendanceDetailResponse {
  UserAttendanceDetailResponse({
      String? status, 
      String? message, 
      List<UserDetailData>? userDetailData,}){
    _status = status;
    _message = message;
    _userDetailData = userDetailData;
}

  UserAttendanceDetailResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    if (json['Data'] != null) {
      _userDetailData = [];
      json['Data'].forEach((v) {
        _userDetailData?.add(UserDetailData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<UserDetailData>? _userDetailData;
UserAttendanceDetailResponse copyWith({  String? status,
  String? message,
  List<UserDetailData>? userDetailData,
}) => UserAttendanceDetailResponse(  status: status ?? _status,
  message: message ?? _message,
  userDetailData: userDetailData ?? _userDetailData,
);
  String? get status => _status;
  String? get message => _message;
  List<UserDetailData>? get userDetailData => _userDetailData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    if (_userDetailData != null) {
      map['Data'] = _userDetailData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "12"
/// created_by : ""
/// user_id : "21"
/// business_id : "12"
/// project_id : "12"
/// job_title : "do gi vo bhi BP BP"
/// clock_in_time : "2022-12-03 01:51:55"
/// clock_out_time : "2022-12-03 07:23:47"
/// halfday : ""
/// type : "1"
/// blockno : ""
/// robotno : ""
/// inverterno : ""
/// essentials_shift_id : ""
/// ip_address : ""
/// clock_in_note : "na"
/// clock_out_note : "test"
/// created_at : ""
/// updated_at : ""

class UserDetailData {
  UserDetailData({
      String? id, 
      String? createdBy, 
      String? userId, 
      String? businessId, 
      String? projectId, 
      String? jobTitle, 
      String? clockInTime, 
      String? clockOutTime, 
      String? halfday, 
      String? type, 
      String? blockno, 
      String? robotno, 
      String? inverterno, 
      String? essentialsShiftId, 
      String? ipAddress, 
      String? clockInNote, 
      String? clockOutNote, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _createdBy = createdBy;
    _userId = userId;
    _businessId = businessId;
    _projectId = projectId;
    _jobTitle = jobTitle;
    _clockInTime = clockInTime;
    _clockOutTime = clockOutTime;
    _halfday = halfday;
    _type = type;
    _blockno = blockno;
    _robotno = robotno;
    _inverterno = inverterno;
    _essentialsShiftId = essentialsShiftId;
    _ipAddress = ipAddress;
    _clockInNote = clockInNote;
    _clockOutNote = clockOutNote;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  UserDetailData.fromJson(dynamic json) {
    _id = json['id'];
    _createdBy = json['created_by'];
    _userId = json['user_id'];
    _businessId = json['business_id'];
    _projectId = json['project_id'];
    _jobTitle = json['job_title'];
    _clockInTime = json['clock_in_time'];
    _clockOutTime = json['clock_out_time'];
    _halfday = json['halfday'];
    _type = json['type'];
    _blockno = json['blockno'];
    _robotno = json['robotno'];
    _inverterno = json['inverterno'];
    _essentialsShiftId = json['essentials_shift_id'];
    _ipAddress = json['ip_address'];
    _clockInNote = json['clock_in_note'];
    _clockOutNote = json['clock_out_note'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _createdBy;
  String? _userId;
  String? _businessId;
  String? _projectId;
  String? _jobTitle;
  String? _clockInTime;
  String? _clockOutTime;
  String? _halfday;
  String? _type;
  String? _blockno;
  String? _robotno;
  String? _inverterno;
  String? _essentialsShiftId;
  String? _ipAddress;
  String? _clockInNote;
  String? _clockOutNote;
  String? _createdAt;
  String? _updatedAt;
UserDetailData copyWith({  String? id,
  String? createdBy,
  String? userId,
  String? businessId,
  String? projectId,
  String? jobTitle,
  String? clockInTime,
  String? clockOutTime,
  String? halfday,
  String? type,
  String? blockno,
  String? robotno,
  String? inverterno,
  String? essentialsShiftId,
  String? ipAddress,
  String? clockInNote,
  String? clockOutNote,
  String? createdAt,
  String? updatedAt,
}) => UserDetailData(  id: id ?? _id,
  createdBy: createdBy ?? _createdBy,
  userId: userId ?? _userId,
  businessId: businessId ?? _businessId,
  projectId: projectId ?? _projectId,
  jobTitle: jobTitle ?? _jobTitle,
  clockInTime: clockInTime ?? _clockInTime,
  clockOutTime: clockOutTime ?? _clockOutTime,
  halfday: halfday ?? _halfday,
  type: type ?? _type,
  blockno: blockno ?? _blockno,
  robotno: robotno ?? _robotno,
  inverterno: inverterno ?? _inverterno,
  essentialsShiftId: essentialsShiftId ?? _essentialsShiftId,
  ipAddress: ipAddress ?? _ipAddress,
  clockInNote: clockInNote ?? _clockInNote,
  clockOutNote: clockOutNote ?? _clockOutNote,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get createdBy => _createdBy;
  String? get userId => _userId;
  String? get businessId => _businessId;
  String? get projectId => _projectId;
  String? get jobTitle => _jobTitle;
  String? get clockInTime => _clockInTime;
  String? get clockOutTime => _clockOutTime;
  String? get halfday => _halfday;
  String? get type => _type;
  String? get blockno => _blockno;
  String? get robotno => _robotno;
  String? get inverterno => _inverterno;
  String? get essentialsShiftId => _essentialsShiftId;
  String? get ipAddress => _ipAddress;
  String? get clockInNote => _clockInNote;
  String? get clockOutNote => _clockOutNote;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['created_by'] = _createdBy;
    map['user_id'] = _userId;
    map['business_id'] = _businessId;
    map['project_id'] = _projectId;
    map['job_title'] = _jobTitle;
    map['clock_in_time'] = _clockInTime;
    map['clock_out_time'] = _clockOutTime;
    map['halfday'] = _halfday;
    map['type'] = _type;
    map['blockno'] = _blockno;
    map['robotno'] = _robotno;
    map['inverterno'] = _inverterno;
    map['essentials_shift_id'] = _essentialsShiftId;
    map['ip_address'] = _ipAddress;
    map['clock_in_note'] = _clockInNote;
    map['clock_out_note'] = _clockOutNote;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}