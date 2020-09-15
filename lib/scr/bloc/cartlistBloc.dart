import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:driven/scr/bloc/provider.dart';
import 'package:driven/scr/models/food_model.dart';
import 'package:rxdart/rxdart.dart';

class CartListBloc extends BlocBase {
  CartListBloc();

  var _listController = BehaviorSubject<List<Food>>.seeded([]);

//provider class
  CartProvider provider = CartProvider();

//output
  Stream<List<Food>> get listStream => _listController.stream;

//input
  Sink<List<Food>> get listSink => _listController.sink;

  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;
  addToList(Food foodItem) {
    listSink.add(provider.addToList(foodItem));
  }


  removeFromList(Food foodItem) {
    listSink.add(provider.removeFromList(foodItem));
    
  }

//dispose will be called automatically by closing its streams
  @override
  void dispose() {
    cartStreamController.close();
    super.dispose();
  }
}
final blocs = CartListBloc();