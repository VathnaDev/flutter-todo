import 'package:flutter/material.dart';
import 'package:todo_app/src/bloc/provider.dart';
import 'package:todo_app/src/screen/home.dart';

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        theme: getThemeData(),
        home: HomeScreen(),
      ),
    );
  }
}

ThemeData getThemeData() {
  return ThemeData(
    primarySwatch: Colors.green,
    // textSelectionColor: Colors.white,
    // hintColor: Colors.white,
    // textTheme: TextTheme(
    //   title: TextStyle(color: Colors.white),
    //   body1: TextStyle(color: Colors.white),
    //   body2: TextStyle(color: Colors.white),
    //   display1: TextStyle(color: Colors.white),
    //   display2: TextStyle(color: Colors.white),
    //   display3: TextStyle(color: Colors.white),
    //   display4: TextStyle(color: Colors.white),
    //   caption: TextStyle(color: Colors.white),
    //   button: TextStyle(color: Colors.white),
    //   headline: TextStyle(color: Colors.white),
    //   subhead: TextStyle(color: Colors.white),
    // ),
  );
}
