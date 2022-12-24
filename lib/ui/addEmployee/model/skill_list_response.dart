/// Status : "200"
/// Message : "Getting All Jobs Successfuly. Well done !!"
/// listOfSkills : [{"id":"1","skills":"Driving","project_id":"12","business_id":"12"},{"id":"2","skills":"Electronic Engineer","project_id":"12","business_id":"12"}]

class SkillListResponse {
  SkillListResponse({
      String? status, 
      String? message, 
      List<ListOfSkills>? listOfSkills,}){
    _status = status;
    _message = message;
    _listOfSkills = listOfSkills;
}

  SkillListResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    if (json['Data'] != null) {
      _listOfSkills = [];
      json['Data'].forEach((v) {
        _listOfSkills?.add(ListOfSkills.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<ListOfSkills>? _listOfSkills;
SkillListResponse copyWith({  String? status,
  String? message,
  List<ListOfSkills>? listOfSkills,
}) => SkillListResponse(  status: status ?? _status,
  message: message ?? _message,
  listOfSkills: listOfSkills ?? _listOfSkills,
);
  String? get status => _status;
  String? get message => _message;
  List<ListOfSkills>? get listOfSkills => _listOfSkills;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    if (_listOfSkills != null) {
      map['Data'] = _listOfSkills?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// skills : "Driving"
/// project_id : "12"
/// business_id : "12"

class ListOfSkills {
  ListOfSkills({
      String? id, 
      String? skills, 
      String? projectId, 
      String? businessId,}){
    _id = id;
    _skills = skills;
    _projectId = projectId;
    _businessId = businessId;
}

  ListOfSkills.fromJson(dynamic json) {
    _id = json['id'];
    _skills = json['skills'];
    _projectId = json['project_id'];
    _businessId = json['business_id'];
  }
  String? _id;
  String? _skills;
  String? _projectId;
  String? _businessId;
ListOfSkills copyWith({  String? id,
  String? skills,
  String? projectId,
  String? businessId,
}) => ListOfSkills(  id: id ?? _id,
  skills: skills ?? _skills,
  projectId: projectId ?? _projectId,
  businessId: businessId ?? _businessId,
);
  String? get id => _id;
  String? get skills => _skills;
  String? get projectId => _projectId;
  String? get businessId => _businessId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['skills'] = _skills;
    map['project_id'] = _projectId;
    map['business_id'] = _businessId;
    return map;
  }

}