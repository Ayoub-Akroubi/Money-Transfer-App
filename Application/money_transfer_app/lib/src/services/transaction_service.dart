import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfer_app/src/constants/app_config.dart';
import 'package:money_transfer_app/src/models/transaction_response.dart';

class TransferService {

  Future<List?> getAllTransactions(String token) async{
    const url = '${AppConfig.baseUrl}/initiateTransfer';
    final headers = {
      'Content-Type': 'application/json',
      'authorization': token,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List responseData = jsonDecode(response.body);
        return responseData;
      } else {
        if (kDebugMode) {
          print('No transactions found');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during fetching transactions: $e');
      }
      return null;
    }

  }

  Future<TransactionResponse?> initiateTransfer({
    required int fromAccountId,
    required int toAccountId,
    required int agentId,
    required double amount,
    required String token, 
  }) async {
    const url = '${AppConfig.baseUrl}/initiateTransfer';
    final headers = {
      'Content-Type': 'application/json',
      'authorization': token,
    };

    final body = jsonEncode({
      'fromAccountId': fromAccountId,
      'toAccountId': toAccountId,
      'agentId': agentId,
      'amount': amount,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return TransactionResponse.fromJson(responseData);
      } else {
        if (kDebugMode) {
          print('Failed to initiate transfer: ${response.statusCode} ${response.body}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during transfer: $e');
      }
      return null;
    }
  }
}
