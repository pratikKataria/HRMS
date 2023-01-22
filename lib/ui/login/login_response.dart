/// Status : "200"
/// Message : "Login Users Successfuly. Weldone !!"
/// Data : [{"id":"22","user_type":"user","role":"Admin#12","surname":"vinod@123","first_name":"vinod","last_name":"sharma","username":"vinode2@gmail.com","password":"123456","email":"vinode2@gmail.com","language":"en","emergencynumber":"+919598569859","skilled":"","skills":"","company":"","doj":"","pf":"0","esic":"0","uan":"","workingdays":"56","shift_time":"","perdayspayout":"20000","pfemployeecontribution":"18","pfemployercontribution":"5","esicemployeecontribution":"10","esicemployercontribution":"18","designation":"manager","department":"","operations":"PU PROJECTS DEVELOPMENT & CONCEPT OPC PVT LTD","contact_no":"9856985698","address":"indore","remember_token":"","business_id":"12","max_sales_discount_percent":"","allow_login":"1","essentials_department_id":"","essentials_designation_id":"","status":"active","is_cmmsn_agnt":"0","cmmsn_percent":"0.00","selected_contacts":"0","dob":"0000-00-00","gender":"m","marital_status":"","blood_group":"","contact_number":"","fb_link":"","twitter_link":"","social_media_1":"","social_media_2":"","permanent_address":"indore","pincode":"","landmark":"","city":"","state":"","current_address":"indore","guardian_name":"","custom_field_1":"","custom_field_2":"","custom_field_3":"","custom_field_4":"","bank_details":"sbi","account_number":"","account_holder":"","ifsc":"","aadhar_number":"","pan_number":"","id_proof_name":"aadhar","id_proof_number":"123412341234","aadhar_img":"","pan_img":"","signature_img":"","deleted_at":"2022-12-25 18:59:44","created_at":"","updated_at":"2022-12-25 18:59:44"}]

