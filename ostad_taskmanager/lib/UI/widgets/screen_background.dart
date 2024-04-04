import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utility/assets_utils.dart';

Widget ScreenBackground(widget){
  return  Stack(
    children: [
      SizedBox(
        width:double.infinity ,
        height:double.infinity ,
        child:SvgPicture.asset(
          AssetsUtils.backgroundSVG,
          fit:BoxFit.cover ,
        ),
      ),
      SafeArea(child: widget),
    ],
  );
}
/// another way to create reusable widget for ScreenBackground
// class ScreenBackground extends StatelessWidget {
//   final Widget child;
//   const ScreenBackground({Key? key, required this.child}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           width:double.infinity ,
//           height:double.infinity ,
//           child:SvgPicture.asset(
//             AssetsUtils.backgroundSVG,
//             fit:BoxFit.fitHeight ,) ,
//
//         ),
//         child,
//
//       ],
//     );
//   }
// }