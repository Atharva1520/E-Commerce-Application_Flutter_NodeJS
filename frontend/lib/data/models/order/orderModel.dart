import 'package:equatable/equatable.dart';

import '../cart/cartItemModel.dart';
import '../user/userModel.dart';

// ignore: must_be_immutable
class OrderModel extends Equatable {
  String? sId;
  UserModel? user;
  List<CartItemModel>? items;
  String? status;
  double? totalAmount;
  String? razorPayOrderId;
  DateTime? updatedOn;
  DateTime? createdOn;

  OrderModel(
      {this.sId,
      this.user,
      this.items,
      this.status,
      this.totalAmount,
      this.razorPayOrderId,
      this.updatedOn,
      this.createdOn});

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = UserModel.fromJson(json["user"]);
    items = (json["items"] as List<dynamic>)
        .map((item) => CartItemModel.fromJson(item))
        .toList();
    status = json['status'];
    razorPayOrderId = json['razorPayOrderId'];
    totalAmount = double.tryParse(json['totalAmount'].toString());
    updatedOn = DateTime.tryParse(json['updatedOn']);
    createdOn = DateTime.tryParse(json['createdOn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = user!.toJson();
    data['items'] =
        items!.map((item) => item.toJson(objectMode: true)).toList();
    data['status'] = this.status;
    data['razorPayOrderId'] = this.razorPayOrderId;
    data['totalAmount'] = this.totalAmount;
    data['updatedOn'] = this.updatedOn?.toIso8601String();
    data['createdOn'] = this.createdOn?.toIso8601String();
    return data;
  }

  @override
  List<Object?> get props => [sId];
}
