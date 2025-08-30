import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/db/db_service.dart';
import '../data/models/transaction_model.dart';

final transactionProvider = StateNotifierProvider<TransactionNotifier, List<TransactionModel>>((ref) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<List<TransactionModel>> {
  TransactionNotifier() : super(DBService.getTransactions());

  void add(TransactionModel tx) {
    DBService.addTransaction(tx);
    state = DBService.getTransactions();
  }

  void remove(String id) {
    DBService.deleteTransaction(id);
    state = DBService.getTransactions();
  }
}