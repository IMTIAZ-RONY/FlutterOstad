import 'package:flutter/material.dart';
import 'package:ostad_taskmanager/UI/screens/auth/otp_verification_screen.dart';
import 'package:ostad_taskmanager/UI/widgets/screen_background.dart';
import 'package:ostad_taskmanager/data/models/network_response.dart';
import 'package:ostad_taskmanager/data/services/network_caller.dart';

import '../../../data/utils/urls.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _emailVerificationInProgress = false;
  Future<void> _sendOTPtoEmail() async {
    _emailVerificationInProgress = true;
    if(mounted){
      setState(() {});}
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.sendOtptoEmail(_emailTEController.text.trim()));
    _emailVerificationInProgress = false;
    if(mounted){
    setState(() {});}

    if (response.isSuccess) {
      if(mounted){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  OTPVerificationScreen(
                email: _emailTEController.text.trim(),)),);
      }
    }else{
      if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar
        (content:Text("Email verification has been failed") ));
  }}}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 64),
                      Text(
                        "Your Email Address",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(
                        height: 4,
                      ),
                      Text(
                        "A 6 digits pin verification will  send to your email address",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                      const Divider(
                        height: 24,
                      ),
                      //customTextField(TextInputType.emailAddress,false,"example@gmail.com", "write your email", Icons.email_outlined),
                      TextFormField(
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.green,
                            )),
                      ),
                      const Divider(
                        height: 16,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible:_emailVerificationInProgress==false ,
                            replacement:const Center(child:CircularProgressIndicator() ,) ,
                            child: ElevatedButton(
                                onPressed: () {
                                  _sendOTPtoEmail();
                                },
                                child: const Icon(
                                    Icons.arrow_circle_right_outlined)),
                          )),
                      const Divider(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account?",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Sign in")),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

}

