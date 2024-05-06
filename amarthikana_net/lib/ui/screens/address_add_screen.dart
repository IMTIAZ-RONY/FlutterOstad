import 'package:amarthikana_net/widgets/screen_background.dart';
import 'package:flutter/material.dart';

class AddressAddScreen extends StatefulWidget {
  const AddressAddScreen({Key? key}) : super(key: key);

  @override
  State<AddressAddScreen> createState() => _AddressAddScreenState();
}

class _AddressAddScreenState extends State<AddressAddScreen> {
  bool _isChecked=false;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ScreenBackground(child:SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              const SizedBox(height:40 ,),
              Text ("Add Your Address",
                style:Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.purple) ,),
              const SizedBox(height:24 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Full Name",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.number ,
                decoration: const InputDecoration(
                  hintText: "Mobile Number",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "NID number",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Birth Certificate",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.number ,
                decoration: const InputDecoration(
                  hintText: "Holding No.",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.number ,
                decoration: const InputDecoration(
                  hintText: "Word Number",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Sector",
                ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Sector Number ",
                ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Road/Street ",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Village/Area",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Post Office",
              ),),
              
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Union",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Municipality",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "City Corporation",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Distric",
              ),),
              const SizedBox(height:12 ,),
              TextFormField(
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Division",
              ),),
              const SizedBox(height:16 ,),
              CheckboxListTile(
                title: const Text("Get Latitude & Longitude"),
                tileColor:Colors.black ,
                activeColor:Colors.green ,
                  checkColor:Colors.black ,
                  controlAffinity:ListTileControlAffinity.leading ,
                  tristate:true ,
                  value:_isChecked , onChanged:(bool? newValue){
                    setState(() {
                      _isChecked=newValue!;

                    });
              }),
              const SizedBox(height:24 ,),
              SizedBox(
                width:double.infinity ,
                  child: ElevatedButton(onPressed: (){}, child:const Text("Add",style:TextStyle(color:Colors.white ,) ,),)),

            ],
          ),
        ),
      ) ) ,
    );
  }
}
