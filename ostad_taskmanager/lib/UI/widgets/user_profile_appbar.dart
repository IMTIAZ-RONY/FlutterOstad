import 'package:flutter/material.dart';
import 'package:ostad_taskmanager/UI/screens/auth/login_screen.dart';

import 'package:ostad_taskmanager/data/models/auth_utility.dart';

import '../screens/update_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserProfileAppBar extends StatefulWidget {
  final bool? isUpdateScreen;
  const UserProfileAppBar({
    super.key,
    this.isUpdateScreen,
  });

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title:GestureDetector(
        onTap: () {
          if ((widget.isUpdateScreen ?? false) == false) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const UpdateProfileScreen()));
          }
        },
      child:Row(
        children: [
         Visibility(
           visible: (widget.isUpdateScreen ?? false) == false,
           child: Row(
             children: [
               CachedNetworkImage(
                 placeholder:(_,__)=>Image.asset('assets/images/person.jpg') ,
                 imageUrl: 'AuthUtility.userInfo.data?.photo ?? " "',
                 errorWidget: (_, __,___) =>
                    const Icon(Icons.account_circle_outlined),

               ),
             ],
           ),
         ),
          const SizedBox(width: 16,),
          Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children:[
              Text(
              "${AuthUtility.userInfo.data?.firstName ?? " "} ${AuthUtility.userInfo.data?.lastName ?? ""}",
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
              Text(
                AuthUtility.userInfo.data?.email ?? "Unknown",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ]
          ),
        ],
      ) ,
      ),

      actions:[
        IconButton(
        onPressed: () async {
      await AuthUtility.clearUserInfo();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false);
      }
    },
    icon: const Icon(Icons.logout),
        ) ]

         );

  }
}
