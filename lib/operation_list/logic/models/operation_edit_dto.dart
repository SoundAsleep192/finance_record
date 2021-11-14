class OperationEditDTO {
  String id;
  DateTime? date;
  int? amount;
  String? categoryId;
  String? comment;

  OperationEditDTO(this.id,
      {this.date, this.amount, this.categoryId, this.comment});
}
