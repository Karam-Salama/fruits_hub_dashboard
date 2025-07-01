import 'package:fruits_hub_dashboard/modules/show_orders/domain/entities/order_entity.dart';

import '../../../../core/enums/order_enum.dart';
import 'order_product_model.dart';
import 'shipping_address_model.dart';

class OrderModel {
  final double totalPrice;
  final String uId;
  final ShippingAddressModel shippingAddressModel;
  final List<OrderProductModel> orderProducts;
  final String paymentMethod;
  final String? status;

  OrderModel({
    required this.totalPrice,
    required this.uId,
    required this.shippingAddressModel,
    required this.orderProducts,
    required this.paymentMethod,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      totalPrice: json['totalPrice'],
      uId: json['uId'],
      shippingAddressModel:
          ShippingAddressModel.fromJson(json['shippingAddressModel']),
      orderProducts: List<OrderProductModel>.from(
        json['orderProducts'].map((e) => OrderProductModel.fromJson(e)),
      ),
      paymentMethod: json['paymentMethod'],
      status: json['status'],
    );
  }

  toJson() {
    return {
      'totalPrice': totalPrice,
      'uId': uId,
      'status': 'pending',
      'date': DateTime.now().toIso8601String(),
      'shippingAddressModel': shippingAddressModel.toJson(),
      'orderProducts': orderProducts.map((e) => e.toJson()).toList(),
      'paymentMethod': paymentMethod,
    };
  }

  toEntity() {
    return OrderEntity(
      totalPrice: totalPrice,
      uId: uId,
      status: getStatus(),
      orderProductsEntity: orderProducts.map((e) => e.toEntity()).toList(),
      shippingAddressEntity: shippingAddressModel.toEntity(),
      paymentMethod: paymentMethod,
    );
  }

  OrderStatusEnum getStatus() =>
      OrderStatusEnum.values.byName(status ?? 'pending');
}
