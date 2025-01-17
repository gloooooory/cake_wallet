import 'package:cw_core/transaction_info.dart';
import 'package:cw_core/wownero_amount_format.dart';
import 'package:cw_wownero/api/structs/transaction_info_row.dart';
import 'package:cw_core/parseBoolFromString.dart';
import 'package:cw_core/transaction_direction.dart';
import 'package:cw_core/format_amount.dart';
import 'package:cw_wownero/api/transaction_history.dart';

class WowneroTransactionInfo extends TransactionInfo {
  WowneroTransactionInfo(this.txhash, this.height, this.direction, this.date,
      this.isPending, this.amount, this.accountIndex, this.addressIndex, this.fee,
      this.confirmations) :
      id = "${txhash}_${amount}_${accountIndex}_${addressIndex}";

  WowneroTransactionInfo.fromMap(Map<String, Object?> map)
      : id = "${map['hash']}_${map['amount']}_${map['accountIndex']}_${map['addressIndex']}",
        txhash = map['hash'] as String,
        height = (map['height'] ?? 0) as int,
        direction = map['direction'] != null
            ? parseTransactionDirectionFromNumber(map['direction'] as String)
            : TransactionDirection.incoming,
        date = DateTime.fromMillisecondsSinceEpoch(
            (int.tryParse(map['timestamp'] as String? ?? '') ?? 0) * 1000),
        isPending = parseBoolFromString(map['isPending'] as String),
        amount = map['amount'] as int,
        accountIndex = int.parse(map['accountIndex'] as String),
        addressIndex = map['addressIndex'] as int,
        confirmations = map['confirmations'] as int,
        key = getTxKey((map['hash'] ?? '') as String),
        fee = map['fee'] as int? ?? 0 {
          additionalInfo = <String, dynamic>{
            'key': key,
            'accountIndex': accountIndex,
            'addressIndex': addressIndex
          };
        }

  WowneroTransactionInfo.fromRow(TransactionInfoRow row)
      : id = "${row.getHash()}_${row.getAmount()}_${row.subaddrAccount}_${row.subaddrIndex}",
        txhash = row.getHash(),
        height = row.blockHeight,
        direction = parseTransactionDirectionFromInt(row.direction),
        date = DateTime.fromMillisecondsSinceEpoch(row.getDatetime() * 1000),
        isPending = row.isPending != 0,
        amount = row.getAmount(),
        accountIndex = row.subaddrAccount,
        addressIndex = row.subaddrIndex,
        confirmations = row.confirmations,
        key = getTxKey(row.getHash()),
        fee = row.fee {
          additionalInfo = <String, dynamic>{
            'key': key,
            'accountIndex': accountIndex,
            'addressIndex': addressIndex
          };
        }

  final String id;
  final String txhash;
  final int height;
  final TransactionDirection direction;
  final DateTime date;
  final int accountIndex;
  final bool isPending;
  final int amount;
  final int fee;
  final int addressIndex;
  final int confirmations;
  String? recipientAddress;
  String? key;
  String? _fiatAmount;

  @override
  String amountFormatted() => '${formatAmount(wowneroAmountToString(amount: amount))} WOW';

  @override
  String fiatAmount() => _fiatAmount ?? '';

  @override
  void changeFiatAmount(String amount) => _fiatAmount = formatAmount(amount);

  @override
  String feeFormatted() => '${formatAmount(wowneroAmountToString(amount: fee))} WOW';
}
