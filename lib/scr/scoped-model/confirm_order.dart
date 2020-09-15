import 'package:driven/scr/enums/euth_mode.dart';
import 'package:driven/scr/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderModel extends Model {
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


  Future<Map<String, dynamic>> order_authenticate(
      String email, String password, String username,
      String drop_address,
      String delivery_note,
      String payment_type,
      {AuthMode authMode = AuthMode.SignIn}) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "username": username,
    };
    Map<String, dynamic> authOrderData = {
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
      }else if (authMode == AuthMode.Confirm) {
        response = await http.post(
          "http://drivengroup.co.zw/koppeh/serverside/login.php",
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'},
        );
      }

      var responseBody = json.decode(response.body);

      if (responseBody == "true") {

        if (authMode == AuthMode.SignUp) {
          message = "Sign up successfully";
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
        'message': 'Failed to sign up successfully',
        'hasError': !hasError,
      };
    }
  }
}
