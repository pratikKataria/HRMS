/// Status : "200"
/// Message : "Getting All Projects..."
/// Data : [{"pid":"23","client_name":"test","registration_date":"0000-00-00 00:00:00","registration_number":"","gstin":"heuej3jebsb","contact_person":"Test","contact_person_mobile":"6262666822","contact_person_email":"test@gmail.com","full_address":"11","pincode":"452010","landmark":"indore","city":"indore","account_number":"","ifsc":"","aadhar":"","aadhar_image":"","pan":"","pan_image":"","status":"1","creteded_at":"2022-12-04 15:49:49","project_id":"23","aadhar_img":"https://vipugroup.com/final/uploads/","pan_img":"https://vipugroup.com/final/uploads/","signature_img":"https://vipugroup.com/final/uploads/","employees":["20","23","44","55","67","20","23","44","55","67"]}]

class GetAllProjectsResponse {
  GetAllProjectsResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetAllProjectsResponse.fromJson(dynamic json) {
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
GetAllProjectsResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => GetAllProjectsResponse(  status: status ?? _status,
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

/// pid : "23"
/// client_name : "test"
/// registration_date : "0000-00-00 00:00:00"
/// registration_number : ""
/// gstin : "heuej3jebsb"
/// contact_person : "Test"
/// contact_person_mobile : "6262666822"
/// contact_person_email : "test@gmail.com"
/// full_address : "11"
/// pincode : "452010"
/// landmark : "indore"
/// city : "indore"
/// account_number : ""
/// ifsc : ""
/// aadhar : ""
/// aadhar_image : ""
/// pan : ""
/// pan_image : ""
/// status : "1"
/// creteded_at : "2022-12-04 15:49:49"
/// project_id : "23"
/// aadhar_img : "https://vipugroup.com/final/uploads/"
/// pan_img : "https://vipugroup.com/final/uploads/"
/// signature_img : "https://vipugroup.com/final/uploads/"
/// employees : ["20","23","44","55","67","20","23","44","55","67"]

class Data {
  Data({
      String? pid, 
      String? clientName, 
      String? registrationDate, 
      String? registrationNumber, 
      String? gstin, 
      String? contactPerson, 
      String? contactPersonMobile, 
      String? contactPersonEmail, 
      String? fullAddress, 
      String? pincode, 
      String? landmark, 
      String? city, 
      String? accountNumber, 
      String? ifsc, 
      String? aadhar, 
      String? aadharImage, 
      String? pan, 
      String? panImage, 
      String? status, 
      String? cretededAt, 
      String? projectId, 
      String? aadharImg, 
      String? panImg, 
      String? signatureImg, 
      List<String>? employees,}){
    _pid = pid;
    _clientName = clientName;
    _registrationDate = registrationDate;
    _registrationNumber = registrationNumber;
    _gstin = gstin;
    _contactPerson = contactPerson;
    _contactPersonMobile = contactPersonMobile;
    _contactPersonEmail = contactPersonEmail;
    _fullAddress = fullAddress;
    _pincode = pincode;
    _landmark = landmark;
    _city = city;
    _accountNumber = accountNumber;
    _ifsc = ifsc;
    _aadhar = aadhar;
    _aadharImage = aadharImage;
    _pan = pan;
    _panImage = panImage;
    _status = status;
    _cretededAt = cretededAt;
    _projectId = projectId;
    _aadharImg = aadharImg;
    _panImg = panImg;
    _signatureImg = signatureImg;
    _employees = employees;
}

  Data.fromJson(dynamic json) {
    _pid = json['pid'];
    _clientName = json['client_name'];
    _registrationDate = json['registration_date'];
    _registrationNumber = json['registration_number'];
    _gstin = json['gstin'];
    _contactPerson = json['contact_person'];
    _contactPersonMobile = json['contact_person_mobile'];
    _contactPersonEmail = json['contact_person_email'];
    _fullAddress = json['full_address'];
    _pincode = json['pincode'];
    _landmark = json['landmark'];
    _city = json['city'];
    _accountNumber = json['account_number'];
    _ifsc = json['ifsc'];
    _aadhar = json['aadhar'];
    _aadharImage = json['aadhar_image'];
    _pan = json['pan'];
    _panImage = json['pan_image'];
    _status = json['status'];
    _cretededAt = json['creteded_at'];
    _projectId = json['project_id'];
    _aadharImg = json['aadhar_img'];
    _panImg = json['pan_img'];
    _signatureImg = json['signature_img'];
    _employees = json['employees'] != null ? json['employees'].cast<String>() : [];
  }
  String? _pid;
  String? _clientName;
  String? _registrationDate;
  String? _registrationNumber;
  String? _gstin;
  String? _contactPerson;
  String? _contactPersonMobile;
  String? _contactPersonEmail;
  String? _fullAddress;
  String? _pincode;
  String? _landmark;
  String? _city;
  String? _accountNumber;
  String? _ifsc;
  String? _aadhar;
  String? _aadharImage;
  String? _pan;
  String? _panImage;
  String? _status;
  String? _cretededAt;
  String? _projectId;
  String? _aadharImg;
  String? _panImg;
  String? _signatureImg;
  List<String>? _employees;
Data copyWith({  String? pid,
  String? clientName,
  String? registrationDate,
  String? registrationNumber,
  String? gstin,
  String? contactPerson,
  String? contactPersonMobile,
  String? contactPersonEmail,
  String? fullAddress,
  String? pincode,
  String? landmark,
  String? city,
  String? accountNumber,
  String? ifsc,
  String? aadhar,
  String? aadharImage,
  String? pan,
  String? panImage,
  String? status,
  String? cretededAt,
  String? projectId,
  String? aadharImg,
  String? panImg,
  String? signatureImg,
  List<String>? employees,
}) => Data(  pid: pid ?? _pid,
  clientName: clientName ?? _clientName,
  registrationDate: registrationDate ?? _registrationDate,
  registrationNumber: registrationNumber ?? _registrationNumber,
  gstin: gstin ?? _gstin,
  contactPerson: contactPerson ?? _contactPerson,
  contactPersonMobile: contactPersonMobile ?? _contactPersonMobile,
  contactPersonEmail: contactPersonEmail ?? _contactPersonEmail,
  fullAddress: fullAddress ?? _fullAddress,
  pincode: pincode ?? _pincode,
  landmark: landmark ?? _landmark,
  city: city ?? _city,
  accountNumber: accountNumber ?? _accountNumber,
  ifsc: ifsc ?? _ifsc,
  aadhar: aadhar ?? _aadhar,
  aadharImage: aadharImage ?? _aadharImage,
  pan: pan ?? _pan,
  panImage: panImage ?? _panImage,
  status: status ?? _status,
  cretededAt: cretededAt ?? _cretededAt,
  projectId: projectId ?? _projectId,
  aadharImg: aadharImg ?? _aadharImg,
  panImg: panImg ?? _panImg,
  signatureImg: signatureImg ?? _signatureImg,
  employees: employees ?? _employees,
);
  String? get pid => _pid;
  String? get clientName => _clientName;
  String? get registrationDate => _registrationDate;
  String? get registrationNumber => _registrationNumber;
  String? get gstin => _gstin;
  String? get contactPerson => _contactPerson;
  String? get contactPersonMobile => _contactPersonMobile;
  String? get contactPersonEmail => _contactPersonEmail;
  String? get fullAddress => _fullAddress;
  String? get pincode => _pincode;
  String? get landmark => _landmark;
  String? get city => _city;
  String? get accountNumber => _accountNumber;
  String? get ifsc => _ifsc;
  String? get aadhar => _aadhar;
  String? get aadharImage => _aadharImage;
  String? get pan => _pan;
  String? get panImage => _panImage;
  String? get status => _status;
  String? get cretededAt => _cretededAt;
  String? get projectId => _projectId;
  String? get aadharImg => _aadharImg;
  String? get panImg => _panImg;
  String? get signatureImg => _signatureImg;
  List<String>? get employees => _employees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pid'] = _pid;
    map['client_name'] = _clientName;
    map['registration_date'] = _registrationDate;
    map['registration_number'] = _registrationNumber;
    map['gstin'] = _gstin;
    map['contact_person'] = _contactPerson;
    map['contact_person_mobile'] = _contactPersonMobile;
    map['contact_person_email'] = _contactPersonEmail;
    map['full_address'] = _fullAddress;
    map['pincode'] = _pincode;
    map['landmark'] = _landmark;
    map['city'] = _city;
    map['account_number'] = _accountNumber;
    map['ifsc'] = _ifsc;
    map['aadhar'] = _aadhar;
    map['aadhar_image'] = _aadharImage;
    map['pan'] = _pan;
    map['pan_image'] = _panImage;
    map['status'] = _status;
    map['creteded_at'] = _cretededAt;
    map['project_id'] = _projectId;
    map['aadhar_img'] = _aadharImg;
    map['pan_img'] = _panImg;
    map['signature_img'] = _signatureImg;
    map['employees'] = _employees;
    return map;
  }

}