/// Status : "200"
/// Message : "Compliance Added Successfuly. Weldone !!"
/// Data : [""]

class SubmitComplainResponse {
  SubmitComplainResponse({
      String? status, 
      String? message, 
      List<String>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  SubmitComplainResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _data = json['Data'] != null ? json['Data'].cast<String>() : [];
  }
  String? _status;
  String? _message;
  List<String>? _data;
SubmitComplainResponse copyWith({  String? status,
  String? message,
  List<String>? data,
}) => SubmitComplainResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
  String? get message => _message;
  List<String>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    map['Data'] = _data;
    return map;
  }

}