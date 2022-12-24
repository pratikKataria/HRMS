/// Status : "200"
/// Message : "Getting All Jobs Successfuly. Well done !!"
/// listOfParentCompanies : [{"id":"1","company_name":"VIPU GROUP","project_id":"12","business_id":"12"},{"id":"2","company_name":"PU PROJECTS","project_id":"12","business_id":"12"},{"id":"3","company_name":"EMERALD","project_id":"12","business_id":"12"}]

class CompanyListResponse {
  CompanyListResponse({
      String? status, 
      String? message, 
      List<ListOfParentCompanies>? listOfParentCompanies,}){
    _status = status;
    _message = message;
    _listOfParentCompanies = listOfParentCompanies;
}

  CompanyListResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    if (json['Data'] != null) {
      _listOfParentCompanies = [];
      json['Data'].forEach((v) {
        _listOfParentCompanies?.add(ListOfParentCompanies.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<ListOfParentCompanies>? _listOfParentCompanies;
CompanyListResponse copyWith({  String? status,
  String? message,
  List<ListOfParentCompanies>? listOfParentCompanies,
}) => CompanyListResponse(  status: status ?? _status,
  message: message ?? _message,
  listOfParentCompanies: listOfParentCompanies ?? _listOfParentCompanies,
);
  String? get status => _status;
  String? get message => _message;
  List<ListOfParentCompanies>? get listOfParentCompanies => _listOfParentCompanies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    if (_listOfParentCompanies != null) {
      map['Data'] = _listOfParentCompanies?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// company_name : "VIPU GROUP"
/// project_id : "12"
/// business_id : "12"

class ListOfParentCompanies {
  ListOfParentCompanies({
      String? id, 
      String? companyName, 
      String? projectId, 
      String? businessId,}){
    _id = id;
    _companyName = companyName;
    _projectId = projectId;
    _businessId = businessId;
}

  ListOfParentCompanies.fromJson(dynamic json) {
    _id = json['id'];
    _companyName = json['company_name'];
    _projectId = json['project_id'];
    _businessId = json['business_id'];
  }
  String? _id;
  String? _companyName;
  String? _projectId;
  String? _businessId;
ListOfParentCompanies copyWith({  String? id,
  String? companyName,
  String? projectId,
  String? businessId,
}) => ListOfParentCompanies(  id: id ?? _id,
  companyName: companyName ?? _companyName,
  projectId: projectId ?? _projectId,
  businessId: businessId ?? _businessId,
);
  String? get id => _id;
  String? get companyName => _companyName;
  String? get projectId => _projectId;
  String? get businessId => _businessId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['company_name'] = _companyName;
    map['project_id'] = _projectId;
    map['business_id'] = _businessId;
    return map;
  }

}