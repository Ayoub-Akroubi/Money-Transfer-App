import 'package:flutter/material.dart';

class AgentTransactionPage extends StatelessWidget {
  const AgentTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Accept Transactions'),
              Tab(text: 'Complete Transactions'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AcceptTransactionsTab(),
            CompleteTransactionsTab(),
          ],
        ),
      ),
    );
  }
}

class AcceptTransactionsTab extends StatelessWidget {
  const AcceptTransactionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Pending Transactions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Transaction #$index'),
                subtitle: const Text('Amount: 100.00 MAD'),
                trailing: IconButton(
                  icon: const Icon(Icons.check, color: Colors.green),
                  onPressed: () {
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CompleteTransactionsTab extends StatelessWidget {
  const CompleteTransactionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Completed Transactions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Transaction #$index'),
                subtitle: const Text('Amount: \$100'),
                trailing: const Icon(Icons.check_circle, color: Colors.green),
                onTap: () {
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
