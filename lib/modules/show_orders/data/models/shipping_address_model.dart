import 'package:fruits_hub_dashboard/modules/show_orders/domain/entities/shipping_address_entity.dart';

class ShippingAddressModel {
  String? name;
  String? phone;
  String? address;
  String? city;
  String? email;
  String? floor;

  ShippingAddressModel({
    this.name,
    this.phone,
    this.address,
    this.floor,
    this.city,
    this.email,
  });

  ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    floor = json['floor'];
    city = json['city'];
    email = json['email'];
  }

  toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'floor': floor,
      'city': city,
      'email': email,
    };
  }

  toEntity() {
    return ShippingAddressEntity(
      name: name,
      phone: phone,
      address: address,
      floor: floor,
      city: city,
      email: email,
    );
  }

  @override
  String toString() {
    return '$address $floor $city';
  }
}
