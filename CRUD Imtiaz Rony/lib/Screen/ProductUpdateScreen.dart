

import 'package:crud/Screen/ProductGridViewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../RestAPI/RestClient.dart';
import '../Style/Style.dart';
class ProductUpdateScreen extends StatefulWidget {
  final Map productItem;
  const ProductUpdateScreen(this.productItem) ;

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  Map<String,String>FormValues={"Img":"","ProductName":"","ProductCode":"","Qty":"","TotalPrice":"","UnitPrice":"",};
  bool Loading=false;

  @override
  void initState(){
    setState(() {
      FormValues.update("Img", (value) => widget.productItem["Img"]);
      FormValues.update("ProductName", (value) => widget.productItem["ProductName"]);
      FormValues.update("ProductCode", (value) => widget.productItem["ProductCode"]);
      FormValues.update("Qty", (value) => widget.productItem["Qty"]);
      FormValues.update("TotalPrice", (value) => widget.productItem["TotalPrice"]);
      FormValues.update("UnitPrice", (value) => widget.productItem["UnitPrice"]);

    });

  }

  InputOnChange(Mapkey ,Textvalue){
    setState(() {
      FormValues.update(Mapkey, (value) => Textvalue);
    });

  }
  FormOnSubmit()async{
    if(FormValues["Img"]!.length==0){
      ErrorToast("Image Required !");
    }
    else if(FormValues["ProductName"]!.length==0){
      ErrorToast("ProductCode Required !");
    }
    else if(FormValues["ProductCode"]!.length==0){
      ErrorToast("ProductCode Required !");
    }
    else if(FormValues["Qty"]!.length==0){
      ErrorToast("Quantity Required !");
    }
    else if(FormValues["TotalPrice"]!.length==0){
      ErrorToast("TotalPrice Required !");
    }
    else if(FormValues["UnitPrice"]!.length==0){
      ErrorToast("UnitPrice Required !");
    }
    else{
      setState(() {
         Loading=true;
      });
      await ProductUpdateRequest(FormValues,widget.productItem["_id"]);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ProductGridViewScreen()),
              (Route route) => false);
     //await CallData();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
              child: Loading?(Center(child:CircularProgressIndicator() ,)):(SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue:FormValues["ProductName"],
                      onChanged: (Textvalue) {
                        InputOnChange("ProductName", Textvalue);
                      },
                      decoration: AppInputDecoration('Product Name'),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue:FormValues["ProductCode"],
                      onChanged: (Textvalue) {
                        InputOnChange("ProductCode", Textvalue);
                      },
                      decoration: AppInputDecoration('Product Code'),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue:FormValues["Img"],
                      onChanged: (Textvalue) {
                        InputOnChange("Img", Textvalue);
                      },
                      decoration: AppInputDecoration('Product Image'),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue:FormValues["TotalPrice"],
                      onChanged: (Textvalue) {
                        InputOnChange("TotalPrice", Textvalue);
                      },
                      decoration: AppInputDecoration('Total Price'),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue:FormValues["UnitPrice"],
                      onChanged: (Textvalue) {
                        InputOnChange("UnitPrice", Textvalue);
                      },
                      decoration: AppInputDecoration('Unit Price'),
                    ),
                    SizedBox(height: 20),
                    AppDropDownStyle(
                      DropdownButton(
                        value:FormValues["Qty"] ,
                        items: [
                          DropdownMenuItem(
                            child: Text("Select Qty"),
                            value: "",
                          ),
                          DropdownMenuItem(
                            child: Text("1 pcs"),
                            value: "1 pcs",
                          ),
                          DropdownMenuItem(
                            child: Text("2 pcs"),
                            value: "2 pcs",
                          ),
                          DropdownMenuItem(
                            child: Text("3 pcs"),
                            value: "3 pcs",
                          ),
                          DropdownMenuItem(
                            child: Text("4 pcs"),
                            value: "4 pcs",
                          ),
                        ],
                        onChanged: (Textvalue) {
                          InputOnChange("Qty", Textvalue);
                        },
                        underline: Container(),
                        isExpanded: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: ElevatedButton(
                        style:AppButtonStyle() ,
                        onPressed: () {
                          FormOnSubmit();
                        },
                        child: SuccessButtonChild("Submit"),
                      ),
                    ),
                  ],
                ),
              ))
          ),
        ],
      ),
    );
  }
}
