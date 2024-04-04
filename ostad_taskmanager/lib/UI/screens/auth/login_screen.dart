import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostad_taskmanager/UI/screens/auth/sign_up_screen.dart';

import 'package:ostad_taskmanager/UI/utility/assets_utils.dart';
import 'package:ostad_taskmanager/data/models/login_model.dart';
import 'package:ostad_taskmanager/data/services/network_caller.dart';

import '../../../data/models/auth_utility.dart';
import '../../../data/models/network_response.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/custom_TextField.dart';
import '../../widgets/screen_background.dart';
import '../bottom_nav_base_screen.dart';
import 'email_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loginInProgress = false;

  Future<void> login() async {
    _loginInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
    "email":_emailController.text.trim(),
    "password":_passwordController.text
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.login, requestBody,isLogin:true,);
    _loginInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
     // _emailController.clear();
     // _passwordController.clear();
    LoginModel model=LoginModel.fromJson(response.body!);
    await AuthUtility.saveUserInfo(model);
      if (mounted) {
        ScaffoldMessenger.of(context)
           .showSnackBar(const SnackBar(content: Text("Login Success")));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavBasicScreen()),
            (route) => false);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Incorrect email or password")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key:_formKey ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 75),
                  Text(
                    "Get Started With",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(
                    height: 16,
                  ),
                  //customTextField(TextInputType.emailAddress,false,"example@gmail.com", "write your email", Icons.email_outlined),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.green,
                        )),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your valid email";
                      }
                      return null;
                    },
                  ),
                  const Divider(
                    height: 16,
                  ),
                  //  customTextField(TextInputType.text, true,"password", "write your password", Icons.remove_red_eye_outlined),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.green,
                      ),
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "please enter your valid password";
                      }
                    },
                  ),
                  const Divider(
                    height: 16,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _loginInProgress == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              login();
                            },
                            child: const Icon(Icons.arrow_forward_ios)),
                      )),
                  const Divider(
                    height: 16,
                  ),
                  Center(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EmailVerificationScreen()));
                        },
                        child: const Text(
                          "Forget Password?",
                          style: TextStyle(color: Colors.grey),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupScreen()));
                          },
                          child: const Text("Sign up")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
