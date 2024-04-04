
import 'package:flutter/material.dart';
import 'package:ostad_taskmanager/UI/screens/auth/login_screen.dart';
import 'package:ostad_taskmanager/UI/widgets/screen_background.dart';
import 'package:ostad_taskmanager/data/services/network_caller.dart';
import 'package:ostad_taskmanager/data/utils/urls.dart';

import '../../../data/models/network_response.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email,otp;
  const ResetPasswordScreen({Key? key, required this.email, required this.otp}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  bool _setPasswordInProgress = false;

  Future<void>resetPassword() async {
    _setPasswordInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final Map<String, dynamic>requestBody = {
      "email":widget.email,
      "OTP":widget.otp,
      "password":passwordTEController.text,
    };
      final NetworkResponse response = await NetworkCaller().postRequest(
          Urls.resetPassword,
         requestBody);
      _setPasswordInProgress = false;
      if (mounted) {
        setState(() {});
        if (response.isSuccess) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
            Text("Password reset successful!")));
          }
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        }
      }else{
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
          Text("Password reset fail!")));
        }

      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        SingleChildScrollView(
          child: SafeArea (
             child: Padding(
              padding:const EdgeInsets.all(24.0) ,
              child: Form(
                key:_formKey ,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height:64),
                      Text(
                        "Set Password",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(
                        height: 4,
                      ),
                      Text(
                        "Minimum length password 8 character with latter and number combination",
                        style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Colors.grey ) ,
                      ),
                      const Divider(
                        height: 24,
                      ),
                      //customTextField(TextInputType.emailAddress,false,"example@gmail.com", "write your email", Icons.email_outlined),
                       TextFormField(
                         controller:passwordTEController,
                        keyboardType:TextInputType.text ,
                        obscureText:true ,
                        decoration: const InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.green,
                            )),
                         validator: (String?value){
                           if(value?.isEmpty??true){
                             return "Enter your new password";
                           }
                           return null;
                         },
                      ),
                       TextFormField(
                         controller:confirmPasswordTEController ,
                        keyboardType:TextInputType.text ,
                        obscureText:true ,
                        decoration: const InputDecoration(
                            hintText: "Confirm Password",
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.green,
                            )),
                         validator: (String?value){
                           if(value?.isEmpty??true){
                             return "Enter your confirm password";
                           }else if(value! !=passwordTEController.text){
                             return "Confirm password doesn\'t match";

                           }
                           return null;
                         },
                      ),
                      const Divider(
                        height: 16,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible:_setPasswordInProgress==false ,
                            replacement: const Center(child:CircularProgressIndicator() ,),
                            child: ElevatedButton(
                                onPressed: () {
                                  if(!_formKey.currentState!.validate()){
                                    return ;
                                  }
                                  resetPassword();
                                },
                                child:const Text ("Confirm")),
                          )),
                      const Divider(
                        height: 16,
                      ),Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account?",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5),
                          ),
                          TextButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: const Text("Sign in")),
                        ],
                      ),

                    ]

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

