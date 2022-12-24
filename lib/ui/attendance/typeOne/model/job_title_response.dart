/// Status : "200"
/// Message : "Getting All Jobs Successfuly. Well done !!"
/// jobTitleList : [{"id":"1","job_title":"Grass Cutting","project_id":"12","business_id":"12"},{"id":"2","job_title":"Floor Cleaning ","project_id":"12","business_id":"12"}]

class JobTitleResponse {
  JobTitleResponse({
      String? status, 
      String? message, 
      List<JobTitleList>? jobTitleList,}){
    _status = status;
    _message = message;
    _jobTitleList = jobTitleList;
}

  JobTitleResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    if (json['Data'] != null) {
      _jobTitleList = [];
      json['Data'].forEach((v) {
        _jobTitleList?.add(JobTitleList.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<JobTitleList>? _jobTitleList;
JobTitleResponse copyWith({  String? status,
  String? message,
  List<JobTitleList>? jobTitleList,
}) => JobTitleResponse(  status: status ?? _status,
  message: message ?? _message,
  jobTitleList: jobTitleList ?? _jobTitleList,
);
  String? get status => _status;
  String? get message => _message;
  List<JobTitleList>? get jobTitleList => _jobTitleList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    if (_jobTitleList != null) {
      map['Data'] = _jobTitleList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// job_title : "Grass Cutting"
/// project_id : "12"
/// business_id : "12"

class JobTitleList {
  JobTitleList({
      String? id, 
      String? jobTitle, 
      String? projectId, 
      String? businessId,}){
    _id = id;
    _jobTitle = jobTitle;
    _projectId = projectId;
    _businessId = businessId;
}

  JobTitleList.fromJson(dynamic json) {
    _id = json['id'];
    _jobTitle = json['job_title'];
    _projectId = json['project_id'];
    _businessId = json['business_id'];
  }
  String? _id;
  String? _jobTitle;
  String? _projectId;
  String? _businessId;
JobTitleList copyWith({  String? id,
  String? jobTitle,
  String? projectId,
  String? businessId,
}) => JobTitleList(  id: id ?? _id,
  jobTitle: jobTitle ?? _jobTitle,
  projectId: projectId ?? _projectId,
  businessId: businessId ?? _businessId,
);
  String? get id => _id;
  String? get jobTitle => _jobTitle;
  String? get projectId => _projectId;
  String? get businessId => _businessId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['job_title'] = _jobTitle;
    map['project_id'] = _projectId;
    map['business_id'] = _businessId;
    return map;
  }

}