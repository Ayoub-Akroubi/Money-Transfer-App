import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfer_app/src/constants/app_config.dart';
import 'package:money_transfer_app/src/models/user_registration_model.dart';
import '../models/user_model.dart';

class AuthService {
  Future<UserModel?> login(String email, String password) async {
    const loginUrl = '${AppConfig.baseUrl}/login';
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return UserModel.fromJson(json);
      } else {
        if (kDebugMode) {
          print('Failed to login: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception occurred: $e');
      }
      return null;
    }
  }

  Future<void> registerUser(UserRegistrationModel user) async {
    const registerUrl = '${AppConfig.baseUrl}/register';

    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode(user.toJson());

    try {
      final response =
          await http.post(Uri.parse(registerUrl), headers: headers, body: body);

      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('User registered successfully');
        }
      } else {
        if (kDebugMode) {
          print('Failed to register user: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred while registering user: $e');
      }
    }
  }
}
