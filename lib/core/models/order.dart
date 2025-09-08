import 'package:foodey/core/models/product.dart';

enum OrderStatus { preparing, outForDelivery, delivered, cancelled }

class OrderItem {
  final Product product;
  final int quantity;

  const OrderItem({required this.product, required this.quantity});

  double get lineTotal => product.price * quantity;
}

class Order {
  final String id;
  final List<OrderItem> items;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final OrderStatus status;
  final double totalAmount;
  final String? estimatedDeliveryTime;

  const Order({
    required this.id,
    required this.items,
    required this.orderDate,
    this.deliveryDate,
    required this.status,
    required this.totalAmount,
    this.estimatedDeliveryTime,
  });

  String get orderSummary {
    if (items.length == 1) {
      return '${items.first.product.name} x${items.first.quantity}';
    } else if (items.length == 2) {
      return '${items.first.product.name} +${items.length - 1}';
    } else {
      return '${items.first.product.name} +${items.length - 1}';
    }
  }

  String get statusText {
    switch (status) {
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.outForDelivery:
        return 'Out for delivery';
      case OrderStatus.delivered:
        return 'Order delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isCurrent =>
      status == OrderStatus.preparing || status == OrderStatus.outForDelivery;
  bool get isPrevious =>
      status == OrderStatus.delivered || status == OrderStatus.cancelled;

  String get formattedDeliveryDate {
    if (deliveryDate == null) return '';
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${deliveryDate!.day} ${months[deliveryDate!.month - 1]}';
  }
}
