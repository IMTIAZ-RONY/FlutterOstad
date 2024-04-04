import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ostad_taskmanager/data/models/summary_count_model.dart';
import 'package:ostad_taskmanager/data/models/task_list_model.dart';


import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_appbar.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountSummary();
      getInProgressTask();

    });
  }
  bool _getProgressTaskInProgress= false;
  bool  _getCountSummaryInProgress=false;
  SummaryCountModel _summaryCountModel=SummaryCountModel();
  TaskListModel _taskListModel= TaskListModel();

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.taskStatusCount);
    _getCountSummaryInProgress =false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Summary data get failed")));
      }
    }
    _getCountSummaryInProgress =false;
    if (mounted) {
      setState(() {});
    }
  }
  Future<void>getInProgressTask()async{
    _getProgressTaskInProgress=true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.inProgressTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      // Fetch count summary after adding the new task
      await getCountSummary();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("InProgress tasks get failed")));
      }
    }
    _getProgressTaskInProgress=false;
    if (mounted) {
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppBar(),
            _getProgressTaskInProgress?const Center(child:LinearProgressIndicator() ,):
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection:Axis.horizontal ,
                  itemCount: _summaryCountModel.data?.length??0,
                  itemBuilder: (context, index) {

                    return SummaryCard(
                      title: _summaryCountModel.data![index].sId??"InProgress",
                      number: _summaryCountModel.data![index].sum??0,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 4,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                 onRefresh: () async{ getInProgressTask(); getCountSummary(); },
                 child: _getProgressTaskInProgress?const Center(child:CircularProgressIndicator() ,):
                 ListView.separated(
                  itemCount: _taskListModel.data?.length?? 0,
                  itemBuilder: (context, index) {

                    return TaskListTile(
                      data: _taskListModel.data![index], onDeleteTap: () {  }, onEditTap: () {  },);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 4,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}





