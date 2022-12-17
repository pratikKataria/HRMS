/// Register : "Register"
/// client_name : "VIPU HOSPITAL"
/// registration_date : "2023-01-01"
/// gstin : "GST457845"
/// contact_person : "Mr. Pawan ji"
/// contact_person_mobile : "9858598569"
/// contact_person_email : "vipu@hospitalcom"
/// full_address : "Indore m.p."
/// pincode : "452011"
/// landmark : "Vijay Nager Sq."
/// city : "Indore"
/// skilled : "1"
/// employees : "12,13,14,15"
/// account_number : "784587458745"
/// ifsc : "SBIN003525"
/// aadhar : "154258569512"
/// aadhar_image : "1"
/// pan : "POD4512PD"
/// pan_img : "1"

class AddClientRequest {
  String? state;
  AddClientRequest({
    String? register,
    String? clientName,
    String? registrationDate,
    String? gstin,
    String? contactPerson,
    String? contactPersonMobile,
    String? contactPersonEmail,
    String? fullAddress,
    String? pincode,
    String? landmark,
    String? city,
    String? skilled,
    String? employees,
    String? accountNumber,
    String? ifsc,
    String? aadhar,
    String? aadharImage,
    String? pan,
    String? panImg,
  }) {
    _register = register;
    _clientName = clientName;
    _registrationDate = registrationDate;
    _gstin = gstin;
    _contactPerson = contactPerson;
    _contactPersonMobile = contactPersonMobile;
    _contactPersonEmail = contactPersonEmail;
    _fullAddress = fullAddress;
    _pincode = pincode;
    _landmark = landmark;
    _city = city;
    _skilled = skilled;
    _employees = employees;
    _accountNumber = accountNumber;
    _ifsc = ifsc;
    _aadhar = aadhar;
    _aadharImage = aadharImage;
    _pan = pan;
    _panImg = panImg;
  }

  AddClientRequest.fromJson(dynamic json) {
    _register = json['Register'];
    _clientName = json['client_name'];
    _registrationDate = json['registration_date'];
    _gstin = json['gstin'];
    _contactPerson = json['contact_person'];
    _contactPersonMobile = json['contact_person_mobile'];
    _contactPersonEmail = json['contact_person_email'];
    _fullAddress = json['full_address'];
    _pincode = json['pincode'];
    _landmark = json['landmark'];
    _city = json['city'];
    _skilled = json['skilled'];
    _employees = json['employees'];
    _accountNumber = json['account_number'];
    _ifsc = json['ifsc'];
    _aadhar = json['aadhar'];
    _aadharImage = json['aadhar_image'];
    _pan = json['pan'];
    _panImg = json['pan_img'];
  }
  String? _register;
  String? _clientName;
  String? _registrationDate;
  String? _gstin;
  String? _contactPerson;
  String? _contactPersonMobile;
  String? _contactPersonEmail;
  String? _fullAddress;
  String? _pincode;
  String? _landmark;
  String? _city;
  String? _skilled;
  String? _employees;
  String? _accountNumber;
  String? _ifsc;
  String? _aadhar;
  String? _aadharImage;
  String? _pan;
  String? _panImg;

  AddClientRequest copyWith({
    String? register,
    String? clientName,
    String? registrationDate,
    String? gstin,
    String? contactPerson,
    String? contactPersonMobile,
    String? contactPersonEmail,
    String? fullAddress,
    String? pincode,
    String? landmark,
    String? city,
    String? skilled,
    String? employees,
    String? accountNumber,
    String? ifsc,
    String? aadhar,
    String? aadharImage,
    String? pan,
    String? panImg,
  }) =>
      AddClientRequest(
        register: register ?? _register,
        clientName: clientName ?? _clientName,
        registrationDate: registrationDate ?? _registrationDate,
        gstin: gstin ?? _gstin,
        contactPerson: contactPerson ?? _contactPerson,
        contactPersonMobile: contactPersonMobile ?? _contactPersonMobile,
        contactPersonEmail: contactPersonEmail ?? _contactPersonEmail,
        fullAddress: fullAddress ?? _fullAddress,
        pincode: pincode ?? _pincode,
        landmark: landmark ?? _landmark,
        city: city ?? _city,
        skilled: skilled ?? _skilled,
        employees: employees ?? _employees,
        accountNumber: accountNumber ?? _accountNumber,
        ifsc: ifsc ?? _ifsc,
        aadhar: aadhar ?? _aadhar,
        aadharImage: aadharImage ?? _aadharImage,
        pan: pan ?? _pan,
        panImg: panImg ?? _panImg,
      );
  String? get register => _register;
  String? get clientName => _clientName;
  String? get registrationDate => _registrationDate;
  String? get gstin => _gstin;
  String? get contactPerson => _contactPerson;
  String? get contactPersonMobile => _contactPersonMobile;
  String? get contactPersonEmail => _contactPersonEmail;
  String? get fullAddress => _fullAddress;
  String? get pincode => _pincode;
  String? get landmark => _landmark;
  String? get city => _city;
  String? get skilled => _skilled;
  String? get employees => _employees;
  String? get accountNumber => _accountNumber;
  String? get ifsc => _ifsc;
  String? get aadhar => _aadhar;
  String? get aadharImage => _aadharImage;
  String? get pan => _pan;
  String? get panImg => _panImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Register'] = "Register";
    map['client_name'] = _clientName;
    map['registration_date'] = _registrationDate;
    map['gstin'] = _gstin;
    map['contact_person'] = _contactPerson;
    map['contact_person_mobile'] = _contactPersonMobile;
    map['contact_person_email'] = _contactPersonEmail;
    map['full_address'] = _fullAddress;
    map['pincode'] = _pincode;
    map['landmark'] = _landmark;
    map['city'] = _city;
    map['skilled'] = _skilled;
    map['employees'] = _employees;
    map['account_number'] = _accountNumber;
    map['ifsc'] = _ifsc;
    map['aadhar'] = _aadhar;
    map['aadhar_image'] = _aadharImage;
    map['pan'] = _pan;
    map['pan_img'] = _panImg;
    map['state'] = state;
    return map;
  }

  set panImg(String? value) {
    _panImg = value;
  }

  set pan(String? value) {
    _pan = value;
  }

  set aadharImage(String? value) {
    _aadharImage = value;
  }

  set aadhar(String? value) {
    _aadhar = value;
  }

  set ifsc(String? value) {
    _ifsc = value;
  }

  set accountNumber(String? value) {
    _accountNumber = value;
  }

  set employees(String? value) {
    _employees = value;
  }

  set skilled(String? value) {
    _skilled = value;
  }

  set city(String? value) {
    _city = value;
  }

  set landmark(String? value) {
    _landmark = value;
  }

  set pincode(String? value) {
    _pincode = value;
  }

  set fullAddress(String? value) {
    _fullAddress = value;
  }

  set contactPersonEmail(String? value) {
    _contactPersonEmail = value;
  }

  set contactPersonMobile(String? value) {
    _contactPersonMobile = value;
  }

  set contactPerson(String? value) {
    _contactPerson = value;
  }

  set gstin(String? value) {
    _gstin = value;
  }

  set registrationDate(String? value) {
    _registrationDate = value;
  }

  set clientName(String? value) {
    _clientName = value;
  }

  set register(String? value) {
    _register = value;
  }
}