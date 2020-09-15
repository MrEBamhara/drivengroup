import 'package:driven/scr/models/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class OrderItem {
  final String id;
  final String amount;
  final List<Food> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(String username, String drop_address, String delivery_note, String payment_type, String totalAmount, List<Food> cartProducts) async {
    final url = 'http://drivengroup.co.zw/koppeh/serverside/confirm_order.php';
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'id': DateTime.now().toString(),
            'amount': totalAmount,
            'dateTime': timeStamp.toIso8601String(),
            "drop_address": drop_address,
            "delivery_note": delivery_note,
            "payment_type": payment_type,
            "username": username,
            "price": totalAmount,
            'products': cartProducts
                .map((cp) => {
              'id': cp.id,
              'title': cp.name,
              'quantity': cp.quantity,
              'price': cp.price
            })
                .toList(),
          }));
      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              amount: totalAmount,
              dateTime: timeStamp,
              products: cartProducts));
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
