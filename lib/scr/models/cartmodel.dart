/// The [dart:async] is neccessary for using streams
import 'dart:async';

import 'package:driven/scr/models/food_model.dart';
import 'package:driven/scr/widgets/featured_products.dart';

class CartItemsBloc {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  final Map allItems = {
    'shop items': [],
    'cart items': []
  };

  void addToCart(item) {
    //  allItems['productsList'].remove(item);
    allItems['cart items'].add(item);
    cartStreamController.sink.add(allItems);
    print(allItems);
  }

  void removeFromCart(item) {
    allItems['cart items'].remove(item);
    //allItems['shop items'].add(item);
    cartStreamController.sink.add(allItems);
  }
  void calculate() {
    var price = 0;
    ['cart items'].forEach((item) {
      price += 1;
    });
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final bloc = CartItemsBloc();
