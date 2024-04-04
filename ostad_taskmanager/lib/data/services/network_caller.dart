import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ostad_taskmanager/UI/screens/auth/login_screen.dart';
import 'package:ostad_taskmanager/app.dart';
import 'package:ostad_taskmanager/data/models/auth_utility.dart';
import 'package:ostad_taskmanager/data/models/network_response.dart';
class NetworkCaller{
  /// Get Request

  Future<NetworkResponse> getRequest(String url)async{

    try{
      Response response = await get(Uri.parse(url),headers:{
        "token":AuthUtility.userInfo.token.toString(),
      } );
      log(response.statusCode.toString());
      log(response.body);
    if(response.statusCode==200){
       return NetworkResponse( true,response.statusCode,jsonDecode(response.body));

    }else{
      return NetworkResponse(false,response.statusCode, null);
    } }catch(e){
      log(e.toString());
    }
    return NetworkResponse(false,-1, null);

  }

  /// Post Request
  Future<NetworkResponse>  postRequest(String url,Map<String,dynamic>body, {bool isLogin= false})async{

    try{
      log(body.toString());
      Response response = await post(Uri.parse(url),
          headers:{"Content-Type":"application/json",
          "token":AuthUtility.userInfo.token.toString()} , body:jsonEncode(body) );
      log(response.statusCode.toString());
      log(response.body);
    if(response.statusCode==200){
       return NetworkResponse( true,response.statusCode,jsonDecode(response.body));

    }else if(response.statusCode==401){
      if(isLogin==false){
        gotoLogin();
      }
    }
    else{
      return NetworkResponse(false,response.statusCode, null);
    } }catch(e){
      log(e.toString());
    }
    return NetworkResponse(false,-1, null);

  }
  /// go to login
  Future<void> gotoLogin() async {
    await AuthUtility.clearUserInfo();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.globalKey.currentContext!,
        MaterialPageRoute(builder:  (_)=>const LoginScreen()), (route) => false);
  }

}