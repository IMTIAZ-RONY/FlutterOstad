import 'package:amarthikana_net/data/models/auth_utility.dart';
import 'package:amarthikana_net/data/models/login_model.dart';
import 'package:amarthikana_net/data/models/network_response.dart';
import 'package:amarthikana_net/data/services/network_caller.dart';
import 'package:amarthikana_net/data/utils/urls.dart';
import 'package:amarthikana_net/ui/screens/auth_screen/signup_screen.dart';
import 'package:amarthikana_net/ui/screens/dash_board_screen.dart';
import 'package:amarthikana_net/ui/screens/email_verification_screen.dart';
import 'package:amarthikana_net/ui/screens/selected_screen.dart';
import 'package:amarthikana_net/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../responsive/size_config.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailormobileTEController= TextEditingController();
  final TextEditingController _passwordTEController= TextEditingController();
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  bool _loginInProgress=false;
  Future<void>login()async{
     _loginInProgress=true;
    if(mounted) {
      setState(() {

      });}
    Map<String,dynamic>requestBody={
      "email":_emailormobileTEController.text.trim(),
      "password":_passwordTEController.text,
    };

   final NetworkResponse response= await NetworkCaller().postRequest(Urls.userlogin,requestBody);

     _loginInProgress=false;
     if(mounted) {
       setState(() {

       });}
     if(response.isSuccess){
           LoginModel model= LoginModel.fromJson(response.body!);
           await AuthUtility.svaeUserInfo(model);
       if(mounted){
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Success")));
         Navigator.pushAndRemoveUntil(context,
             MaterialPageRoute(builder:(context)=>const SelectedScreen() ), (route) => false);
       }

     }else{
       if(mounted){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Enter your valid information")));
       }

     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
           padding: const EdgeInsets.all(24.0),
           child:  SingleChildScrollView(
              child: Form(
               key: _formKey,
                child: Column(

                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(
                     "Get Started With",
                      style:Theme.of(context).textTheme.titleLarge ,
                   ),
                    const SizedBox(
                     height: 16,
                   ),
                   TextFormField(
                     controller:_emailormobileTEController ,
                     keyboardType:TextInputType.emailAddress ,
                     decoration: const InputDecoration(
                       hintText: "email/mobile",
                     ),
                     validator: (String? value){
                       if (value?.isEmpty ?? true) {
                         return "Enter your email or mobile number";
                       } else if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                           .hasMatch(value!) &&
                           !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                         return "Enter a valid email or mobile number";
                       }
                       return null; // Return null if validation passes

                     },
                   ),
                     const SizedBox(
                     height: 12,
                    ),
                   TextFormField(
                     controller: _passwordTEController,
                     keyboardType:TextInputType.text ,
                     obscureText: true,
                     decoration: const InputDecoration(
                       hintText: "password",
                     ),
                     validator: (String?value){
                       if(value?.isEmpty??true){
                         return "Please enter your valid password";
                       }
                       return null;// Return null if validation is passed.
                     },
                   ),
                    const SizedBox(
                     height: 16,
                   ),
                   SizedBox(
                       width: double.infinity,
                       child: Visibility(
                         visible:_loginInProgress==false ,
                         replacement:const Center(child: CircularProgressIndicator()) ,
                         child: ElevatedButton(
                             onPressed: () {
                               if(!_formKey.currentState!.validate()){
                                return;
                               }
                               login();
                             },
                             child: const Icon(Icons.arrow_forward_ios)),
                       )),
                    const SizedBox(
                     height: 16,
                   ),

                   Center(
                     child: InkWell(
                         onTap: () {
                           Navigator.push(context,MaterialPageRoute(builder:  (_)=>EmailVericationScreen()));
                         },
                         child: const Text(
                           "Forget Password?",
                           style: TextStyle(
                               color: Colors.grey,
                               fontWeight: FontWeight.w400),
                         )),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       const Text("Don't have an account?",
                           style: TextStyle(
                             color: Colors.black,
                             fontWeight: FontWeight.w500,
                             letterSpacing: 0.6,
                           )),
                       TextButton(
                           onPressed: () {
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (_) => const SignUpScreen()));
                           },
                           child: const Text("Sign up"))
                     ],
                   )
                 ],
               ),
                           ),
           ),
            )),
    );
  }
}
