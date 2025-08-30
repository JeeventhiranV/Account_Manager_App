import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../models/transaction_model.dart';

class DBService {
  static const String boxName = 'transactions';

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(TransactionModelAdapter());
    await Hive.openBox<TransactionModel>(boxName);
  }

  static Box<TransactionModel> get box => Hive.box<TransactionModel>(boxName);

  static Future<void> addTransaction(TransactionModel tx) async {
    await box.put(tx.id, tx);
  }

  static List<TransactionModel> getTransactions() {
    return box.values.toList();
  }

  static Future<void> deleteTransaction(String id) async {
    await box.delete(id);
  }
}