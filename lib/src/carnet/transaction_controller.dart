import 'transaction.dart';
import 'dart:convert';
import 'dart:io';

class TransactionController {
  static final instance = TransactionController();
  Transaction? transaction;

  void setTransaction(Transaction c) {
    transaction = c;
  }

  void deleteTransaction() {
    transaction = null;
  }
}
