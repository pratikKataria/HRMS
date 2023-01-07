/// ref_id : "450386"
/// status : "SUCCESS"
/// message : "OTP sent successfully"

class AdhaarCardSendOtpResponse {
  AdhaarCardSendOtpResponse({
      String? refId, 
      String? status, 
      String? message,}){
    _refId = refId;
    _status = status;
    _message = message;
}

  AdhaarCardSendOtpResponse.fromJson(dynamic json) {
    _refId = json['ref_id'];
    _status = json['status'];
    _message = json['message'];
  }
  String? _refId;
  String? _status;
  String? _message;
AdhaarCardSendOtpResponse copyWith({  String? refId,
  String? status,
  String? message,
}) => AdhaarCardSendOtpResponse(  refId: refId ?? _refId,
  status: status ?? _status,
  message: message ?? _message,
);
  String? get refId => _refId;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ref_id'] = _refId;
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}