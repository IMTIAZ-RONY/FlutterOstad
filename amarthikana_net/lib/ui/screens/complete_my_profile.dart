import 'dart:io';

import 'package:amarthikana_net/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class CompleteMyProfile extends StatefulWidget {
  const  CompleteMyProfile({Key? key}) : super(key: key);

  @override
  State<CompleteMyProfile> createState() => _CompleteMyProfileState();
}

class _CompleteMyProfileState extends State<CompleteMyProfile> {
  final ImagePicker _picker = ImagePicker();
   XFile? image;
  chooseImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Image Source"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                XFile? pickedImage =
                await _picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null && mounted) {
                  setState(() {
                    image = pickedImage;
                  });
                }
              },
              child: const Text("Gallery"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                XFile? pickedImage =
                await _picker.pickImage(source: ImageSource.camera);
                if (pickedImage != null && mounted) {
                  setState(() {
                    image = pickedImage;
                  });
                }
              },
              child: const Text("Camera"),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(

       child: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center ,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //const SizedBox(height:20),
                Text(
                  "Update Profile",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(
                  height: 16,
                ),

                 image==null?
                  IconButton(onPressed: ()=>
                    chooseImage()
                  , icon:Icon(Icons.camera)):
                   SizedBox(height: 100,
                     child: ClipRRect(borderRadius: BorderRadius.circular (20),
                         child: Image.file(File(image!.path))),
                   ),

                const Divider(
                  height: 16,
                ),
                //customTextField(TextInputType.emailAddress,false,"example@gmail.com", "write your email", Icons.email_outlined),
                 TextFormField(
                  keyboardType:TextInputType.text ,
                  decoration: const InputDecoration(
                    hintText: "Full Name",
                  ),
                ),
                const Divider(
                  height: 16,
                ),
                //  customTextField(TextInputType.text, true,"password", "write your password", Icons.remove_red_eye_outlined),
                 TextFormField(
                  keyboardType:TextInputType.text ,
                  decoration: const InputDecoration(
                    hintText: "NID",

                  ),
                ),
                const Divider(
                  height: 16,
                ),
                 TextFormField(
                  keyboardType:TextInputType.text ,
                  decoration: const InputDecoration(
                    hintText: "Birth",

                  ),
                ),
                const Divider(
                  height: 16,
                ),
                 TextFormField(
                  keyboardType:TextInputType.number ,
                  decoration: const InputDecoration(
                    hintText: "Mobile",

                  ),
                ),
                const Divider(
                  height: 16,
                ),
                TextFormField(
                  keyboardType:TextInputType.text ,
                  decoration: const InputDecoration(
                    hintText: "Email",

                  ),
                ),
                const Divider(
                  height: 16,
                ),
                TextFormField(
                  keyboardType:TextInputType.text ,
                  decoration: const InputDecoration(
                    hintText: "Password",

                  ),
                ),
                const Divider(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child:const Text("Update"))),


              ],
            ),
          ),
        ),
      ),

    );
  }
}

