/// Status : "200"
/// Message : "Getting Account Balance Successfuly. Weldone !!"
/// Balance : -1000

class GetBalanceResponse {
  GetBalanceResponse({
      String? status, 
      String? message, 
      num? balance,}){
    _status = status;
    _message = message;
    _balance = balance;
}

  GetBalanceResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _balance = json['Balance'];
  }
  String? _status;
  String? _message;
  num? _balance;
GetBalanceResponse copyWith({  String? status,
  String? message,
  num? balance,
}) => GetBalanceResponse(  status: status ?? _status,
  message: message ?? _message,
  balance: balance ?? _balance,
);
  String? get status => _status;
  String? get message => _message;
  num? get balance => _balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    map['Balance'] = _balance;
    return map;
  }

}