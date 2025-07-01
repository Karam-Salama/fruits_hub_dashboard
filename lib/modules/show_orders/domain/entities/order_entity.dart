import 'package:fruits_hub_dashboard/modules/show_orders/domain/entities/order_product_entity.dart';
import 'package:fruits_hub_dashboard/modules/show_orders/domain/entities/shipping_address_entity.dart';

import '../../../../core/enums/order_enum.dart';

class OrderEntity {
  final double totalPrice;
  final String uId;
  final ShippingAddressEntity shippingAddressEntity;
  final List<OrderProductEntity> orderProductsEntity;
  final String paymentMethod;
  final OrderStatusEnum status;

  OrderEntity({
    required this.totalPrice,
    required this.uId,
    required this.shippingAddressEntity,
    required this.orderProductsEntity,
    required this.paymentMethod,
    required this.status,
  });
}
