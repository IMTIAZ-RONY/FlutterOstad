import 'package:crud/Screen/ProductGridViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Screen/ProductCreateScreen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Crud App',
      theme:ThemeData(primarySwatch:Colors.pink) ,
      debugShowCheckedModeBanner:false ,

      home: ProductGridViewScreen(),
    );
  }
}


