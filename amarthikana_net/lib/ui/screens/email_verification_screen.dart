import 'package:amarthikana_net/ui/screens/auth_screen/otp_verification_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/screen_background.dart';

class EmailVericationScreen extends StatelessWidget {
  const EmailVericationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child:  Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height:75,),
                  Text(
                    "Your Email Address",
                    style:Theme.of(context).textTheme.titleLarge ,
                  ),
                  const SizedBox(height: 6,),
                  Text(
                    "A 6 digit verification pin will send to your email address",
                    style:Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:Colors.grey,
                    ) ,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    keyboardType:TextInputType.emailAddress ,
                    decoration: const InputDecoration(
                      hintText: "email",
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (_)=>OTPVerifyScreen()), (route) => false);
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined))),
                  const SizedBox(
                    height: 16,
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.6,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Sign In"))
                    ],
                  )
                ],
              ),
            ),
          )),

    );
  }
}
