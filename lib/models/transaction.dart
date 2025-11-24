class Transaction {
  final int? id;
  final String filmTitle;
  final String filmGenre;
  final String filmPoster;
  final double filmPrice;
  final String schedule;
  final String buyerName;
  final int quantity;
  final String purchaseDate;
  final double totalPrice;
  final String paymentMethod;
  final String? cardNumber;
  final String status;
  final int userId;

  Transaction({
    this.id,
    required this.filmTitle,
    required this.filmGenre,
    required this.filmPoster,
    required this.filmPrice,
    required this.schedule,
    required this.buyerName,
    required this.quantity,
    required this.purchaseDate,
    required this.totalPrice,
    required this.paymentMethod,
    this.cardNumber,
    required this.status,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'filmTitle': filmTitle,
      'filmGenre': filmGenre,
      'filmPoster': filmPoster,
      'filmPrice': filmPrice,
      'schedule': schedule,
      'buyerName': buyerName,
      'quantity': quantity,
      'purchaseDate': purchaseDate,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      'cardNumber': cardNumber,
      'status': status,
      'userId': userId,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      filmTitle: map['filmTitle'],
      filmGenre: map['filmGenre'],
      filmPoster: map['filmPoster'],
      filmPrice: map['filmPrice'],
      schedule: map['schedule'],
      buyerName: map['buyerName'],
      quantity: map['quantity'],
      purchaseDate: map['purchaseDate'],
      totalPrice: map['totalPrice'],
      paymentMethod: map['paymentMethod'],
      cardNumber: map['cardNumber'],
      status: map['status'],
      userId: map['userId'],
    );
  }

  Transaction copyWith({
    int? id,
    String? filmTitle,
    String? filmGenre,
    String? filmPoster,
    double? filmPrice,
    String? schedule,
    String? buyerName,
    int? quantity,
    String? purchaseDate,
    double? totalPrice,
    String? paymentMethod,
    String? cardNumber,
    String? status,
    int? userId,
  }) {
    return Transaction(
      id: id ?? this.id,
      filmTitle: filmTitle ?? this.filmTitle,
      filmGenre: filmGenre ?? this.filmGenre,
      filmPoster: filmPoster ?? this.filmPoster,
      filmPrice: filmPrice ?? this.filmPrice,
      schedule: schedule ?? this.schedule,
      buyerName: buyerName ?? this.buyerName,
      quantity: quantity ?? this.quantity,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cardNumber: cardNumber ?? this.cardNumber,
      status: status ?? this.status,
      userId: userId ?? this.userId,
    );
  }
}
