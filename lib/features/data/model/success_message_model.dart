class SuccessMessageModel {
  String? status;
  String? message;

  SuccessMessageModel({this.status, this.message});

  SuccessMessageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
