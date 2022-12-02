/// first_name : "pradeep"
/// last_name : "soni"
/// contact_no : "9856895698"
/// emergencynumber : "8855885585"
/// email : "test1212@gmail.com"
/// password : "123456"
/// gender : "m"
/// dob : "1990-12-12"
/// permanent_address : "indore"
/// pincode : "452001"
/// landmark : "indore"
/// city : "indore"
/// skilled : "1"
/// skills : "php,html"
/// company : "digitaltaken"
/// department : "it"
/// designation : "manager"
/// operations : "manager"
/// doj : "2020-12-12"
/// workingdays : "26"
/// shift_time : "day"
/// perdayspayout : "40000"
/// pf : "1"
/// esic : "1"
/// uan : "1212"
/// pfemployeecontribution : "1"
/// pfemployercontribution : "1"
/// esicemployeecontribution : "1"
/// esicemployercontribution : "1"
/// account_number : "767676"
/// account_holder : "test"
/// ifsc : "test123"
/// aadhar_number : "123123123123"
/// aadhar_img : "img.jpg"
/// pan_number : "img.jpg"
/// pan_img : "img.jpg"
/// signature_img : "img.jpg"
/// business_id : "12"
/// Register : "Register"

class AddEmployeeRequest {
  AddEmployeeRequest({
      String? firstName, 
      String? lastName, 
      String? contactNo, 
      String? emergencynumber, 
      String? email, 
      String? password, 
      String? gender, 
      String? dob, 
      String? permanentAddress, 
      String? pincode, 
      String? landmark, 
      String? city, 
      String? skilled, 
      String? skills, 
      String? company, 
      String? department, 
      String? designation, 
      String? operations, 
      String? doj, 
      String? workingdays, 
      String? shiftTime, 
      String? perdayspayout, 
      String? pf, 
      String? esic, 
      String? uan, 
      String? pfemployeecontribution, 
      String? pfemployercontribution, 
      String? esicemployeecontribution, 
      String? esicemployercontribution, 
      String? accountNumber, 
      String? accountHolder, 
      String? ifsc, 
      String? aadharNumber, 
      String? aadharImg, 
      String? panNumber, 
      String? panImg, 
      String? signatureImg, 
      String? businessId, 
      String? register,}){
    _firstName = firstName;
    _lastName = lastName;
    _contactNo = contactNo;
    _emergencynumber = emergencynumber;
    _email = email;
    _password = password;
    _gender = gender;
    _dob = dob;
    _permanentAddress = permanentAddress;
    _pincode = pincode;
    _landmark = landmark;
    _city = city;
    _skilled = skilled;
    _skills = skills;
    _company = company;
    _department = department;
    _designation = designation;
    _operations = operations;
    _doj = doj;
    _workingdays = workingdays;
    _shiftTime = shiftTime;
    _perdayspayout = perdayspayout;
    _pf = pf;
    _esic = esic;
    _uan = uan;
    _pfemployeecontribution = pfemployeecontribution;
    _pfemployercontribution = pfemployercontribution;
    _esicemployeecontribution = esicemployeecontribution;
    _esicemployercontribution = esicemployercontribution;
    _accountNumber = accountNumber;
    _accountHolder = accountHolder;
    _ifsc = ifsc;
    _aadharNumber = aadharNumber;
    _aadharImg = aadharImg;
    _panNumber = panNumber;
    _panImg = panImg;
    _signatureImg = signatureImg;
    _businessId = businessId;
    _register = register;
}

  AddEmployeeRequest.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _contactNo = json['contact_no'];
    _emergencynumber = json['emergencynumber'];
    _email = json['email'];
    _password = json['password'];
    _gender = json['gender'];
    _dob = json['dob'];
    _permanentAddress = json['permanent_address'];
    _pincode = json['pincode'];
    _landmark = json['landmark'];
    _city = json['city'];
    _skilled = json['skilled'];
    _skills = json['skills'];
    _company = json['company'];
    _department = json['department'];
    _designation = json['designation'];
    _operations = json['operations'];
    _doj = json['doj'];
    _workingdays = json['workingdays'];
    _shiftTime = json['shift_time'];
    _perdayspayout = json['perdayspayout'];
    _pf = json['pf'];
    _esic = json['esic'];
    _uan = json['uan'];
    _pfemployeecontribution = json['pfemployeecontribution'];
    _pfemployercontribution = json['pfemployercontribution'];
    _esicemployeecontribution = json['esicemployeecontribution'];
    _esicemployercontribution = json['esicemployercontribution'];
    _accountNumber = json['account_number'];
    _accountHolder = json['account_holder'];
    _ifsc = json['ifsc'];
    _aadharNumber = json['aadhar_number'];
    _aadharImg = json['aadhar_img'];
    _panNumber = json['pan_number'];
    _panImg = json['pan_img'];
    _signatureImg = json['signature_img'];
    _businessId = json['business_id'];
    _register = json['Register'];
  }
  String? _firstName;
  String? _lastName;
  String? _contactNo;
  String? _emergencynumber;
  String? _email;
  String? _password;
  String? _gender;
  String? _dob;
  String? _permanentAddress;
  String? _pincode;
  String? _landmark;
  String? _city;
  String? _skilled;
  String? _skills;
  String? _company;
  String? _department;
  String? _designation;
  String? _operations;
  String? _doj;
  String? _workingdays;
  String? _shiftTime;
  String? _perdayspayout;
  String? _pf;
  String? _esic;
  String? _uan;
  String? _pfemployeecontribution;
  String? _pfemployercontribution;
  String? _esicemployeecontribution;
  String? _esicemployercontribution;
  String? _accountNumber;
  String? _accountHolder;
  String? _ifsc;
  String? _aadharNumber;
  String? _aadharImg;
  String? _panNumber;
  String? _panImg;
  String? _signatureImg;
  String? _businessId;
  String? _register;