class LoginResponse {
  LoginResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  LoginResponse.fromJson(dynamic json) {
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
LoginResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => LoginResponse(  status: status ?? _status,
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

/// id : "22"
/// user_type : "user"
/// role : "Admin#12"
/// surname : "vinod@123"
/// first_name : "vinod"
/// last_name : "sharma"
/// username : "vinode2@gmail.com"
/// password : "123456"
/// email : "vinode2@gmail.com"
/// language : "en"
/// emergencynumber : "+919598569859"
/// skilled : ""
/// skills : ""
/// company : ""
/// doj : ""
/// pf : "0"
/// esic : "0"
/// uan : ""
/// workingdays : "56"
/// shift_time : ""
/// perdayspayout : "20000"
/// pfemployeecontribution : "18"
/// pfemployercontribution : "5"
/// esicemployeecontribution : "10"
/// esicemployercontribution : "18"
/// designation : "manager"
/// department : ""
/// operations : "PU PROJECTS DEVELOPMENT & CONCEPT OPC PVT LTD"
/// contact_no : "9856985698"
/// address : "indore"
/// remember_token : ""
/// business_id : "12"
/// max_sales_discount_percent : ""
/// allow_login : "1"
/// essentials_department_id : ""
/// essentials_designation_id : ""
/// status : "active"
/// is_cmmsn_agnt : "0"
/// cmmsn_percent : "0.00"
/// selected_contacts : "0"
/// dob : "0000-00-00"
/// gender : "m"
/// marital_status : ""
/// blood_group : ""
/// contact_number : ""
/// fb_link : ""
/// twitter_link : ""
/// social_media_1 : ""
/// social_media_2 : ""
/// permanent_address : "indore"
/// pincode : ""
/// landmark : ""
/// city : ""
/// state : ""
/// current_address : "indore"
/// guardian_name : ""
/// custom_field_1 : ""
/// custom_field_2 : ""
/// custom_field_3 : ""
/// custom_field_4 : ""
/// bank_details : "sbi"
/// account_number : ""
/// account_holder : ""
/// ifsc : ""
/// aadhar_number : ""
/// pan_number : ""
/// id_proof_name : "aadhar"
/// id_proof_number : "123412341234"
/// aadhar_img : ""
/// pan_img : ""
/// signature_img : ""
/// deleted_at : "2022-12-25 18:59:44"
/// created_at : ""
/// updated_at : "2022-12-25 18:59:44"

class Data {
  Data({
      String? id, 
      String? userType, 
      String? role, 
      String? surname, 
      String? firstName, 
      String? lastName, 
      String? username, 
      String? password, 
      String? email, 
      String? language, 
      String? emergencynumber, 
      String? skilled, 
      String? skills, 
      String? company, 
      String? doj, 
      String? pf, 
      String? esic, 
      String? uan, 
      String? workingdays, 
      String? shiftTime, 
      String? perdayspayout, 
      String? pfemployeecontribution, 
      String? pfemployercontribution, 
      String? esicemployeecontribution, 
      String? esicemployercontribution, 
      String? designation, 
      String? department, 
      String? operations, 
      String? contactNo, 
      String? address, 
      String? rememberToken, 
      String? businessId, 
      String? maxSalesDiscountPercent, 
      String? allowLogin, 
      String? essentialsDepartmentId, 
      String? essentialsDesignationId, 
      String? status, 
      String? isCmmsnAgnt, 
      String? cmmsnPercent, 
      String? selectedContacts, 
      String? dob, 
      String? gender, 
      String? maritalStatus, 
      String? bloodGroup, 
      String? contactNumber, 
      String? fbLink, 
      String? twitterLink, 
      String? socialMedia1, 
      String? socialMedia2, 
      String? permanentAddress, 
      String? pincode, 
      String? landmark, 
      String? city, 
      String? state, 
      String? currentAddress, 
      String? guardianName, 
      String? customField1, 
      String? customField2, 
      String? customField3, 
      String? customField4, 
      String? bankDetails, 
      String? accountNumber, 
      String? accountHolder, 
      String? ifsc, 
      String? aadharNumber, 
      String? panNumber, 
      String? idProofName, 
      String? idProofNumber, 
      String? aadharImg, 
      String? panImg, 
      String? signatureImg, 
      String? deletedAt, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userType = userType;
    _role = role;
    _surname = surname;
    _firstName = firstName;
    _lastName = lastName;
    _username = username;
    _password = password;
    _email = email;
    _language = language;
    _emergencynumber = emergencynumber;
    _skilled = skilled;
    _skills = skills;
    _company = company;
    _doj = doj;
    _pf = pf;
    _esic = esic;
    _uan = uan;
    _workingdays = workingdays;
    _shiftTime = shiftTime;
    _perdayspayout = perdayspayout;
    _pfemployeecontribution = pfemployeecontribution;
    _pfemployercontribution = pfemployercontribution;
    _esicemployeecontribution = esicemployeecontribution;
    _esicemployercontribution = esicemployercontribution;
    _designation = designation;
    _department = department;
    _operations = operations;
    _contactNo = contactNo;
    _address = address;
    _rememberToken = rememberToken;
    _businessId = businessId;
    _maxSalesDiscountPercent = maxSalesDiscountPercent;
    _allowLogin = allowLogin;
    _essentialsDepartmentId = essentialsDepartmentId;
    _essentialsDesignationId = essentialsDesignationId;
    _status = status;
    _isCmmsnAgnt = isCmmsnAgnt;
    _cmmsnPercent = cmmsnPercent;
    _selectedContacts = selectedContacts;
    _dob = dob;
    _gender = gender;
    _maritalStatus = maritalStatus;
    _bloodGroup = bloodGroup;
    _contactNumber = contactNumber;
    _fbLink = fbLink;
    _twitterLink = twitterLink;
    _socialMedia1 = socialMedia1;
    _socialMedia2 = socialMedia2;
    _permanentAddress = permanentAddress;
    _pincode = pincode;
    _landmark = landmark;
    _city = city;
    _state = state;
    _currentAddress = currentAddress;
    _guardianName = guardianName;
    _customField1 = customField1;
    _customField2 = customField2;
    _customField3 = customField3;
    _customField4 = customField4;
    _bankDetails = bankDetails;
    _accountNumber = accountNumber;
    _accountHolder = accountHolder;
    _ifsc = ifsc;
    _aadharNumber = aadharNumber;
    _panNumber = panNumber;
    _idProofName = idProofName;
    _idProofNumber = idProofNumber;
    _aadharImg = aadharImg;
    _panImg = panImg;
    _signatureImg = signatureImg;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userType = json['user_type'];
    _role = json['role'];
    _surname = json['surname'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _username = json['username'];
    _password = json['password'];
    _email = json['email'];
    _language = json['language'];
    _emergencynumber = json['emergencynumber'];
    _skilled = json['skilled'];
    _skills = json['skills'];
    _company = json['company'];
    _doj = json['doj'];
    _pf = json['pf'];
    _esic = json['esic'];
    _uan = json['uan'];
    _workingdays = json['workingdays'];
    _shiftTime = json['shift_time'];
    _perdayspayout = json['perdayspayout'];
    _pfemployeecontribution = json['pfemployeecontribution'];
    _pfemployercontribution = json['pfemployercontribution'];
    _esicemployeecontribution = json['esicemployeecontribution'];
    _esicemployercontribution = json['esicemployercontribution'];
    _designation = json['designation'];
    _department = json['department'];
    _operations = json['operations'];
    _contactNo = json['contact_no'];
    _address = json['address'];
    _rememberToken = json['remember_token'];
    _businessId = json['business_id'];
    _maxSalesDiscountPercent = json['max_sales_discount_percent'];
    _allowLogin = json['allow_login'];
    _essentialsDepartmentId = json['essentials_department_id'];
    _essentialsDesignationId = json['essentials_designation_id'];
    _status = json['status'];
    _isCmmsnAgnt = json['is_cmmsn_agnt'];
    _cmmsnPercent = json['cmmsn_percent'];
    _selectedContacts = json['selected_contacts'];
    _dob = json['dob'];
    _gender = json['gender'];
    _maritalStatus = json['marital_status'];
    _bloodGroup = json['blood_group'];
    _contactNumber = json['contact_number'];
    _fbLink = json['fb_link'];
    _twitterLink = json['twitter_link'];
    _socialMedia1 = json['social_media_1'];
    _socialMedia2 = json['social_media_2'];
    _permanentAddress = json['permanent_address'];
    _pincode = json['pincode'];
    _landmark = json['landmark'];
    _city = json['city'];
    _state = json['state'];
    _currentAddress = json['current_address'];
    _guardianName = json['guardian_name'];
    _customField1 = json['custom_field_1'];
    _customField2 = json['custom_field_2'];
    _customField3 = json['custom_field_3'];
    _customField4 = json['custom_field_4'];
    _bankDetails = json['bank_details'];
    _accountNumber = json['account_number'];
    _accountHolder = json['account_holder'];
    _ifsc = json['ifsc'];
    _aadharNumber = json['aadhar_number'];
    _panNumber = json['pan_number'];
    _idProofName = json['id_proof_name'];
    _idProofNumber = json['id_proof_number'];
    _aadharImg = json['aadhar_img'];
    _panImg = json['pan_img'];
    _signatureImg = json['signature_img'];
    _deletedAt = json['deleted_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userType;
  String? _role;
  String? _surname;
  String? _firstName;
  String? _lastName;
  String? _username;
  String? _password;
  String? _email;
  String? _language;
  String? _emergencynumber;
  String? _skilled;
  String? _skills;
  String? _company;
  String? _doj;
  String? _pf;
  String? _esic;
  String? _uan;
  String? _workingdays;
  String? _shiftTime;
  String? _perdayspayout;
  String? _pfemployeecontribution;
  String? _pfemployercontribution;
  String? _esicemployeecontribution;
  String? _esicemployercontribution;
  String? _designation;
  String? _department;
  String? _operations;
  String? _contactNo;
  String? _address;
  String? _rememberToken;
  String? _businessId;
  String? _maxSalesDiscountPercent;
  String? _allowLogin;
  String? _essentialsDepartmentId;
  String? _essentialsDesignationId;
  String? _status;
  String? _isCmmsnAgnt;
  String? _cmmsnPercent;
  String? _selectedContacts;
  String? _dob;
  String? _gender;
  String? _maritalStatus;
  String? _bloodGroup;
  String? _contactNumber;
  String? _fbLink;
  String? _twitterLink;
  String? _socialMedia1;
  String? _socialMedia2;
  String? _permanentAddress;
  String? _pincode;
  String? _landmark;
  String? _city;
  String? _state;
  String? _currentAddress;
  String? _guardianName;
  String? _customField1;
  String? _customField2;
  String? _customField3;
  String? _customField4;
  String? _bankDetails;
  String? _accountNumber;
  String? _accountHolder;
  String? _ifsc;
  String? _aadharNumber;
  String? _panNumber;
  String? _idProofName;
  String? _idProofNumber;
  String? _aadharImg;
  String? _panImg;
  String? _signatureImg;
  String? _deletedAt;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? userType,
  String? role,
  String? surname,
  String? firstName,
  String? lastName,
  String? username,
  String? password,
  String? email,
  String? language,
  String? emergencynumber,
  String? skilled,
  String? skills,
  String? company,
  String? doj,
  String? pf,
  String? esic,
  String? uan,
  String? workingdays,
  String? shiftTime,
  String? perdayspayout,
  String? pfemployeecontribution,
  String? pfemployercontribution,
  String? esicemployeecontribution,
  String? esicemployercontribution,
  String? designation,
  String? department,
  String? operations,
  String? contactNo,
  String? address,
  String? rememberToken,
  String? businessId,
  String? maxSalesDiscountPercent,
  String? allowLogin,
  String? essentialsDepartmentId,
  String? essentialsDesignationId,
  String? status,
  String? isCmmsnAgnt,
  String? cmmsnPercent,
  String? selectedContacts,
  String? dob,
  String? gender,
  String? maritalStatus,
  String? bloodGroup,
  String? contactNumber,
  String? fbLink,
  String? twitterLink,
  String? socialMedia1,
  String? socialMedia2,
  String? permanentAddress,
  String? pincode,
  String? landmark,
  String? city,
  String? state,
  String? currentAddress,
  String? guardianName,
  String? customField1,
  String? customField2,
  String? customField3,
  String? customField4,
  String? bankDetails,
  String? accountNumber,
  String? accountHolder,
  String? ifsc,
  String? aadharNumber,
  String? panNumber,
  String? idProofName,
  String? idProofNumber,
  String? aadharImg,
  String? panImg,
  String? signatureImg,
  String? deletedAt,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  userType: userType ?? _userType,
  role: role ?? _role,
  surname: surname ?? _surname,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  username: username ?? _username,
  password: password ?? _password,
  email: email ?? _email,
  language: language ?? _language,
  emergencynumber: emergencynumber ?? _emergencynumber,
  skilled: skilled ?? _skilled,
  skills: skills ?? _skills,
  company: company ?? _company,
  doj: doj ?? _doj,
  pf: pf ?? _pf,
  esic: esic ?? _esic,
  uan: uan ?? _uan,
  workingdays: workingdays ?? _workingdays,
  shiftTime: shiftTime ?? _shiftTime,
  perdayspayout: perdayspayout ?? _perdayspayout,
  pfemployeecontribution: pfemployeecontribution ?? _pfemployeecontribution,
  pfemployercontribution: pfemployercontribution ?? _pfemployercontribution,
  esicemployeecontribution: esicemployeecontribution ?? _esicemployeecontribution,
  esicemployercontribution: esicemployercontribution ?? _esicemployercontribution,
  designation: designation ?? _designation,
  department: department ?? _department,
  operations: operations ?? _operations,
  contactNo: contactNo ?? _contactNo,
  address: address ?? _address,
  rememberToken: rememberToken ?? _rememberToken,
  businessId: businessId ?? _businessId,
  maxSalesDiscountPercent: maxSalesDiscountPercent ?? _maxSalesDiscountPercent,
  allowLogin: allowLogin ?? _allowLogin,
  essentialsDepartmentId: essentialsDepartmentId ?? _essentialsDepartmentId,
  essentialsDesignationId: essentialsDesignationId ?? _essentialsDesignationId,
  status: status ?? _status,
  isCmmsnAgnt: isCmmsnAgnt ?? _isCmmsnAgnt,
  cmmsnPercent: cmmsnPercent ?? _cmmsnPercent,
  selectedContacts: selectedContacts ?? _selectedContacts,
  dob: dob ?? _dob,
  gender: gender ?? _gender,
  maritalStatus: maritalStatus ?? _maritalStatus,
  bloodGroup: bloodGroup ?? _bloodGroup,
  contactNumber: contactNumber ?? _contactNumber,
  fbLink: fbLink ?? _fbLink,
  twitterLink: twitterLink ?? _twitterLink,
  socialMedia1: socialMedia1 ?? _socialMedia1,
  socialMedia2: socialMedia2 ?? _socialMedia2,
  permanentAddress: permanentAddress ?? _permanentAddress,
  pincode: pincode ?? _pincode,
  landmark: landmark ?? _landmark,
  city: city ?? _city,
  state: state ?? _state,
  currentAddress: currentAddress ?? _currentAddress,
  guardianName: guardianName ?? _guardianName,
  customField1: customField1 ?? _customField1,
  customField2: customField2 ?? _customField2,
  customField3: customField3 ?? _customField3,
  customField4: customField4 ?? _customField4,
  bankDetails: bankDetails ?? _bankDetails,
  accountNumber: accountNumber ?? _accountNumber,
  accountHolder: accountHolder ?? _accountHolder,
  ifsc: ifsc ?? _ifsc,
  aadharNumber: aadharNumber ?? _aadharNumber,
  panNumber: panNumber ?? _panNumber,
  idProofName: idProofName ?? _idProofName,
  idProofNumber: idProofNumber ?? _idProofNumber,
  aadharImg: aadharImg ?? _aadharImg,
  panImg: panImg ?? _panImg,
  signatureImg: signatureImg ?? _signatureImg,
  deletedAt: deletedAt ?? _deletedAt,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get userType => _userType;
  String? get role => _role;
  String? get surname => _surname;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get username => _username;
  String? get password => _password;
  String? get email => _email;
  String? get language => _language;
  String? get emergencynumber => _emergencynumber;
  String? get skilled => _skilled;
  String? get skills => _skills;
  String? get company => _company;
  String? get doj => _doj;
  String? get pf => _pf;
  String? get esic => _esic;
  String? get uan => _uan;
  String? get workingdays => _workingdays;
  String? get shiftTime => _shiftTime;
  String? get perdayspayout => _perdayspayout;
  String? get pfemployeecontribution => _pfemployeecontribution;
  String? get pfemployercontribution => _pfemployercontribution;
  String? get esicemployeecontribution => _esicemployeecontribution;
  String? get esicemployercontribution => _esicemployercontribution;
  String? get designation => _designation;
  String? get department => _department;
  String? get operations => _operations;
  String? get contactNo => _contactNo;
  String? get address => _address;
  String? get rememberToken => _rememberToken;
  String? get businessId => _businessId;
  String? get maxSalesDiscountPercent => _maxSalesDiscountPercent;
  String? get allowLogin => _allowLogin;
  String? get essentialsDepartmentId => _essentialsDepartmentId;
  String? get essentialsDesignationId => _essentialsDesignationId;
  String? get status => _status;
  String? get isCmmsnAgnt => _isCmmsnAgnt;
  String? get cmmsnPercent => _cmmsnPercent;
  String? get selectedContacts => _selectedContacts;
  String? get dob => _dob;
  String? get gender => _gender;
  String? get maritalStatus => _maritalStatus;
  String? get bloodGroup => _bloodGroup;
  String? get contactNumber => _contactNumber;
  String? get fbLink => _fbLink;
  String? get twitterLink => _twitterLink;
  String? get socialMedia1 => _socialMedia1;
  String? get socialMedia2 => _socialMedia2;
  String? get permanentAddress => _permanentAddress;
  String? get pincode => _pincode;
  String? get landmark => _landmark;
  String? get city => _city;
  String? get state => _state;
  String? get currentAddress => _currentAddress;
  String? get guardianName => _guardianName;
  String? get customField1 => _customField1;
  String? get customField2 => _customField2;
  String? get customField3 => _customField3;
  String? get customField4 => _customField4;
  String? get bankDetails => _bankDetails;
  String? get accountNumber => _accountNumber;
  String? get accountHolder => _accountHolder;
  String? get ifsc => _ifsc;
  String? get aadharNumber => _aadharNumber;
  String? get panNumber => _panNumber;
  String? get idProofName => _idProofName;
  String? get idProofNumber => _idProofNumber;
  String? get aadharImg => _aadharImg;
  String? get panImg => _panImg;
  String? get signatureImg => _signatureImg;
  String? get deletedAt => _deletedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_type'] = _userType;
    map['role'] = _role;
    map['surname'] = _surname;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['username'] = _username;
    map['password'] = _password;
    map['email'] = _email;
    map['language'] = _language;
    map['emergencynumber'] = _emergencynumber;
    map['skilled'] = _skilled;
    map['skills'] = _skills;
    map['company'] = _company;
    map['doj'] = _doj;
    map['pf'] = _pf;
    map['esic'] = _esic;
    map['uan'] = _uan;
    map['workingdays'] = _workingdays;
    map['shift_time'] = _shiftTime;
    map['perdayspayout'] = _perdayspayout;
    map['pfemployeecontribution'] = _pfemployeecontribution;
    map['pfemployercontribution'] = _pfemployercontribution;
    map['esicemployeecontribution'] = _esicemployeecontribution;
    map['esicemployercontribution'] = _esicemployercontribution;
    map['designation'] = _designation;
    map['department'] = _department;
    map['operations'] = _operations;
    map['contact_no'] = _contactNo;
    map['address'] = _address;
    map['remember_token'] = _rememberToken;
    map['business_id'] = _businessId;
    map['max_sales_discount_percent'] = _maxSalesDiscountPercent;
    map['allow_login'] = _allowLogin;
    map['essentials_department_id'] = _essentialsDepartmentId;
    map['essentials_designation_id'] = _essentialsDesignationId;
    map['status'] = _status;
    map['is_cmmsn_agnt'] = _isCmmsnAgnt;
    map['cmmsn_percent'] = _cmmsnPercent;
    map['selected_contacts'] = _selectedContacts;
    map['dob'] = _dob;
    map['gender'] = _gender;
    map['marital_status'] = _maritalStatus;
    map['blood_group'] = _bloodGroup;
    map['contact_number'] = _contactNumber;
    map['fb_link'] = _fbLink;
    map['twitter_link'] = _twitterLink;
    map['social_media_1'] = _socialMedia1;
    map['social_media_2'] = _socialMedia2;
    map['permanent_address'] = _permanentAddress;
    map['pincode'] = _pincode;
    map['landmark'] = _landmark;
    map['city'] = _city;
    map['state'] = _state;
    map['current_address'] = _currentAddress;
    map['guardian_name'] = _guardianName;
    map['custom_field_1'] = _customField1;
    map['custom_field_2'] = _customField2;
    map['custom_field_3'] = _customField3;
    map['custom_field_4'] = _customField4;
    map['bank_details'] = _bankDetails;
    map['account_number'] = _accountNumber;
    map['account_holder'] = _accountHolder;
    map['ifsc'] = _ifsc;
    map['aadhar_number'] = _aadharNumber;
    map['pan_number'] = _panNumber;
    map['id_proof_name'] = _idProofName;
    map['id_proof_number'] = _idProofNumber;
    map['aadhar_img'] = _aadharImg;
    map['pan_img'] = _panImg;
    map['signature_img'] = _signatureImg;
    map['deleted_at'] = _deletedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}