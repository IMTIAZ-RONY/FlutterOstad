import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad_taskmanager/UI/screens/bottom_nav_base_screen.dart';
import 'package:ostad_taskmanager/UI/utility/assets_utils.dart';
import 'package:ostad_taskmanager/UI/widgets/screen_background.dart';
import '../../data/models/auth_utility.dart';
import 'auth/login_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    navigateToLogin();
  }
  Future<void> navigateToLogin() async {

    Future.delayed( const Duration(seconds:6)).then((_) async {
      final bool isLoggedIn=await AuthUtility.checkIfUserLoggedIn();
     if(mounted){
       //Get.offAll(
        //   ()=> isLoggedIn?const BottomNavBasicScreen() : const LoginScreen()
     //  );

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=>
            isLoggedIn?const BottomNavBasicScreen() : const LoginScreen()),
                (route) => false);

     }
        });
    //OR another way....below
    // Future<void>navigateToLogin()async{
    //   await Future.delayed(Duration(seconds:6 ));
    //   Navigator.pushAndRemoveUntil(context,
    //       MaterialPageRoute(builder:(context)=>LoginScreen()), (route) => false);
    // }

  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ScreenBackground(
        Center(
        child: SvgPicture.asset(
          AssetsUtils.logoSVG,
          width:90 ,
          fit:BoxFit.scaleDown ,),
      ),),

    );
  }
}
