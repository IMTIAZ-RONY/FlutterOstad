import 'package:amarthikana_net/ui/responsive/size_config.dart';
import 'package:amarthikana_net/ui/screens/auth_screen/signup_screen.dart';
import 'package:amarthikana_net/utility/assets_utils.dart';
import 'package:amarthikana_net/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import 'login_screen.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ScreenBackground(
        child: SafeArea(
           child: Padding(
             padding: const EdgeInsets.all(12),
             child: Column(
               mainAxisAlignment:MainAxisAlignment.center ,
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(AssetsUtils.backgroundsecondSVG,fit:BoxFit.fitHeight ,),
                     Center(child: Transform.translate(
                       offset: const Offset(0,180 ),
                       child: ClipOval(child: Lottie.asset(AssetsUtils.logoLottie,
                         width:180 ,fit:BoxFit.scaleDown ,)),
                     )),
                  ],
                ),
                Transform.translate(
                  offset:const Offset(0,-200 ) ,
                  child: Row(

                    children: [
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder:(_)=>const LoginScreen() ));
                          },
                          style:ElevatedButton.styleFrom(elevation:5 ) ,
                          child: const Text ("Login",
                            style:TextStyle(fontSize:24,
                              fontWeight:FontWeight.w500,   ) ,)),
                      const Spacer(),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpScreen()));
                      },
                          child: const Text ("Sign Up ",
                        style:TextStyle(fontSize:24,
                          fontWeight:FontWeight.w500,   ) ,)),
                    ],
                  ),
                ),
              ],
          ),
           ),
        ),
      ) ,
    );
  }
}
