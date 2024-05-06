import 'dart:convert';
import 'dart:developer';
import 'package:amarthikana_net/data/models/network_response.dart';
import 'package:http/http.dart';

class NetworkCaller{
  ///Get Request
  Future<NetworkResponse >getRequest(String url)async{
try{
  Response response = await get(Uri.parse(url));
  if(response.statusCode==200){
    return NetworkResponse(response.statusCode,jsonDecode(response.body) , true);

  }else{
    return NetworkResponse(response.statusCode, null, false);

  }
}
catch(e){
  log((e).toString());
}
return NetworkResponse(-1, null, false);/// -1 holo amadher dhewa status code

  }
  /// Post Request
  Future<NetworkResponse >postRequest(String url,Map<String,dynamic>body)async{
    try{
      Response response = await post(Uri.parse(url),headers:{"Content-Type":"application/json"} ,
          body: jsonEncode (body));
      log(response.statusCode.toString());
      log(response.body);

      if(response.statusCode==200){
        return NetworkResponse(response.statusCode,jsonDecode(response.body) , true);

      }else{
        return NetworkResponse(response.statusCode, null, false);

      }
    }
    catch(e){
      log((e).toString());
    }
    return NetworkResponse(-1, null, false);/// -1 holo amadher dhewa status code

  }


}