import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:driven/scr/screens/home.dart';
import 'package:driven/scr/screens/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:driven/scr/screens/main_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/main_model.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final MainModel mainModel = MainModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Driven group",
        theme: ThemeData(primaryColor: Colors.black),
        routes: {
          "/": (BuildContext context) => SignInPage(),
          "/mainscreen": (BuildContext context) => MainScreen(
            model: mainModel,
          ),
        },
        // home: AddFoodItem(),
      ),

    );

  }

}

