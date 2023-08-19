class MessageBody {
  int? _id;
  String? _message;

  MessageBody({required int id, required String message}) {
    this._id = id;
    this._message = message;
  }

  int? get id => _id;
  String? get message => _message;

  MessageBody.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['message'] = this._message;
    return data;
  }
}
