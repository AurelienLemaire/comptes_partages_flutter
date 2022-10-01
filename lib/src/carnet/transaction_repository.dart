import 'transaction.dart';

class TransactionRepository {
  static List<Transaction> getMockupTransactionList() {
    List<Transaction> result = [];
    result.add(Transaction("aurelien", 5.70, "courses"));
    result.add(Transaction("aurelie", 3.20, "tablette"));
    result.add(Transaction("aurelie", 8.10, "truc"));
    result.add(Transaction("tinai", 8.10, "cadeau"));

    return result;
  }
}
