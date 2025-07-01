import 'package:fruits_hub_dashboard/modules/show_orders/domain/entities/order_entity.dart';
import 'package:fruits_hub_dashboard/modules/show_orders/domain/entities/order_product_entity.dart';
import 'package:fruits_hub_dashboard/modules/show_orders/domain/entities/shipping_address_entity.dart';

OrderEntity getDummyOrder() {
  // Sample ordered products
  String watermelonImageUrl =
      'https://ksmrurgonuymbadheiky.supabase.co/storage/v1/object/public/fruits_images/images/watermelon.png';
  String strobaryImageUrl =
      'https://ksmrurgonuymbadheiky.supabase.co/storage/v1/object/public/fruits_images/images/strewbari.png';
  String pinappleImageUrl =
      'https://ksmrurgonuymbadheiky.supabase.co/storage/v1/object/public/fruits_images/images/pineapple.png';
  String avocadoImageUrl =
      'https://ksmrurgonuymbadheiky.supabase.co/storage/v1/object/public/fruits_images/images/avocado.png';
  final List<OrderProductEntity> products = [
    OrderProductEntity(
      name: 'بطيخ',
      code: '123',
      imageUrl: watermelonImageUrl,
      price: 100.00,
      quantity: 1,
    ),
    OrderProductEntity(
      name: 'فراوله',
      code: '789',
      imageUrl: strobaryImageUrl,
      price: 50.00,
      quantity: 1,
    ),
    OrderProductEntity(
      name: 'أناناس',
      code: '621',
      imageUrl: pinappleImageUrl,
      price: 50.00,
      quantity: 1,
    ),
    OrderProductEntity(
      name: 'أفوكادو',
      code: '456',
      imageUrl: avocadoImageUrl,
      price: 120.00,
      quantity: 1,
    ),
  ];

  // Sample shipping address
  final shippingAddress = ShippingAddressEntity(
    name: 'كرم سلامه',
    phone: '+20 100 123 4567',
    address: 'شارع التحرير',
    floor: 'الطابق الثاني',
    city: 'القاهره',
    email: 'karam@gmail.com',
  );

  // Return a mock OrderModel
  return OrderEntity(
    totalPrice:
        products.fold(0, (sum, item) => sum + (item.price * item.quantity)),
    uId: 'Ws12QxOaD2XAwD2YuKHBRQ56fn62',
    shippingAddressEntity: shippingAddress,
    orderProductsEntity: products,
    paymentMethod: 'Paypal',
  );
}

List<OrderEntity> getDummyOrders() {
  return List.generate(5, (_) => getDummyOrder());
}
