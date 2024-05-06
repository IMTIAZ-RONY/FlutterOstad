import 'package:amarthikana_net/ui/screens/address_add_screen.dart';
import 'package:amarthikana_net/widgets/screen_background.dart';
import 'package:flutter/material.dart';
class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Title(color:Colors.pink , child: Text("My Address",
        style:Theme.of(context).textTheme.titleLarge?.copyWith(color:Colors.pink) ,)) ,
      actions: [
        IconButton(onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (_)=>const AddressAddScreen()));
        }, icon:const Icon(Icons.add,color:Colors.yellow ,)),
      ],) ,
      body: const ScreenBackground(child: Column(
        children: [
          Text("Show here Data which preserve local store"),
        ],

      )),

    );
  }
}
