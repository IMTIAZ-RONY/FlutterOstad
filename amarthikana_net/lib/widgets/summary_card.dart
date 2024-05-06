import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,required this.color,required this.title,
  });
  final Color color;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape:RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(20),
      ) ,
      elevation: 5,
      color:color ,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            Text(title),
          ],

        ),
      ) ,
    );
  }
}