AddEmployeeRequest copyWith({  String? firstName,
  String? lastName,
  String? contactNo,
  String? emergencynumber,
  String? email,
  String? password,
  String? gender,
  String? dob,
  String? permanentAddress,
  String? pincode,
  String? landmark,
  String? city,
  String? skilled,
  String? skills,
  String? company,
  String? department,
  String? designation,
  String? operations,
  String? doj,
  String? workingdays,
  String? shiftTime,
  String? perdayspayout,
  String? pf,
  String? esic,
  String? uan,
  String? pfemployeecontribution,
  String? pfemployercontribution,
  String? esicemployeecontribution,
  String? esicemployercontribution,
  String? accountNumber,
  String? accountHolder,
  String? ifsc,
  String? aadharNumber,
  String? aadharImg,
  String? panNumber,
  String? panImg,
  String? signatureImg,
  String? businessId,
  String? register,
}) => AddEmployeeRequest(  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  contactNo: contactNo ?? _contactNo,
  emergencynumber: emergencynumber ?? _emergencynumber,
  email: email ?? _email,
  password: password ?? _password,
  gender: gender ?? _gender,
  dob: dob ?? _dob,
  permanentAddress: permanentAddress ?? _permanentAddress,
  pincode: pincode ?? _pincode,
  landmark: landmark ?? _landmark,
  city: city ?? _city,
  skilled: skilled ?? _skilled,
  skills: skills ?? _skills,
  company: company ?? _company,
  department: department ?? _department,
  designation: designation ?? _designation,
  operations: operations ?? _operations,
  doj: doj ?? _doj,
  workingdays: workingdays ?? _workingdays,
  shiftTime: shiftTime ?? _shiftTime,
  perdayspayout: perdayspayout ?? _perdayspayout,
  pf: pf ?? _pf,
  esic: esic ?? _esic,
  uan: uan ?? _uan,
  pfemployeecontribution: pfemployeecontribution ?? _pfemployeecontribution,
  pfemployercontribution: pfemployercontribution ?? _pfemployercontribution,
  esicemployeecontribution: esicemployeecontribution ?? _esicemployeecontribution,
  esicemployercontribution: esicemployercontribution ?? _esicemployercontribution,
  accountNumber: accountNumber ?? _accountNumber,
  accountHolder: accountHolder ?? _accountHolder,
  ifsc: ifsc ?? _ifsc,
  aadharNumber: aadharNumber ?? _aadharNumber,
  aadharImg: aadharImg ?? _aadharImg,
  panNumber: panNumber ?? _panNumber,
  panImg: panImg ?? _panImg,
  signatureImg: signatureImg ?? _signatureImg,
  businessId: businessId ?? _businessId,
  register: register ?? _register,
);
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get contactNo => _contactNo;
  String? get emergencynumber => _emergencynumber;
  String? get email => _email;
  String? get password => _password;
  String? get gender => _gender;
  String? get dob => _dob;
  String? get permanentAddress => _permanentAddress;
  String? get pincode => _pincode;
  String? get landmark => _landmark;
  String? get city => _city;
  String? get skilled => _skilled;
  String? get skills => _skills;
  String? get company => _company;
  String? get department => _department;
  String? get designation => _designation;
  String? get operations => _operations;
  String? get doj => _doj;
  String? get workingdays => _workingdays;
  String? get shiftTime => _shiftTime;
  String? get perdayspayout => _perdayspayout;
  String? get pf => _pf;
  String? get esic => _esic;
  String? get uan => _uan;
  String? get pfemployeecontribution => _pfemployeecontribution;
  String? get pfemployercontribution => _pfemployercontribution;
  String? get esicemployeecontribution => _esicemployeecontribution;
  String? get esicemployercontribution => _esicemployercontribution;
  String? get accountNumber => _accountNumber;
  String? get accountHolder => _accountHolder;
  String? get ifsc => _ifsc;
  String? get aadharNumber => _aadharNumber;
  String? get aadharImg => _aadharImg;
  String? get panNumber => _panNumber;
  String? get panImg => _panImg;
  String? get signatureImg => _signatureImg;
  String? get businessId => _businessId;
  String? get register => _register;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['contact_no'] = _contactNo;
    map['emergencynumber'] = _emergencynumber;
    map['email'] = _email;
    map['password'] = _password;
    map['gender'] = _gender;
    map['dob'] = _dob;
    map['permanent_address'] = _permanentAddress;
    map['pincode'] = _pincode;
    map['landmark'] = _landmark;
    map['city'] = _city;
    map['skilled'] = _skilled;
    map['skills'] = _skills;
    map['company'] = _company;
    map['department'] = _department;
    map['designation'] = _designation;
    map['operations'] = _operations;
    map['doj'] = _doj;
    map['workingdays'] = _workingdays;
    map['shift_time'] = _shiftTime;
    map['perdayspayout'] = _perdayspayout;
    map['pf'] = _pf;
    map['esic'] = _esic;
    map['uan'] = _uan;
    map['pfemployeecontribution'] = _pfemployeecontribution;
    map['pfemployercontribution'] = _pfemployercontribution;
    map['esicemployeecontribution'] = _esicemployeecontribution;
    map['esicemployercontribution'] = _esicemployercontribution;
    map['account_number'] = _accountNumber;
    map['account_holder'] = _accountHolder;
    map['ifsc'] = _ifsc;
    map['aadhar_number'] = _aadharNumber;
    map['aadhar_img'] = _aadharImg;
    map['pan_number'] = _panNumber;
    map['pan_img'] = _panImg;
    map['signature_img'] = _signatureImg;
    map['business_id'] = _businessId;
    map['Register'] = _register;
    return map;
  }

}