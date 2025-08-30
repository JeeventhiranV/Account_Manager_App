import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String note;

  @HiveField(4)
  DateTime date;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.note,
    required this.date,
  });
}