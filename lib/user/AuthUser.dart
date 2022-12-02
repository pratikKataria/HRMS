import 'dart:convert';

import 'package:hrms/logging/simple_log.dart';
import 'package:hrms/res/keys.dart';
import 'package:hrms/util/shared_manager.dart';

import 'CurrentUser.dart';

/// Created by Pratik Kataria on 04-03-2021.

class AuthUser {
  var tag = 'AuthUser';
  static AuthUser _instance = AuthUser.internal();

  AuthUser.internal();

  factory AuthUser() {
    return _instance;
  }

  static AuthUser getInstance() {
    if (_instance == null) {
      _instance = AuthUser.internal();
    }
    return _instance;
  }

  void loginUser(String response) {}

  Future<void> login(CurrentUser userModel) async {
    userModel.isLoggedIn = true;
    SimpleLogger.debug(AuthUser, userModel.toMap());
    await SharedManager.setStringPreference(SharedPrefsKeys.kUserModel, json.encode(userModel.toMap()));
  }

  Future<void> saveToken(CurrentUser userModel) async {
    SimpleLogger.debug(AuthUser, userModel.toMap());
    await SharedManager.setStringPreference(SharedPrefsKeys.kUserModel, json.encode(userModel.toMap()));
  }

  Future<void> logout() async {
    await SharedManager.setStringPreference(SharedPrefsKeys.kUserModel, "");
    // final GoogleSignIn _googleSignIn = new GoogleSignIn();
    // await _googleSignIn.signOut();
  }

  Future<void> updateUser(CurrentUser currentUser) async {
    await SharedManager.setStringPreference(SharedPrefsKeys.kUserModel, json.encode(currentUser.toMap()));
  }

  Future<CurrentUser> getCurrentUser() async {
    String userModel = await SharedManager.getStringPreference(SharedPrefsKeys.kUserModel);
    SimpleLogger.debug(AuthUser, userModel);
    CurrentUser user = CurrentUser();
    if (userModel.isNotEmpty) {
      user = CurrentUser.fromMap(jsonDecode(userModel));
      return user;
    }
    return user;
  }

  // Future<String?> get uid async => (await getCurrentUser()).userCredentials.accountId;

  Future<bool> isLoggedIn() async {
    CurrentUser userModel = await getCurrentUser();
    print('insize not null');
    SimpleLogger.debug(AuthUser, userModel.toMap());
    return userModel.isLoggedIn;
  }

  Future<String> token() async {
    CurrentUser userModel = await getCurrentUser();
     SimpleLogger.debug(AuthUser, userModel.toMap());
    return 'Bearer $token';
  }

/*  Future<bool> hasToken() async {
    CurrentUser userModel = await getCurrentUser();
     // print('token $token');
    return token.isEmpty;
  }*/
}
