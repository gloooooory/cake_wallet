import 'package:cw_core/transaction_direction.dart';
import 'package:cw_core/keyable.dart';

abstract class TransactionInfo extends Object with Keyable {
  late String id;
  late String txhash = id;
  late int amount;
  int? fee;
  late TransactionDirection direction;
  late bool isPending;
  late DateTime date;
  late int height;
  late int confirmations;
  String amountFormatted();
  String fiatAmount();
  String? feeFormatted();
  void changeFiatAmount(String amount);
  String? to;
  String? from;
  String? evmSignatureName;
  List<String>? inputAddresses;
  List<String>? outputAddresses;

  @override
  dynamic get keyIndex => id;

  late Map<String, dynamic> additionalInfo;
}