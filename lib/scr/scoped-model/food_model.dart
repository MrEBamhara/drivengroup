import 'dart:convert';

import 'package:driven/scr/models/food_model.dart';
import 'package:driven/scr/models/order_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class FoodModel extends Model {
  List<Food> _foods = [];
  List<Food> _popfoods = [];
  List<Food> _featuredfoods = [];
  List<Food> _drinksfoods = [];
  List<Food> _books = [];
  List<Food> _thespacefoods= [];
  List<Food> _theteahousefoods= [];
  List<Food> _theposhfoods= [];
  List<Food> _orders = [];

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<Food> get orders {
    return  List.from(_orders);
  }

  List<Food> get foods {
    return List.from(_foods);
  }
  List<Food> get featuredfoods {
    return List.from(_featuredfoods);
  }
  List<Food> get popfoods {
    return List.from(_popfoods);
  }
  List<Food> get drinkfoods {
    return List.from(_drinksfoods);
  }
  List<Food> get books {
    return List.from(_books);
  }
  List<Food> get thespacefoods {
    return List.from(_thespacefoods);
  }
  List<Food> get theteahousefoods {
    return List.from(_theteahousefoods);
  }
  List<Food> get theposhfoods {
    return List.from(_theposhfoods);
  }

  int get foodLength{
    return _foods.length;
  }

  Future<bool> addFood(Food food) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> foodData = {
        "username": food.name,
        "id": food.id,
        "quantity": food.quantity,
        "price": food.price,
        "status": food.status,
      };
      final http.Response response = await http.post(
          "http://drivengroup.co.zw/koppeh/serverside/confirm_order.php",
          body: json.encode(foodData));

      final Map<String, dynamic> responeData = json.decode(response.body);

      Food foodWithID = Food(
        id: responeData["name"],
        name: food.name,
        description: food.description,
        category: food.category,
        discount: food.discount,
        price: food.price,
      );

      _foods.add(foodWithID);
      _isLoading = false;
      notifyListeners();
      // fetchFoods();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
      // print("Connection error: $e");
    }
  }

  // all product
  Future<bool> fetchFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("http://drivengroup.co.zw/koppeh/serverside/get_food.php");

      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      //print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((foodData) {
        Food foodItem = Food(
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

      _foods = foodItems;
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

  // Popular Foods
  Future<bool> fetchPopFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("http://drivengroup.co.zw/koppeh/serverside/get_popular_food.php");

      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((foodData) {
        Food foodItem = Food(
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

      _popfoods = foodItems;
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

  // Featured Foods
  Future<bool> fetchFeaturedFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("http://drivengroup.co.zw/koppeh/serverside/get_featured_food.php");

      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((foodData) {
        Food foodItem = Food(
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

      _featuredfoods = foodItems;
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

  // Drinks
  Future<bool> fetchDrinksFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("http://drivengroup.co.zw/koppeh/serverside/get_drinks.php");

      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((foodData) {
        Food foodItem = Food(
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

      _drinksfoods = foodItems;
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

  // Books
  Future<bool> fetchBooks() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("http://drivengroup.co.zw/koppeh/serverside/get_books.php");

      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((foodData) {
        Food foodItem = Food(
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

      _books = foodItems;
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

  // The space
  Future<bool> fetchTheSpaceFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("http://drivengroup.co.zw/koppeh/serverside/get_restaurant_thespace.php");

      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((foodData) {
        Food foodItem = Food(
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

      _thespacefoods = foodItems;
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

  // The Teahouse
  Future<bool> fetchTheTeahouseFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("http://drivengroup.co.zw/koppeh/serverside/get_restaurant_theteahouse.php");

      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((foodData) {
        Food foodItem = Food(
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

      _theteahousefoods = foodItems;
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

  // The Posh
  Future<bool> fetchThePoshFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("http://drivengroup.co.zw/koppeh/serverside/get_restaurant_theposhburger.php");

      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((foodData) {
        Food foodItem = Food(
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

      _theposhfoods = foodItems;
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

  // User Orders
  Future<bool> fetchOrdersFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("http://drivengroup.co.zw/koppeh/serverside/get_orders.php?user=mann@gmail.com");

      // print("Fecthing data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((foodData) {
        Food foodItem = Food(
          id: foodData["order_number"],
          name: foodData["name"],
          ItemId: foodData["item_id"],
          description: foodData["descr"],
          payment_method: foodData["payment_method"],
          payment_status: foodData["payment_status"],
          delivery_address: foodData["delivery_address"],
          price: double.parse(foodData["price"].toString()),
          //discount: double.parse(foodData["discount"].toString()),

        );

        foodItems.add(foodItem);
      });

      _orders = foodItems;
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

  Future<bool> updateFood(Map<String, dynamic> foodData, String foodId) async{
    _isLoading = true;
    notifyListeners();

    // get the food by id
    Food theFood = getFoodItemById(foodId);

    // get the index of the food
    int foodIndex = _foods.indexOf(theFood);
    try{
      await http.put("https://foodie2-fe2c7.firebaseio.com/foods/${foodId}.json", body: json.encode(foodData));

      Food updateFoodItem = Food(
        id: foodId,
        name: foodData["title"],
        category: foodData["category"],
        discount: foodData['discount'],
        price: foodData['price'],
        description: foodData['description'],
        ratings: foodData['rate'],
      );

      _foods[foodIndex] = updateFoodItem;

      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    }catch(error){
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> deleteFood(String foodId) async{
    _isLoading = true;
    notifyListeners();

    try{
      final http.Response response = await http.delete("https://foodie2-fe2c7.firebaseio.com/foods/${foodId}.json");

      // delete item from the list of food items
      _foods.removeWhere((Food food) => food.id == foodId );


      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    }catch(error){
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }


  Food getFoodItemById(String foodId){
    Food food;
    for(int i = 0; i < _foods.length; i++){
      if(_foods[i].id == foodId){
        food = _foods[i];
        break;
      }
    }
    return food;
  }


}
