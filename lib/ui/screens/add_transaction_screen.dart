import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/transaction_model.dart';
import '../../providers/transaction_provider.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();
  final _amountController = TextEditingController();
  String _type = 'credit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _type,
                onChanged: (val) => setState(() => _type = val!),
                items: const [
                  DropdownMenuItem(value: 'credit', child: Text("Credit")),
                  DropdownMenuItem(value: 'debit', child: Text("Debit")),
                ],
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Enter amount" : null,
              ),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: "Note"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final tx = TransactionModel(
                      id: const Uuid().v4(),
                      type: _type,
                      amount: double.parse(_amountController.text),
                      note: _noteController.text,
                      date: DateTime.now(),
                    );
                    ref.read(transactionProvider.notifier).add(tx);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}