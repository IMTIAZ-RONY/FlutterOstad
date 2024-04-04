import 'package:flutter/material.dart';
Widget customTextField(keyboardType,boolType,hint,labelText,prefixIcon){
  return TextField(
    //controller:_passwordController ,
    keyboardType:keyboardType ,
    obscureText:boolType,
    decoration:InputDecoration(
        border:const OutlineInputBorder(
          borderSide:BorderSide.none ,
        ) ,
        contentPadding:const EdgeInsets.symmetric(horizontal: 24,vertical:16) ,
        hintText:hint ,
        labelText:labelText ,
        prefixIcon: Icon (
          prefixIcon,color:Colors.green ,)
    ) ,

  );
}
