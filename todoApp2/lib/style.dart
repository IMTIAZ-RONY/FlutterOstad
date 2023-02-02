import 'package:flutter/material.dart';
// vvv
InputDecoration AppInputDecoration(label){
  return InputDecoration(
    contentPadding:EdgeInsets.fromLTRB(10, 20, 20, 20),
    border:OutlineInputBorder(),
    labelText:label ,

  );
}
ButtonStyle AppButtonStyle(){
  return ElevatedButton.styleFrom(
    padding:EdgeInsets.all(12),
    backgroundColor:Colors.red,
    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5) ),


  );
}

SizedBox SizedBox50(child){
  return SizedBox(
    height:50 ,
    width:double.infinity ,
    child:Container(
      alignment:Alignment.center ,
      padding:EdgeInsets.all(8) ,
      child:child ,

    ) ,
  );
}