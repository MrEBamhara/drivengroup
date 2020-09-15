import 'dart:convert';

import 'package:driven/scr/models/food_model.dart';
import 'package:driven/scr/models/popular_food_model.dart';
import 'package:driven/scr/models/products.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class GetPopFoodModel extends Model {
  List<GetPopFood> get_foods = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<GetPopFood> get pop_foods {
    return List.from(get_foods);
  }

  int get foodLength{
    return get_foods.length;
  }


  Future<bool> fetchFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("http://drivengroup.co.zw/koppeh/serverside/get_food.php");

      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<GetPopFood> foodItems = [];

      fetchedData.forEach((foodData) {
        GetPopFood foodItem = GetPopFood(
          id: foodData["id"],
          name: foodData["name"],
          imagePath: foodData["img"],
          description: foodData["descr"],
          category: foodData["category"],
          status: foodData["featured_status"],
          restaurant: foodData["restaurant"],
          price: double.parse(foodData["price"].toString()),
          //discount: double.parse(foodData["discount"].toString()),
          ratings: double.parse(foodData["rating"].toString()),
        );

        foodItems.add(foodItem);
      });

      get_foods = foodItems;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      print("The errror: $error");
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }



  GetPopFood getPopFoodItemById(String foodId){
    GetPopFood popfood;
    for(int i = 0; i < get_foods.length; i++){
      if(get_foods[i].id == foodId){
        popfood = get_foods[i];
        break;
      }
    }
    return popfood;
  }


}
