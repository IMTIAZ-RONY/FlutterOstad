import 'package:flutter/material.dart';
import 'package:ostad_taskmanager/UI/widgets/user_profile_appbar.dart';
import 'package:ostad_taskmanager/data/models/network_response.dart';
import 'package:ostad_taskmanager/data/services/network_caller.dart';

import '../../data/utils/urls.dart';
import '../widgets/screen_background.dart';
class  AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTextController= TextEditingController();
  final TextEditingController _descriptionTextController= TextEditingController();
  bool _addNewTaskInProgress=false;
    // Future<void>addNewTask()async {
    //   _addNewTaskInProgress=true;
    //   setState(() {
    //
    //   });
    //   Map<String,dynamic>requestBody={
    //     "title":_titleTextController.text.trim(),
    //     "description":_descriptionTextController.text.trim(),
    //     "status":"New"
    //   };
    // final  NetworkResponse response= await NetworkCaller().postRequest(Urls.createTask,requestBody);
    //   _addNewTaskInProgress=false;
    //   setState(() {
    //
    //   });
    //
    //
    //   if(response.isSuccess){
    //   _titleTextController.clear();
    //   _descriptionTextController.clear();
    //   if(mounted){
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Tak added successfully")));
    //   }
    // }else{
    //   if(mounted){
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task add failed")));
    //   }
    // }
    //
    // }
  Future<void> addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title": _titleTextController.text.trim(),
      "description": _descriptionTextController.text.trim(),
      "status": "New"
    };

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.createTask, requestBody);

    _addNewTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _titleTextController.clear();
      _descriptionTextController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Task added successfully")));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Task add failed")));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SingleChildScrollView(
    //      child: SafeArea(
    //     child:
    //       Column(
    //         children: [
    //           Expanded(
    //              child: Column(
    //               crossAxisAlignment:CrossAxisAlignment.start ,
    //               children: [
    //               const UserProfileAppBar(),
    //                 Padding(
    //                   padding: const EdgeInsets.all(24),
    //                   child: Column(
    //                     mainAxisAlignment:MainAxisAlignment.center ,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //
    //                       const SizedBox(height:75),
    //                       Text(
    //                         "Add New Task",
    //                         style: Theme.of(context).textTheme.titleLarge,
    //                       ),
    //                       const Divider(
    //                         height: 16,
    //                       ),
    //                       //customTextField(TextInputType.emailAddress,false,"example@gmail.com", "write your email", Icons.email_outlined),
    //                        TextFormField(
    //                          controller: _titleTextController,
    //                         keyboardType:TextInputType.text ,
    //                         decoration: const InputDecoration(
    //                             hintText: "Subject",
    //                             ),
    //                       ),
    //                       const Divider(
    //                         height: 16,
    //                       ),
    //                       //  customTextField(TextInputType.text, true,"password", "write your password", Icons.remove_red_eye_outlined),
    //                        TextFormField(
    //                          controller: _descriptionTextController,
    //                         maxLines: 6,
    //                         keyboardType:TextInputType.text ,
    //                         decoration: const InputDecoration(
    //                           hintText: "Description",
    //
    //                         ),
    //                       ),
    //                       const Divider(
    //                         height: 16,
    //                       ),
    //                       SizedBox(
    //                           width: double.infinity,
    //                           child: Visibility(
    //                             visible: _addNewTaskInProgress==false,
    //                             replacement: const Center(child: CircularProgressIndicator()),
    //                             child: ElevatedButton(
    //                                 onPressed: () {
    //                                   addNewTask();
    //                   // Navigator.pop(context);
    //                                 },
    //                                 child: const Icon(Icons.arrow_forward_ios)),
    //                           )),
    //
    //
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Column(
        children: [
          UserProfileAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      "Add New Task",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Divider(height: 16),
                    TextFormField(
                      controller: _titleTextController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Subject",
                      ),
                    ),
                    const Divider(height: 16),
                    TextFormField(
                      controller: _descriptionTextController,
                      maxLines: 6,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Description",
                      ),
                    ),
                    const Divider(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: !_addNewTaskInProgress,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton.icon(
                          onPressed: addNewTask,
                          icon: const Icon(Icons.arrow_forward_ios),
                          label: const Text("Add Task"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );


  }
}


