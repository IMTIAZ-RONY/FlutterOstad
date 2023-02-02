

import 'package:flutter/material.dart';
import 'package:todoapp2/To%20Do%20Page.dart';

void main(){
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "To Do",
      theme:ThemeData(primarySwatch:Colors.purple ,fontFamily: "Goblin One") ,
      debugShowCheckedModeBanner: false,
      home:ToDoPage() ,
    );
  }

}

