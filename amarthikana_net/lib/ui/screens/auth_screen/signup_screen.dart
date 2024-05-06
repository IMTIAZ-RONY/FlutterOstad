import 'package:amarthikana_net/data/models/network_response.dart';
import 'package:amarthikana_net/ui/responsive/size_config.dart';
import 'package:amarthikana_net/ui/screens/auth_screen/login_screen.dart';
import 'package:amarthikana_net/ui/screens/auth_screen/signup_otp_verification.dart';
import 'package:amarthikana_net/ui/screens/selected_screen.dart';
import 'package:amarthikana_net/widgets/screen_background.dart';
import 'package:flutter/material.dart';

import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
//  String? _inputValue; // Variable to store user input

  // void sendOTP() {
  //   // Here you can add logic to send OTP to either mobile number or email based on the input
  //   if (_inputValue != null && _inputValue!.contains('@')) {
  //     // If input contains '@', consider it as an email
  //     // Send OTP to email
  //     print('Sending OTP to email: $_inputValue');
  //   } else {
  //     // If input does not contain '@', consider it as a mobile number
  //     // Send OTP to mobile number
  //     print('Sending OTP to mobile number: $_inputValue');
  //   }
  // }
  final TextEditingController _emailormobileTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileNumberTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpInProgress = false;
  Future<void> usersignUp() async {
    _signUpInProgress=true;
    if(mounted){
      setState(() {

      });
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, <String, dynamic>{
          "email": _emailormobileTEController.text.trim(),
          "firstName": _firstNameTEController.text.trim(),
          "lastName": _lastNameTEController.text.trim(),
          "mobile": _mobileNumberTEController.text.trim(),
          "password": _passwordTEController.text,
          "photo": ""


    });
    _signUpInProgress=false;
    if(mounted){
      setState(() {

      });
    }
    if (response.isSuccess) {
      _emailormobileTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _mobileNumberTEController.clear();
      _passwordTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Request Success")));
      }
    }
    else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Request Failed")));
      }
    }
    if(response.isSuccess){
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder:  (context)=>SignUpOTPVerifyScreen()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(

          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Join With Us",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _emailormobileTEController,
                  // onChanged: (value) => _inputValue = value,
                  decoration: const InputDecoration(
                    hintText: "email/mobile",
                  ),
                  validator: (String? value) {
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
                  controller: _firstNameTEController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "First Name",
                  ),
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || value!.length < 3) {
                      return "Enter your first name more than 2 letters";
                    }
                    return null;
                  },
                ),
                const Divider(
                  height: 16,
                ),
                TextFormField(
                  controller: _lastNameTEController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Last Name",
                  ),
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || value!.length < 3) {
                      return "Enter your last name more than 2 letters";
                    }
                    return null;
                  },
                ),
                const Divider(
                  height: 16,
                ),
                TextFormField(
                  controller: _mobileNumberTEController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Mobile",
                  ),
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || value!.length < 11) {
                      return "Enter your valid  mobile number";
                    }
                    return null;
                  },
                ),

                const Divider(
                  height: 16,
                ),

                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "password",
                  ),
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || value!.length <= 5) {
                      return "Enter a password more than 5 letters";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _signUpInProgress==false,
                      replacement:const Center(child: CircularProgressIndicator(
                      )) ,
                      child: ElevatedButton(
                          // onPressed: sendOTP,
                          // onPressed: () {Navigator.push(context,
                          //     MaterialPageRoute(builder: (_)=>const SelectedScreen()));},
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            usersignUp();
                          },
                          child: const Icon(Icons.arrow_forward_ios)),
                    )),
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
        ),
      )),
    );
  }
}
