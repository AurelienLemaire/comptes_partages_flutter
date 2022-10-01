import 'dart:core';
import 'transaction.dart';

/// Une classe pour modéliser un carnet de transactions et les opérations associées
class Carnet {
  String _name;
  List<String> _users = [];
  List<Transaction> _transactions = [];

  /// Constructeur pour initialiser a partir d'un ensemble de transactions vides
  Carnet(this._name) {
    initUsers();
    initTransactions();
  }

  String name() => _name;

  setName(String n) {
    _name = n;
  }

  List<Transaction> get transactions => _transactions;
  List<String> get users => _users;

  List<String> getUsers() => _users;

  ///
  void initTransactions() {
    _transactions = [];
  }

  void initUsers() {
    _users = [];
  }

  void initCarnetWithUsers(List<String> u) {
    initUsers();
    _users.addAll(u);
  }

  ///
  void initCarnetWithTransactions(List<Transaction>? transactionsList) {
    initTransactions();
    addTransactionList(transactionsList);
  }

  ///
  void addTransactionList(List<Transaction>? transactionsList) {
    if (transactionsList != null) {
      _transactions.addAll(transactionsList);
    }
  }

  ///
  void addUser(String u) {
    _users.add(u);
  }

  ///
  void addTransaction(String who, double amount, String what) {
    var t = Transaction(who, amount, what);
    _transactions.add(t);
  }

  ///
  Map<String, List<Transaction>> getTransactionsByUser() {
    Map<String, List<Transaction>> result = {};
    for (final tr in _transactions) {
      if (result[tr.who] == null) result[tr.who] = [];

      (result[tr.who])?.add(tr);
    }

    return result;
  }

  ///
  Map<String, Carnet> splitCarnetByUser() {
    Map<String, Carnet> result = {};

    Map<String, List<Transaction>> transactionsByUser = getTransactionsByUser();
    Iterable<String> transactionUsers = transactionsByUser.keys;

    for (final u in transactionUsers) {
      Carnet carnetUser = Carnet(u);
      carnetUser.initCarnetWithTransactions(transactionsByUser[u]);
      result[u] = carnetUser;
    }

    return result;
  }

  ///
  double getAverageAmountByUser() {
    Map<String, Carnet> carnetsByUser = splitCarnetByUser();
    int nbusers = carnetsByUser.keys.length;
    double montant = totalAmount();
    double averageAmountByUser = montant / nbusers;
    return averageAmountByUser;
  }

  ///
  Map<String, double> getGapToAverageByUser() {
    Map<String, double> result = {};

    Map<String, Carnet> carnetsByUser = splitCarnetByUser();
    double averageAmountByUser = getAverageAmountByUser();

    for (String u in carnetsByUser.keys) {
      Carnet? c = carnetsByUser[u];
      if (c != null) {
        double montant = c.totalAmount();
        double gap = montant - averageAmountByUser;
        result[u] = gap;
      }
    }

    return result;
  }

  ///
  double getAverageAmountByTransaction() {
    int nbTransactions = _transactions.length;
    double montant = totalAmount();
    double averageAmountByTransaction = montant / nbTransactions;
    return averageAmountByTransaction;
  }

  ///
  Map getAmountStatistics() {
    Map result = {};

    result['averageAmountByUser'] = getAverageAmountByUser();
    result['averageAmountByTransaction'] = getAverageAmountByTransaction();
    result['gapToAverageByUser'] = getGapToAverageByUser();
    return result;
  }

  ///
  Map<String, double> getAmountByUser() {
    Map<String, double> result = {};

    Map<String, Carnet> carnetsByUser = splitCarnetByUser();
    Iterable<String> transactionUsers = carnetsByUser.keys;

    for (final u in transactionUsers) {
      Carnet? c = carnetsByUser[u];
      if (c != null) result[u] = c.totalAmount();
    }

    return result;
  }

  ///
  double totalAmount() {
    var result = 0.0;
    for (final tr in _transactions) {
      result += tr.amount;
    }
    return result;
  }

  @override
  String toString() {
    return "CARNET $_name - $_transactions";
  }

  factory Carnet.fromJson(Map<String, dynamic> json) {
    Carnet c = Carnet(json['name']);

    List<Transaction> l = List<Transaction>.from(
        json['transactions'].map((i) => Transaction.fromJson(i)));
    List<String> u = List<String>.from(json['users'].map((i) => i as String));
    c.initCarnetWithTransactions(l);
    c.initCarnetWithUsers(u);

    return c;
  }

  Map<String, dynamic> toJson() => {
        'name': name(),
        'users': getUsers(),
        'transactions': transactions,
      };
}
