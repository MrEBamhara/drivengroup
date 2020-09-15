import 'package:driven/scr/scoped-model/user_scoped_model.dart';

import '../scoped-model/food_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'cartItem.dart';

class MainModel extends Model with FoodModel, UserModel, CartModel{

}