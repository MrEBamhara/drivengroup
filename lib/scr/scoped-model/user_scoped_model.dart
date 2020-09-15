import 'package:driven/scr/bloc/cartlistBloc.dart';
import 'package:driven/scr/enums/euth_mode.dart';
import 'package:driven/scr/models/food_model.dart';
import 'package:driven/scr/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserModel extends Model {
  List<User> _users = [];
  User _authenticatedUser;
  bool _isLoading = false;

  List<User> get users {
    return List.from(_users);
  }

  User get authtenticatedUser {
    return _authenticatedUser;
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<Map<String, dynamic>> authenticate(
      String email, String password, String username,
      {AuthMode authMode = AuthMode.SignIn}) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "username": username,
    };

    String message;
    bool hasError = false;
    var res = true;
    try {
      http.Response response;
      if (authMode == AuthMode.SignUp) {
        response = await http.post(
            "http://drivengroup.co.zw/koppeh/serverside/signup.php",
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'},
        );
      } else if (authMode == AuthMode.SignIn) {
        response = await http.post(
          "http://drivengroup.co.zw/koppeh/serverside/login.php",
          body: json.encode(authData), 
          headers: {'Content-Type': 'application/json'},
        );

       // _users.add(authData);
      }
     // hasError = true;
      var responseBody = json.decode(response.body);
      print(responseBody);
      if (responseBody == "loggedIn") {
        hasError = false;
        if (authMode == AuthMode.SignUp) {
          message = "Sign up successfully";
        } else if(authMode == AuthMode.SignIn) {
          message = "Sign in successfully";
        }else if(authMode == AuthMode.Confirm) {
          message = "Order submitted";
        }
      } else if(responseBody == "INVALID_PASSWORD") {
        hasError = true;
        if (responseBody['error']['message'] == 'EMAIL_EXISTS') {
          message = "Email already exists";
        } else if (responseBody['error']['message'] == "EMAIL_NOT_FOUND") {
          message = "Email does not exist";
        } else if (responseBody['error']['message'] == "INVALID_PASSWORD") {
          message = "Password is incorrect";
        }
      }

      _isLoading = false;
      notifyListeners();
      return {
        'message': message,
        'hasError': hasError,
      };
    } catch (error) {
      print("The error: $error");
      _isLoading = false;
      notifyListeners();

      return {
        'message': 'Failed to sign up successfully',
        'hasError': !hasError,
      };
    }
  }

  Future<Map<String, dynamic>>  order_authenticate(
  String username, String drop_address, String delivery_note, String payment_type, String totalAmount, List<Food> foodProducts,
  {AuthMode authMode = AuthMode.Confirm}) async {

  _isLoading = true;
  notifyListeners();

  List<Food> convertedOrder = [];
  for(Food item in foodProducts){
  Food foodItem = Food(
  id: item.id,
  );
  convertedOrder.add(foodItem);
  }
  //Map<String, dynamic> toJson() => {convertedOrder}
  Map<String, dynamic>  authOrderData = {
  "drop_address": drop_address,
  "delivery_note": delivery_note,
  "payment_type": payment_type,
  "username": username,
  "price": totalAmount,
    "order": foodProducts
    .map((bn) =>{'id': bn.id, 'quantity': bn.quantity}).toList()
  };

 print(authOrderData);
  String message;
  bool hasError = false;
  var res = true;
  try {
  http.Response response;
  if (authMode == AuthMode.SignUp) {
  response = await http.post(
  "http://drivengroup.co.zw/koppeh/serverside/signup.php",
  body: json.encode(authOrderData),
  headers: {'Content-Type': 'application/json'},
  );
  }else if (authMode == AuthMode.Confirm) {
  response = await http.post(
  "http://drivengroup.co.zw/koppeh/serverside/confirm_order.php",
  body: json.encode(authOrderData),
  headers: {'Content-Type': 'application/json'},
  );
  }

  var responseBody = json.decode(response.body);

  if (responseBody == "submitted") {
    message = "Order submitted";
  if (authMode == AuthMode.Confirm) {
  message = "Order submitted";
  } else {
  message = "Sign in successfully";
  }
  } else {
  hasError = true;
  if (responseBody['error']['message'] == 'EMAIL_EXISTS') {
  message = "Email already exists";
  } else if (responseBody['error']['message'] == "EMAIL_NOT_FOUND") {
  message = "Email does not exist";
  } else if (responseBody['error']['message'] == "INVALID_PASSWORD") {
  message = "Password is incorrect";
  }
  }

  _isLoading = false;
  notifyListeners();
  return {
  'message': message,
  'hasError': hasError,
  };
  } catch (error) {
  print("The error: $error");
  _isLoading = false;
  notifyListeners();

  return {
  'message': 'Failed to order successfully',
  'hasError': !hasError,
  };
  }
  }

  }


