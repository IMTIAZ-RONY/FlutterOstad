
import 'dart:convert';

import 'package:amarthikana_net/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtility{
           AuthUtility._();
           static LoginModel userInfo =LoginModel();
         static  Future<void>svaeUserInfo(LoginModel model) async {
             SharedPreferences _shareprefs = await SharedPreferences.getInstance();
             await _shareprefs.setString('user-data',jsonEncode(model.toJson()) );
           }

         static  Future<LoginModel>getUserInfo() async {
             SharedPreferences _shareprefs = await SharedPreferences.getInstance();
             String value = _shareprefs.getString('user-data')!;
            return LoginModel.fromJson (jsonDecode(value));
           }

         static  Future<void>clearUserInfo()async {
             SharedPreferences _shareprefs = await SharedPreferences.getInstance();
            await _shareprefs.clear();
           }

         static  Future<bool>checkIfUserLoggedIn() async {
             SharedPreferences _shareprefs = await SharedPreferences.getInstance();
           bool isLogin=  _shareprefs.containsKey("user-data");
           if(isLogin){
            userInfo= await getUserInfo();
           }
           return isLogin;

           }

}