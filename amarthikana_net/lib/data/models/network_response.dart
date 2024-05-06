class NetworkResponse{
      final int statusCode;
   final Map<String,dynamic>? body;
 final  bool isSuccess;

  NetworkResponse(this.statusCode, this.body,this.isSuccess);


}