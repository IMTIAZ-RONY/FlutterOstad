import 'package:flutter/material.dart';
import 'package:ostad_taskmanager/UI/screens/new_Task_Screen.dart';

import 'cancelled_Task_Screen.dart';
import 'completed_task_screen.dart';
import 'in_Progress_Task_Screen.dart';
class BottomNavBasicScreen extends StatefulWidget {
  const BottomNavBasicScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBasicScreen> createState() => _BottomNavBasicScreenState();
}

class _BottomNavBasicScreenState extends State<BottomNavBasicScreen> {
 int  _selectedScreenIndex=0;
  final List<Widget> _screens=const[
    NewTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_screens[_selectedScreenIndex] ,
      bottomNavigationBar:BottomNavigationBar(
        currentIndex:_selectedScreenIndex ,

        elevation: 5,
        showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle:const TextStyle(color:Colors.grey) ,
          unselectedItemColor:Colors.grey ,
          selectedItemColor:Colors.green ,
          onTap: (int index){
          _selectedScreenIndex=index;
          if(mounted){
            setState(() {});
          }
          },

          items: const [
        BottomNavigationBarItem(icon:Icon(Icons.ac_unit) ,label: "New Task"),
        BottomNavigationBarItem(icon:Icon(Icons.account_tree) ,label: "In Progress"),
        BottomNavigationBarItem(icon:Icon(Icons.cancel_outlined) ,label: "Canceled"),
        BottomNavigationBarItem(icon:Icon(Icons.done_all) ,label: "Completed"),
      ]) ,
    );
  }
}
