import 'package:amarthikana_net/ui/screens/qr_scanner.dart';
import 'package:amarthikana_net/widgets/screen_background.dart';
import 'package:amarthikana_net/widgets/summary_card.dart';
import 'package:flutter/material.dart';
class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar:AppBar(
    //     title:Text("Wallet",
    //     style:Theme.of(context).textTheme.titleLarge?.copyWith(color:Colors.pink ),
    //     ) ,
    //   centerTitle:true ,) ,
    //   body:ScreenBackground(
    //       child:
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Stack(
    //
    //     children: [
    //           SizedBox(height:70 ,),
    //
    //           Positioned(
    //             child: SizedBox(
    //               height:100,
    //               width:double.infinity ,
    //               child: SummaryCard(title:"Address" ,
    //               color:Colors.pink ,),
    //
    //             ),
    //           ),
    //           SizedBox(
    //             height: 100,
    //             width: double.infinity,
    //             child:
    //             SummaryCard(title:"Address",
    //             color: Colors.yellow,),
    //           ),
    //           SizedBox(
    //             height: 100,
    //             width:double.infinity ,
    //             child: SummaryCard(title:"Address" ,color: Colors.teal,),
    //
    //           ),
    //           SizedBox(
    //             height:100 ,
    //             width:double.infinity ,
    //             child:SummaryCard(title:"Address",
    //             color:Colors.red ,),
    //
    //           ),
    //           SizedBox(
    //             height: 100,
    //             width: double.infinity,
    //             child: SummaryCard(title:"Address",color:Colors.orangeAccent ),
    //           ),
    //
    //
    //     ],
    //
    //         ),
    //       )) ,
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wallet",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.pink),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,
              MaterialPageRoute(builder:(_)=> const QRScanner()), );},
            icon:const Icon(Icons.qr_code_scanner), style:  ButtonStyle(
        iconSize: MaterialStatePropertyAll(30),
    iconColor: MaterialStatePropertyAll(Colors.amber.shade900),
    backgroundColor: MaterialStatePropertyAll(Colors.white70)
    ) ,),
        ],

      ),
      body:  ScreenBackground(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(children: [
                Positioned(
                  top: 0,
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: SummaryCard(
                      title: "Address",
                      color: Colors.pink,
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: SummaryCard(
                      title: "Address",
                      color: Colors.yellow,
                    ),
                  ),
                ),
                Positioned(
                  top: 240,
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: SummaryCard(
                      title: "Address",
                      color: Colors.teal,
                    ),
                  ),
                ),
                Positioned(
                  top: 360,
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: SummaryCard(
                      title: "Address",
                      color: Colors.red,
                    ),
                  ),
                ),
                Positioned(
                  top: 480,
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: SummaryCard(
                      title: "Address",
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ],)

              ],
            ),
          ),
        ),
      ),
    );
  }
  }

