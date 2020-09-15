

import 'package:driven/scr/models/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<Product> cart = [
    Product(name: "Burger", price: 3, rating: 4.8, vendor: "GoodFood", wishList: true, image: "2.jpg", qty: 1),
    Product(name: "Burger", price: 3, rating: 4.8, vendor: "GoodFood", wishList: true, image: "2.jpg", qty: 1),
    Product(name: "Burger", price: 3, rating: 4.8, vendor: "GoodFood", wishList: true, image: "2.jpg", qty: 1),
   ];
  double totalCartValue = 0;

  int get total => cart.length;

  void addProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    print(index);
    if (index != -1)
      updateProduct(product, product.qty + 1);
    else {
      cart.add(product);
      calculateTotal();
      notifyListeners();
    }
    final snackBar = SnackBar(content: Text("Tap"));

    Scaffold.of(product).showSnackBar(snackBar);
    print("object");
  }

  void removeProduct(products) {
    int index = cart.indexWhere((i) => i.id == products.id);
    cart[index].qty;
    cart.removeWhere((item) => item.id == products.id);
    calculateTotal();
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].qty;
    if (cart[index].qty == 0)
      removeProduct(product);

    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.qty);
    cart = [];
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValue = 0;
    cart.forEach((f) {
      totalCartValue += f.price * f.qty;
    });
  }
}

class Product {
  final String id;
  final String name;
  final String image;
  final int price;
  final int qty;
  final double rating;
  final String vendor;
  final bool wishList;

  Product({this.id, this.name, this.image, this.rating, this.vendor, this.wishList, this.price, this.qty});
}

