class TodoItemModel {
  final String id;
  final String content;
  final String createdAt;

  TodoItemModel(this.id, this.content, this.createdAt);

  TodoItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() {
    return {'id': id, 'content': content, 'createdAt': createdAt};
  }
}
