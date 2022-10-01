class Transaction {
  String who;
  double amount;
  String what;

  Transaction(this.who, this.amount, this.what);

  // @override
  // String toString() {
  //   return "{who: $who, amount: $amount, what: $what}";
  // }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    Transaction t = Transaction(json['who'], json['amount'], json['what']);
    return t;
  }

  Map<String, dynamic> toJson() {
    return {
      'who': who,
      'amount': amount,
      'what': what,
    };
  }
}
