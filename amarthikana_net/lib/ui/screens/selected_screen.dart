
import 'package:amarthikana_net/ui/responsive/size_config.dart';
import 'package:amarthikana_net/ui/screens/complete_my_profile.dart';
import 'package:amarthikana_net/ui/screens/dash_board_screen.dart';
import 'package:amarthikana_net/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../utility/assets_utils.dart';

class SelectedScreen extends StatelessWidget {
  const SelectedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
         child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 220.0, // Adjust the expanded height as needed
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Lottie.asset(AssetsUtils.logoLottie),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         SizedBox(height: 20),
                        Text(
                          "Welcome AmarThikana",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                         SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {Navigator.push(context,
                              MaterialPageRoute(builder: (_)=>const CompleteMyProfile()));},
                          child: const Text("Complete my profile"),
                        ),
                         SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_)=>const DashBoardscreen()));},
                          child: const Text("Go to DashBoard"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
                 ),
      ),
    );
  }
}
