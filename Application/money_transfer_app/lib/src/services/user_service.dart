import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_transfer_app/src/constants/app_config.dart';

class UserService {
  Future<Map<String, dynamic>> switchRole({
    required String newRole,
    required String token,
  }) async {
    const url = '${AppConfig.baseUrl}/switchRole';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({
        'newRole': newRole,
      }),
    );

    if (response.statusCode == 200) {
      return {'success': true, 'message': jsonDecode(response.body)['message']};
    } else {
      return {
        'success': false,
        'message': jsonDecode(response.body)['message']
      };
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String name,
    required String phoneNumber,
    required String address,
  }) async {
    const updateProfileUrl = '${AppConfig.baseUrl}/updateProfile';

    final headers = {
      "Content-Type": "application/json",
      "Authorization": token,
    };

    final body = jsonEncode({
      "name": name,
      "phoneNumber": phoneNumber,
      "address": address,
    });

    try {
      final response = await http.put(
        Uri.parse(updateProfileUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": jsonDecode(response.body)['message']};
      }
    } catch (e) {
      return {"success": false, "message": "An error occurred: $e"};
    }
  }
}
