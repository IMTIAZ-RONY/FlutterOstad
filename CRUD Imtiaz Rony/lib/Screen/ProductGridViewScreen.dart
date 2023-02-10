import 'package:crud/Screen/ProductUpdateScreen.dart';
import 'package:crud/Style/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crud/Screen/ProductCreateScreen.dart';
import '../RestAPI/RestClient.dart';
import 'package:draggable_fab/draggable_fab.dart';
class ProductGridViewScreen extends StatefulWidget {

  ProductGridViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductGridViewScreen> createState() => ProductGridViewScreenState();
}

class ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List ProductList = [];
  bool Loading = true;
  @override
  void initState() {
    CallData();
    super.initState();
  }

  CallData() async {
    Loading = true;
    var data = await ProductGridViewListRequest();
    //print(data);
    setState(() {
      ProductList = data;
      Loading = false;
    });
  }


  DeleteItem(id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete!"),
            content: Text("Once delete you cann't get it back."),
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      Loading = true;
                    });
                    await ProductDeleteRequest(id);
                    await CallData();
                  },
                  child: Text("Yes")),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No")),
            ],
          );
        });
  }

  GotoUpdate(context,productItem) {
    Navigator.push(context,
        MaterialPageRoute(builder: (builder) => ProductUpdateScreen(productItem)));
  }

  @override
  Widget build(BuildContext context) {
    print(ProductList);
    return Scaffold(
      appBar: AppBar(
        title: Text(" List Product",style:TextStyle(color:Colors.yellow, ) ,),
        toolbarOpacity: 1.0,
        toolbarHeight: 60,
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: Loading ? (Center(child: CircularProgressIndicator())) : RefreshIndicator(
                    onRefresh: () async {
                      await CallData();
                    },
                    child: GridView.builder(
                        gridDelegate: ProductGridViewStyle(),
                        itemCount: ProductList.length,
                        itemBuilder: (context, index) {

                          var productList =  List.from(ProductList.reversed);

                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                    child: Image.network(
                                        (productList[index]['Img'].toString()),
                                        fit: BoxFit.fill)),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(productList[index]['ProductName'].toString()),
                                      SizedBox(height: 7),
                                      Text("Price:" +
                                          productList[index]['UnitPrice'] .toString()+
                                          "BDT"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          OutlinedButton(
                                              onPressed: () {
                                                GotoUpdate(context,productList[index]);
                                              },
                                              child: Icon(
                                                CupertinoIcons
                                                    .ellipsis_vertical_circle,
                                                size: 18,
                                                color: colorGreen,
                                              )),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          OutlinedButton(
                                              onPressed: () {
                                                DeleteItem(
                                                    productList[index]["_id"].toString());
                                              },
                                              child: Icon(
                                                CupertinoIcons.delete,
                                                size: 18,
                                                color: colorRed,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
          ),
        ],
      ),
      floatingActionButton:DraggableFab(
        child:
            FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => ProductCreateScreen()));
            },
            child: Icon(Icons.add,color:Colors.yellow,size:35  ,),
            ),

      ),
    );
  }
}
