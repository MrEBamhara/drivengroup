import 'package:flutter/material.dart';

main() {
  Carts carts = new Carts();
  carts.items.values.toList();
  carts.addItem('1', 'Flutter Tutorial', 100);
  carts.addItem('2', 'Flutter', 100);
  carts.addItem('3', 'Android', 100);
  carts.addItem('4', 'Java', 700);
  carts.addItem('2', 'Flutter', 100);
  print('Shopping items ' + carts.itemCount.toString());
  print('Total Amount ' + carts.totalAmount.toString());
}
class Cart {
  final String id;
  final String title;
  final int quantity;
  final double price;
  Cart({
    this.id,
    this.title,
    this.price,
    this.quantity,
  });
}
class Carts {
  final uuid = Uuid();
  Map<String, Cart> _items = {};
  Map<String, Cart> get items {
    return _items;
  }
  int get itemCount {
    return _items.length;
  }
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cart) => total += cart.price * cart.quantity);
    return total;
  }
  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (old) => Cart(
          id: old.id,
          title: old.title,
          price: old.price,
          quantity: old.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
            () => Cart(
          id: uuid.v1(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
  }
  void removeItem(String productId) {
    _items.remove(productId);
  }
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
              (old) => Cart(
            id: old.id,
            title: old.title,
            price: old.price,
            quantity: old.quantity - 1,
          ));
    } else {
      _items.remove(productId);
    }
  }
  void clear() {
    _items = {};
  }
}

class Uuid {
  v1() {}
}