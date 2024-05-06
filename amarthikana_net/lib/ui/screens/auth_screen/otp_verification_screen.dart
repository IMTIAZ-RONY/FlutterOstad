import 'package:amarthikana_net/ui/screens/auth_screen/reset_password_screen.dart';
import 'package:amarthikana_net/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'login_screen.dart';
class OTPVerifyScreen extends StatelessWidget {
  const OTPVerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ScreenBackground(child:
      SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(24.0) ,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height:64),
                Text(
                  "PIN Verification",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(
                  height: 4,
                ),
                Text(
                  "Input your  6 digits pin verification code ",
                  style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Colors.grey ) ,
                ),
                const Divider(
                  height: 24,
                ),
                //customTextField(TextInputType.emailAddress,false,"example@gmail.com", "write your email", Icons.email_outlined),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType:TextInputType.number ,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor:Colors.white,
                    inactiveColor:Colors.red,
                    selectedColor:Colors.green,
                    selectedFillColor:Colors.white,

                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  enableActiveFill: true,
                  cursorColor:Colors.green ,
                  enablePinAutofill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {

                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext:context ,
                ),
                const Divider(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context)=>const ResetPasswordScreen()),
                                  (route) => false);
                        },
                        child: const Text ("Verify",))),
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
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder:(context)=>const LoginScreen()),
                              (route) => false);
                    }, child: const Text("Sign in")),
                  ],
                ),

              ]

          ),
        ),
      ),) ,
    );
  }
}
