import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class updateTaskStatusSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;
  const updateTaskStatusSheet(
      {Key? key, required this.task, required this.onUpdate})
      : super(key: key);

  @override
  State<updateTaskStatusSheet> createState() => _updateTaskStatusSheetState();
}

class _updateTaskStatusSheetState extends State<updateTaskStatusSheet> {
  List<String> taskStatusList = ["new", "progress", "cancel", "completed"];
  late String _selectedTask;
  bool _updateTaskInProgress = false;
  Future<void> updateTask(String taskId, String newStatus) async {
    _updateTaskInProgress = true;
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.updateTask(taskId, newStatus));
    _updateTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      // _taskListModel.data!.removeWhere((element) => element.sId==taskId);
      widget.onUpdate();
      if(mounted){Navigator.pop(context);}
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("deletion of task has been failed")));
      }
    }
  }

  @override
  void initState() {
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Update Status",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: taskStatusList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _selectedTask = taskStatusList[index];
                      setState(() {});
                    },
                    title: Text((taskStatusList[index].toUpperCase())),
                    trailing: _selectedTask == taskStatusList[index]
                        ? const Icon(Icons.check)
                        : null,
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 200,
              child: Visibility(
                visible:_updateTaskInProgress==false,
                replacement:const Center(child: CircularProgressIndicator()) ,
                child: ElevatedButton(
                    onPressed: () {
                       updateTask(widget.task.sId!, _selectedTask);
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
          )
        ],
      ),
    );

  }
}
