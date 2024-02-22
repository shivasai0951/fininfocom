class dogimageModel {
  String? message;
  String? status;

  dogimageModel({this.message, this.status});

  dogimageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}