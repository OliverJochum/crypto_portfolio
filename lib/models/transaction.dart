class Transaction{
  String sender;
  String receiver;
  double amount;
  DateTime timestamp;

  Map <String, dynamic> get details {
    return {
      "sender":sender,
      "receiver":receiver,
      "amount":amount,
      "timestamp":timestamp
    };
  }

  Transaction(this.sender, this.receiver, this.amount, this.timestamp);
}


