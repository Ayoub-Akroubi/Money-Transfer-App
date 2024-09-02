import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfer_app/src/constants/app_config.dart';

class AccountService {
  Future<double?> getBalance(int userId, String? token) async {
    final balanceUrl = '${AppConfig.baseUrl}/getBalance/?userId=$userId';

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "$token",
    };

    try {
      final response = await http.get(
        Uri.parse(balanceUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        final balance = responseData['balance'];
        return double.parse(balance);
      } else if (response.statusCode == 404) {
        if (kDebugMode) {
          print('Account not found');
        }
        return null;
      } else {
        if (kDebugMode) {
          print('Failed to retrieve balance: ${response.body}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred while retrieving balance: $e');
      }
    }
    return null;
  }
}
