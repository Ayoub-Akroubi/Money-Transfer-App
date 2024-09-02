// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_transfer_app/src/models/transaction_response.dart';
import 'package:money_transfer_app/src/providers/userProvider.dart';
import 'package:money_transfer_app/src/services/transaction_service.dart';
import 'package:money_transfer_app/src/widgets/input_field.dart';
import 'package:provider/provider.dart';

class SenderTransactionPage extends StatefulWidget {
  const SenderTransactionPage({super.key});

  @override
  State<SenderTransactionPage> createState() => _SenderTransactionPageState();
}

class _SenderTransactionPageState extends State<SenderTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final receverIDController = TextEditingController();
  final agentIDController = TextEditingController();
  final amountController = TextEditingController();
  final TransferService _transferService = TransferService();


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                const Text(
                  'Create a New Transaction',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputField(
                        controller: receverIDController,
                        hintText: 'Receiver ID',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter the Receiver ID'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: agentIDController,
                        hintText: 'Agent ID',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter Agent ID'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: amountController,
                        hintText: 'Amount',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          final double? amount = double.tryParse(value);
                          if (amount == null) {
                            return 'Please enter a valid number';
                          } else if (amount <= 0) {
                            return 'Amount should be positive';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final receverID = int.parse(receverIDController.text);
                              final amount = double.parse(amountController.text);
                              final agentID = int.parse(agentIDController.text);
                              final senderId = user!.userId ;
                              TransactionResponse? transaction = await _transferService.initiateTransfer(
                                  fromAccountId: senderId,
                                  toAccountId: receverID,
                                  amount: amount,
                                  token: user.token,
                                  agentId: agentID);
                        
                                  if (transaction != null) {
                        
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Transaction initiated successfully')),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Error initiating transaction')),
                                    );
                                  }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Submit Transaction',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
