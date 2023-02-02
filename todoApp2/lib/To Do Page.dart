import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp2/style.dart';

class ToDoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ToDoPageView();
  }
}

class ToDoPageView extends State<ToDoPage> {
  List Todolist = [
    ];
        String item="";
  MyInputOnchanged(content){
    setState(() {
      item=content;
    });


  }
  AddItem(){
    setState(() {
      Todolist.add({'item':item});
    });
  }
  RemoveItem(index){
    setState(() {
      Todolist.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do"),
        centerTitle: true,
        elevation: 50,
        toolbarHeight: 60,
        toolbarOpacity: 1.0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 15,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.blue,
                child: Row(
                  children: [
                    Expanded(
                      flex:62,
                        child: TextFormField(onChanged:(content){
                          MyInputOnchanged(content);
                        } ,
                      decoration: AppInputDecoration("List Item"),
                    )
                    ),

                    Expanded(
                      flex:30 ,
                        child: Padding(
                          padding:  EdgeInsets.only(left:5,right: 3 ),
                          child: ElevatedButton(
                      onPressed: () {
                        AddItem();
                      },
                      child: Text(
                          "Add",style:TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                      ), ),
                          style: AppButtonStyle(),


                    ),
                        )
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 85,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.cyan,
                child: ListView.builder(
                    itemCount: Todolist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child:SizedBox50(
                          Row(
                            children: [
                              
                              Expanded(flex:80,child:Text(Todolist[index]['item'].toString(),) ),
                             
                              Expanded( flex:20,child:TextButton(onPressed: (){RemoveItem(index);}, child:Icon(Icons.delete)) ),
                            ],
                          )
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
