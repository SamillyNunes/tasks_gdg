import 'package:flutter/material.dart';
import 'package:tasks_gdg_arapiraca/screens/tasks_screen.dart';

void main(){
  runApp(MaterialApp(
    title: "TasksApp GDG Arapiraca",
    home: TasksScreen(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.deepPurple,
      dividerColor: Colors.cyan
    ),
  ));
}