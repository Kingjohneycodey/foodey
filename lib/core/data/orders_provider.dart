import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodey/core/models/order.dart';
import 'package:foodey/core/data/products_data.dart';

class OrdersState {
  final List<Order> orders;
  const OrdersState({this.orders = const []});
}

class OrdersNotifier extends StateNotifier<OrdersState> {
  OrdersNotifier() : super(_initialState());

  static OrdersState _initialState() {
    // Get some products for sample orders
    final products = ProductsData.allProducts;

    final sampleOrders = [
      // Current orders
      // Order(
      //   id: '1',
      //   items: [
      //     OrderItem(
      //       product: products[12],
      //       quantity: 1,
      //     ), // Pepperoni Cheese Pizza
      //     OrderItem(product: products[0], quantity: 3), // Classic Burger x3
      //   ],
      //   orderDate: DateTime.now().subtract(const Duration(minutes: 30)),
      //   status: OrderStatus.outForDelivery,
      //   totalAmount: 24.02,
      //   estimatedDeliveryTime: '30mins',
      // ),

      // Previous orders - matching the images
      Order(
        id: '2',
        items: [
          OrderItem(product: products[5], quantity: 1), // Pudding
        ],
        orderDate: DateTime(2024, 10, 26),
        deliveryDate: DateTime(2024, 10, 26),
        status: OrderStatus.delivered,
        totalAmount: 16.98,
      ),

      Order(
        id: '3',
        items: [
          OrderItem(product: products[6], quantity: 1), // Honey Bee Pineapple
        ],
        orderDate: DateTime(2024, 10, 20),
        deliveryDate: DateTime(2024, 10, 20),
        status: OrderStatus.delivered,
        totalAmount: 26.99,
      ),

      Order(
        id: '4',
        items: [
          OrderItem(product: products[11], quantity: 1), // Beef Burger
          OrderItem(product: products[7], quantity: 1), // Additional item (+1)
        ],
        orderDate: DateTime(2024, 10, 16),
        deliveryDate: DateTime(2024, 10, 16),
        status: OrderStatus.delivered,
        totalAmount: 18.97,
      ),

      Order(
        id: '5',
        items: [
          OrderItem(product: products[3], quantity: 5), // Chocolate Donut x5
        ],
        orderDate: DateTime(2024, 10, 17),
        deliveryDate: DateTime(2024, 10, 17),
        status: OrderStatus.delivered,
        totalAmount: 26.95,
      ),
    ];

    return OrdersState(orders: sampleOrders);
  }

  List<Order> get currentOrders =>
      state.orders.where((order) => order.isCurrent).toList();
  List<Order> get previousOrders =>
      state.orders.where((order) => order.isPrevious).toList();

  void addOrder(Order order) {
    state = OrdersState(orders: [...state.orders, order]);
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final updatedOrders = state.orders.map((order) {
      if (order.id == orderId) {
        return Order(
          id: order.id,
          items: order.items,
          orderDate: order.orderDate,
          deliveryDate: newStatus == OrderStatus.delivered
              ? DateTime.now()
              : order.deliveryDate,
          status: newStatus,
          totalAmount: order.totalAmount,
          estimatedDeliveryTime: order.estimatedDeliveryTime,
        );
      }
      return order;
    }).toList();

    state = OrdersState(orders: updatedOrders);
  }
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, OrdersState>(
  (ref) => OrdersNotifier(),
);
