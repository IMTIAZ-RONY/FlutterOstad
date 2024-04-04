import 'package:flutter/material.dart';
import 'package:ostad_taskmanager/data/services/network_caller.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/utils/urls.dart';

class UpdateTaskSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;
  const UpdateTaskSheet({super.key, required this.task, required this.onUpdate});
  @override
  State<UpdateTaskSheet> createState() => _UpdateTaskSheetState();
}

class _UpdateTaskSheetState extends State<UpdateTaskSheet> {

  late TextEditingController _titleTextController;
  late TextEditingController _descriptionTextController;
  bool _updateTaskInProgress=false;
  

  @override
  void initState() {
    _titleTextController= TextEditingController(text:widget.task.title );
    _descriptionTextController= TextEditingController(text:widget.task.description);
    super.initState();
  }
  Future<void>updateTask()async{
    _updateTaskInProgress=true;
    Map<String,dynamic>requestBody={
      "title":_titleTextController.text.trim(),
      "description":_descriptionTextController.text.trim(),
    };
    final NetworkResponse  response= await NetworkCaller().postRequest( Urls.createTask,requestBody);
    _updateTaskInProgress=false;
    if(response.isSuccess){
      _titleTextController.clear();
      _descriptionTextController.clear();
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Task successfully updated")));
      }
      widget.onUpdate();
    }
    else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Task fail to update")));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(
        bottom:MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //const SizedBox(height:75),
              Row(
                children: [
                  Text(
                    "Update Task",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.close))
                ],
              ),
              const Divider(
                height: 16,
              ),
              //customTextField(TextInputType.emailAddress,false,"example@gmail.com", "write your email", Icons.email_outlined),
              TextFormField(
                controller: _titleTextController,
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Subject",
                ),
              ),
              const Divider(
                height: 16,
              ),
              //  customTextField(TextInputType.text, true,"password", "write your password", Icons.remove_red_eye_outlined),
              TextFormField(
                controller: _descriptionTextController,
                maxLines: 6,
                keyboardType:TextInputType.text ,
                decoration: const InputDecoration(
                  hintText: "Description",

                ),
              ),
              const Divider(
                height: 16,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _updateTaskInProgress==false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                        onPressed: () {

                          updateTask();
                        },
                        child: const Text("Update")),
                  )),


            ],
          ),
        ),
      ),
    );
  }
}
