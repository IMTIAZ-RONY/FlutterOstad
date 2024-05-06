import 'package:amarthikana_net/widgets/screen_background.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
class ResetPasswordScreen extends StatelessWidget {
  const  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ScreenBackground(
        child: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(24.0) ,
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
                const TextField(
                  keyboardType:TextInputType.text ,
                  obscureText:true ,
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.green,
                      )),
                ),
                const TextField(
                  keyboardType:TextInputType.text ,
                  obscureText:true ,
                  decoration: InputDecoration(
                      hintText: "Confirm Password",

                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.green,
                      )),
                ),
                const Divider(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context)=>const LoginScreen()),
                                  (route) => false);
                        },
                        child:const Text ("Confirm"))),
                const Divider(
                  height: 16,
                ),Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account?",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5),
                    ),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text("Sign in")),
                  ],
                ),

              ]

          ),
        ),
      ),) ,
    );
  }
}
