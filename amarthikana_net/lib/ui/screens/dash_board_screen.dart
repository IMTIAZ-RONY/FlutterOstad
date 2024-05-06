
import 'package:amarthikana_net/data/models/auth_utility.dart';
import 'package:amarthikana_net/ui/screens/my_address_screen.dart';
import 'package:amarthikana_net/ui/screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';

import 'auth_screen/login_screen.dart';





class DashBoardscreen extends StatefulWidget {
   const DashBoardscreen({Key? key}) : super(key: key);

  @override
  State<DashBoardscreen> createState() => _DashBoardscreenState();
}

class _DashBoardscreenState extends State<DashBoardscreen> {


 Future _exitDialog(context) async {
   return await showDialog(context: context, builder: (_){
     return AlertDialog(
       backgroundColor:Colors.yellow ,
       title:const Text("Are you sure "
           "you want to get out from dashboard?",style:TextStyle(fontSize:14 ) ,) ,
       content:Row(
         children: [
           ElevatedButton(onPressed: ()=>Navigator.pop(context),
           child:const Text ("No"),),
           Spacer(),
           ElevatedButton(onPressed: ()async {
           await  AuthUtility.clearUserInfo();
           Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
               builder: (_)=>const LoginScreen()), (route) => false);

           }, child:const Text ("Yes"),),
           //SystemNavigator.pop()
         ],
       ),
     );
   });

 }
 late final GoogleMapController _googleMapController;

   Location location =  Location();
   bool? _serviceEnabled;
   PermissionStatus? _permissionGranted;
   LocationData? _locationData;
   late AudioPlayer audioPlayer;


   getLocation() async {
     _serviceEnabled = await location.serviceEnabled();
     if (!_serviceEnabled!) {
       _serviceEnabled = await location.requestService();
       if (!_serviceEnabled!) {
         return;
       }
     }

     _permissionGranted = await location.hasPermission();
     if (_permissionGranted == PermissionStatus.denied) {
       _permissionGranted = await location.requestPermission();
       if (_permissionGranted != PermissionStatus.granted) {
         return;
       }
     }
     _locationData = await location.getLocation();
     setState(() {

     });
     print(_locationData);

   }
   final Set<Marker>markers={};
   addMarker(){
     setState(() {
       markers.add(
           Marker(markerId:MarkerId('current-location'),
           position:LatLng(_locationData!.latitude!.toDouble(), _locationData!.longitude!.toDouble()),
           icon:BitmapDescriptor.defaultMarker ,
           infoWindow:InfoWindow(title: "My location ") )
           );

     });
   }
   @override
  void initState() {
    getLocation();
    audioPlayer = AudioPlayer();
    _playWelcomeMessage();
    super.initState();
  }

  _playWelcomeMessage()async{

   await audioPlayer.setAsset('audio/welcome-messege.mp3');
   audioPlayer.play();

  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked:(bool didPop)async{
         await showDialog(context: context, builder:(_)=>AlertDialog(
           title: const Text("Are you sure do you want to exit the app",
             style: TextStyle(fontSize:14 ),),
           actions: [
             ElevatedButton(onPressed: (){
               Navigator.of(context).pop(false);
         }, child:const Text('No') ,),
             const Spacer(),
             ElevatedButton(onPressed: (){
               SystemNavigator.pop();
         }, child:const Text('Yes') ,),
           ],
         ));
      } ,

      child: Scaffold(
        appBar: AppBar(
          title: Title(
            color: Colors.purple,
            child: Text(
              "DashBoard",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.purple),
            ),
          ),
          centerTitle: true,
          elevation: 5,
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.search),
              label: const Text("Search"),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor:Colors.tealAccent ,
          child: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.pink, // Drawer header color
                ),
                child: DrawerHeader(
                  padding: const EdgeInsets.all(0),
                  child: UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.pink, // Circular part color
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage:NetworkImage(
                          AuthUtility.userInfo.data?.photo??""
                      ) ,
                      onBackgroundImageError: (_,__){
                       const Icon(Icons.image);
                      },

                    ),
                    accountName:  Text(
                   "${AuthUtility.userInfo.data?.firstName??""}${AuthUtility.userInfo.data?.lastName??""}",
                    ),
                    accountEmail:  Text(AuthUtility.userInfo.data?.email??"Unknown"),
                  ),
                ),
              ),
            const SizedBox(height: 20,),

              Container(
                color: Colors.blue,
                child:ListTile(
                  leading: const Icon(Icons.edit,color:Colors.yellow ,),
                  title: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white), // Text color
                  ),
                  onTap: () {},
                ),),
              const SizedBox(height: 12,),
               Container(
                 color:Colors.purple ,
                 child:ListTile(

                 leading: const Icon(Icons.home_outlined,color:Colors.yellow,),
                 title: const Text(
                   "My Address",
                   style: TextStyle(color: Colors.white),
                 ),
                 onTap: () {
                   Navigator.push(context,MaterialPageRoute(builder: (_)=>const MyAddressScreen()));
                 },
               ),),
             const SizedBox(height: 12,),
               Container(
                 color:Colors.green ,
                 child:ListTile(

                 leading: const Icon(Icons.wallet,color:Colors.yellow ,),
                 title: const Text(
                   "Wallet",
                   style: TextStyle(color: Colors.white),
                 ),
                 onTap: () {Navigator.push(context,
                     MaterialPageRoute(builder:(_)=>const WalletScreen() ));
                   },
               ),),
               const SizedBox(height: 12,),
               Container(
                 color:Colors.red ,
                 child:ListTile(
                 leading: const Icon(Icons.logout,color:Colors.yellow ,),
                 title: const Text(
                   "Logout",
                   style: TextStyle(color: Colors.white),
                 ),
                 onTap:(){_exitDialog (context);},
               ),),

            ],
          ),
        ),
        body: _locationData!=null?
        GoogleMap(
          mapType:MapType.normal ,
            initialCameraPosition:CameraPosition(
                target:LatLng(_locationData!.latitude!.toDouble(), _locationData!.longitude!.toDouble()),
                 zoom:15,
                 bearing:30,
                 tilt: 10,
            ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          trafficEnabled: true,
          onMapCreated:(GoogleMapController controller){
            _googleMapController=controller;
            addMarker();
            print("on map created");

          } ,
          markers: markers,
          compassEnabled: true,
          onTap: (LatLng l){
            print(l);
          },

        ):const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
