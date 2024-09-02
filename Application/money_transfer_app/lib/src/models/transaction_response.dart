class TransactionResponse {
  final String message;
  final String transactionId;

  TransactionResponse({required this.message, required this.transactionId});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      message: json['message'],
      transactionId: json['transactionId'],
    );
  }
}

