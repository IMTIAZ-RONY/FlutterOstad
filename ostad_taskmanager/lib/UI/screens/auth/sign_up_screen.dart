import 'package:flutter/material.dart';
import 'package:ostad_taskmanager/data/models/network_response.dart';
import 'package:ostad_taskmanager/data/utils/urls.dart';
import '../../../data/services/network_caller.dart';
import '../../widgets/screen_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _mNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpProgress = false;

  Future<void> userSignUp() async {
    _signUpProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "firstName": _fNameController.text.trim(),
      "lastName": _lNameController.text.trim(),
      "mobile": _mNumberController.text.trim(),
      "password": _passwordController.text,
      "photo": ""
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, requestBody);
    _signUpProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _emailController.clear();
      _fNameController.clear();
      _lNameController.clear();
      _mNumberController.clear();
      _passwordController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration success!")));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Registration faild!")));
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
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 75),
                  Text(
                    "Joined With Us",
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
                        return "Enter your email";
                      }
                      return null;
                    },
                  ),
                  const Divider(
                    height: 16,
                  ),
                  //  customTextField(TextInputType.text, true,"password", "write your password", Icons.remove_red_eye_outlined),
                  TextFormField(
                    controller: _fNameController,
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
                    controller: _lNameController,
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
                    controller: _mNumberController,
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
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.green,
                      ),
                    ),
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || value!.length <= 5) {
                        return "Enter your password";
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
                        visible: _signUpProgress == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              userSignUp();
                            },
                            child: Icon(Icons.arrow_forward_ios)),
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
