// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:money_transfer_app/src/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

   void updateUserRole(String newRole) {
    if (_user != null) {
      _user = _user!.copyWith(role: newRole);
      notifyListeners();
    }
  }
}