class Operation {
  final String id;
  DateTime date;
  int amount;
  String categoryId;
  String comment;

  Operation(this.id, this.date, this.amount, this.categoryId, this.comment);

  Operation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = DateTime.parse(json['date']),
        amount = int.parse(json['amount']),
        categoryId = json['categoryId'],
        comment = json['comment'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toString(),
      'amount': amount.toString(),
      'categoryId': categoryId,
      'comment': comment,
    };
  }
}
