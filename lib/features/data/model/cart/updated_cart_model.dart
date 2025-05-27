import 'dart:convert';

class UpdatedCartModel {
  String? status;
  String? message;
  CartData? cartData;

  UpdatedCartModel({this.status, this.message, this.cartData});

  factory UpdatedCartModel.fromRawJson(String str) =>
      UpdatedCartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdatedCartModel.fromJson(Map<String, dynamic> json) =>
      UpdatedCartModel(
        status: json["status"],
        message: json["message"],
        cartData: CartData.fromJson(json["cart_data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "cart_data": cartData?.toJson(),
  };
}

class CartData {
  int? id;
  dynamic customer;
  String? sessionKey;
  String? createdAt;

  CartData({this.id, this.customer, this.sessionKey, this.createdAt});

  factory CartData.fromRawJson(String str) =>
      CartData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
    id: json["id"],
    customer: json["customer"],
    sessionKey: json["session_key"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer": customer,
    "session_key": sessionKey,
    "created_at": createdAt,
  };
}
