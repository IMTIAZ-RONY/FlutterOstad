import 'package:flutter/material.dart';
import 'package:ostad_taskmanager/UI/widgets/screen_background.dart';
import 'package:ostad_taskmanager/UI/widgets/user_profile_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ostad_taskmanager/data/models/auth_utility.dart';
import 'package:ostad_taskmanager/data/services/network_caller.dart';

import '../../data/models/login_model.dart';
import '../../data/models/network_response.dart';
import '../../data/utils/urls.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UserData userData= AuthUtility.userInfo.data!;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _mNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _profileInProgress=false;
  XFile? imageFile;
 ImagePicker picker = ImagePicker();// Pick an image.
  @override
  void initState() {
    _emailController.text =userData.email??'' ;
    _fNameController.text = userData.firstName??'';
    _lNameController.text =userData.lastName??'' ;
    _mNumberController.text = userData.mobile??'';
    super.initState();
  }
  Future<void>updateProfile() async {
    _profileInProgress=true;
    if (mounted) {
      setState(() {});
    }
    final Map<String,dynamic> requestBody={
      "email": _emailController.text.trim(),
      "firstName": _fNameController.text.trim(),
      "lastName": _lNameController.text.trim(),
      "mobile": _mNumberController.text.trim(),
      "photo": ""
    };
    if(_passwordController.text.isNotEmpty){
      requestBody["password"]=_passwordController.text;
    }
    final NetworkResponse response= await NetworkCaller().postRequest(Urls.updateProfile, requestBody);
    _profileInProgress=false;
    if (mounted) {
    setState(() {});
    }
    if (response.isSuccess) {
      userData.firstName=_fNameController.text.trim();
      userData.lastName=_lNameController.text.trim();
      userData.mobile=_mNumberController.text.trim();
      AuthUtility.updateUserInfo(userData);
      _passwordController.clear();
      if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile update success!")));
    }
  } else {
    if (mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Profile update failed,try again!")));
    }
    }



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ScreenBackground (
         SingleChildScrollView(
           child: Form(
             key: _formKey,
             child: Column(
              mainAxisAlignment:MainAxisAlignment.center ,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileAppBar(isUpdateScreen:true ,),
                const SizedBox(height:20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Update Profile",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(
                        height: 16,
                      ),
                       InkWell(
                         onTap: (){
                           selectImage();
                         },
                         child: Container(
                           width:double.infinity ,
                          decoration:const BoxDecoration(
                            color:Colors.white,
                          ) ,
                           child:Row(
                             children: [
                               Container(
                                 padding: const EdgeInsets.all(14),
                                 color:Colors.grey ,
                                 child:const Text ("Photos",style:TextStyle(color:Colors.white) ,) ,
                               ),
                               const SizedBox(width: 16,),
                                Visibility(
                                  visible: imageFile != null,
                                    child: Text(imageFile?.name??'')),
                             ],
                           ) ,

                                             ),
                       ),
                      const Divider(
                        height: 16,
                      ),
                      //customTextField(TextInputType.emailAddress,false,"example@gmail.com", "write your email", Icons.email_outlined),
                       TextFormField(
                        controller: _emailController,
                        readOnly: true,
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
                        obscureText:false,
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
                          child:_profileInProgress? const Center(
                              child: CircularProgressIndicator()): ElevatedButton(
                              onPressed: () {
                                updateProfile();
                              },
                              child: const Icon(Icons.arrow_forward_ios))),

                    ],
                  ),
                )

              ],
                       ),
           ),
        ),
      ),
    );
  }
  void selectImage(){
    picker.pickImage(source: ImageSource.gallery).then((xFile)  {
      if(xFile!=null){
        imageFile=xFile;
        if(mounted){
        setState(() {

        });}
      }
    });
  }
}

