import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/transaction_provider.dart';
import '../../data/models/transaction_model.dart';
import 'add_transaction_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);
    final total = transactions.fold<double>(0, (sum, t) {
      return t.type == 'credit' ? sum + t.amount : sum - t.amount;
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Account Manager")),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: const Text("Total Balance"),
              subtitle: Text("₹${total.toStringAsFixed(2)}"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return ListTile(
                  leading: Icon(
                    tx.type == 'credit' ? Icons.arrow_downward : Icons.arrow_upward,
                    color: tx.type == 'credit' ? Colors.green : Colors.red,
                  ),
                  title: Text("${tx.note} - ₹${tx.amount}"),
                  subtitle: Text(tx.date.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => ref.read(transactionProvider.notifier).remove(tx.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
        ),
      ),
    );
  }
}