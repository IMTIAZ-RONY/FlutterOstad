import 'package:flutter/material.dart';
import 'package:ostad_taskmanager/data/models/task_list_model.dart';

class TaskListTile extends StatelessWidget {
  final VoidCallback onDeleteTap, onEditTap;
  const TaskListTile({
    super.key,
    required this.data,
    required this.onDeleteTap,
    required this.onEditTap,
  });
  final TaskData data;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title ?? "Unknown"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.description ?? ''),
          Text(data.createdDate ?? " "),
          Row(
            children: [
              Chip(
                label: Text(
                  data.status ?? "New",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
              const Spacer(),
              IconButton(
                  onPressed: onEditTap,
                  icon: const Icon(
                    Icons.edit,
                    size: 24,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: onDeleteTap,
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    size: 24,
                    color: Colors.red,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
