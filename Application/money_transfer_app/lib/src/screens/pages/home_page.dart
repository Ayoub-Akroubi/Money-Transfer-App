import 'package:flutter/material.dart';
import 'package:money_transfer_app/src/providers/userProvider.dart';
import 'package:money_transfer_app/src/services/account_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> transactions = [
    Transaction(title: 'Dribbble', date: '13 Jan 2022', amount: -100.24),
    Transaction(title: 'Asana', date: '13 Jan 2022', amount: -32.24),
    Transaction(title: 'Dribbble', date: '12 Jan 2022', amount: -100.24),
  ];

  double? balance;

  @override
  void initState() {
    super.initState();
    _fetchBalance();
  }

  Future<void> _fetchBalance() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      final accountService = AccountService();
      final fetchedBalance =
          await accountService.getBalance(user.userId, user.token);
      setState(() {
        balance = fetchedBalance;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  user != null ? 'Welcome, User ID: ${user.userId}' : 'Welcome',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFAB47BC), Color(0xFF7B1FA2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      balance != null
                          ? '${balance!.toStringAsFixed(2)} MAD'
                          : 'Loading...',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 5),
                        color: Colors.indigo.withOpacity(.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.purple,
                            child: Icon(Icons.payment, color: Colors.white),
                          ),
                          title: Text(
                            transaction.title,
                            style: const TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(
                            transaction.date,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Text(
                            '${transaction.amount.toStringAsFixed(2)} MAD',
                            style: TextStyle(
                              color: transaction.amount < 0
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Transaction {
  final String title;
  final String date;
  final double amount;

  Transaction({required this.title, required this.date, required this.amount});
}
