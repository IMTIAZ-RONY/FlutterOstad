import 'package:amarthikana_net/data/models/auth_utility.dart';
import 'package:amarthikana_net/ui/screens/auth_screen/choose_screen.dart';
import 'package:amarthikana_net/ui/screens/dash_board_screen.dart';
import 'package:amarthikana_net/utility/assets_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/screen_background.dart';
class SplashScreen  extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToChooseScreen();
  }
  void navigateToChooseScreen(){
    Future.delayed(const Duration(seconds:6 )).then( (_)async{
      final bool isLoggedIn=await AuthUtility.checkIfUserLoggedIn();
      if(mounted){
        Navigator.pushAndRemoveUntil (context,
            MaterialPageRoute(builder:(context)=>isLoggedIn?const DashBoardscreen(): const ChooseScreen()) ,
                (route) => false);
      }



    });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ScreenBackground(child:
        SafeArea(
          child: Center(
          
              child:Column(
                children: [
                  SizedBox(height:130,),
          Text("AMAR THIKANA",style:Theme.of(context).textTheme.titleLarge ,),
          ClipOval(
            child:Lottie.asset(AssetsUtils.logoLottie,width:180,fit:BoxFit.scaleDown ,) ,
          
          ),
                ],
              ),
              ),
        ) ,));

  }
}
