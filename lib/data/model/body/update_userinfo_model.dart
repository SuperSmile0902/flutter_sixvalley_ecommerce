class UpdateUserInfoModel {
  String fName = '';
  String lName = '';
  String phone = '';

  UpdateUserInfoModel({
    required this.fName,
    required this.lName,
    required this.phone,
  });

  UpdateUserInfoModel.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    return data;
  }
}
