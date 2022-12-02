
import 'package:hrms/ui/login/login_response.dart';

class CurrentUser {
  LoginResponse? _userCredentials;
  bool _isLoggedIn = false;

  CurrentUser({
    LoginResponse? userCredentials,
    bool? isLoggedIn,
  })  : _userCredentials = userCredentials,
        _isLoggedIn = isLoggedIn ?? false;

  bool get isLoggedIn => _isLoggedIn;

  LoginResponse get userCredentials => _userCredentials ?? LoginResponse();


  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    return CurrentUser(
        // userCredentials: LoginResponse.fromJson(map['_userCredentials']),
        isLoggedIn: map['isLogin']);
  }

  Map<String, dynamic> toMap() {
    return {
      '_userCredentials': this.userCredentials.toJson(),
      'isLogin': this.isLoggedIn,
    };
  }

  set userCredentials(LoginResponse value) {
    _userCredentials = value;
  }

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
  }
}
