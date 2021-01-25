class ChatModel {
  String author;
  String message;
  String time;

  ChatModel({
    this.author,
    this.message,
    this.time,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['message'] = this.message;
    data['time'] = this.time;
    return data;
  }
}
