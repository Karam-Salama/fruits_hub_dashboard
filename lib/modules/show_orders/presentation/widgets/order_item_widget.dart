import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';
import 'package:fruits_hub_dashboard/modules/show_orders/domain/entities/order_entity.dart';
import 'package:fruits_hub_dashboard/modules/show_orders/domain/entities/order_product_entity.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderEntity orderEntity;

  const OrderItemWidget({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Row(
            children: [
              Text(
                'Order #${orderEntity.uId.substring(0, 4)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Spacer(),
              Text(
                '\$${orderEntity.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              const Text('الدفع:'),
              const SizedBox(width: 6),
              Text(orderEntity.paymentMethod == 'Cash' ? 'نقدًا' : 'باي بال'),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const Text('بيانات الشحن:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('الاسم: ${orderEntity.shippingAddressEntity.name}'),
                  Text('الهاتف: ${orderEntity.shippingAddressEntity.phone}'),
                  Text('العنوان: ${orderEntity.shippingAddressEntity}'),
                  const SizedBox(height: 12),
                  const Divider(),
                  const Text('المنتجات:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...orderEntity.orderProductsEntity
                      .map((product) => _buildProductItem(product)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(OrderProductEntity product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.fill,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16)),
                Text('الكود: ${product.code}'),
                Text('الكمية: ${product.quantity}'),
              ],
            ),
          ),
          Text('\$${product.price.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
