import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_gdg_arapiraca/screens/add_screen.dart';
import 'package:tasks_gdg_arapiraca/screens/tasks_screen.dart';

class TaskTile extends StatelessWidget {

  DocumentSnapshot _taskDoc;

  TaskTile(this._taskDoc);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        _buildAlertInformation(context);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10.0,right: 10.0),
        child: Slidable(
          delegate: SlidableDrawerDelegate(),
          child: ListTile(
            title: Text(
                _taskDoc.data["title"]
            ),
            trailing: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: (){
                  String newState;

                  if(_taskDoc.data["state"]=="to-do"){
                    newState="doing";
                  } else if(_taskDoc.data["state"]=="doing"){
                    newState="done";
                  } else {
                    newState="OK";
                  }
                  Firestore.instance.collection("tasks").document(_taskDoc.documentID).updateData(
                      {
                        "state":newState
                      }
                  );

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=>TasksScreen())
                  );

                }
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              icon: Icons.delete,
              color: Colors.red,
              caption: "Deletar",
              onTap: (){
                Firestore.instance.collection("tasks").document(_taskDoc.documentID).delete();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context)=>TasksScreen())

                );
              },
            ),
            IconSlideAction(
              icon: Icons.edit,
              color: Colors.blue,
              caption: "Editar",
              onTap: (){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=>AddScreen(doc: _taskDoc,))
                );

              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _buildAlertInformation(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _taskDoc.data["title"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 5.0,),
                  Text(
                      _taskDoc.data["description"]
                  ),
                  Divider(),
                  SizedBox(height: 5.0,),
                  Text(
                    "Data de término:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    DateFormat("dd-MM-yyyy").format(_taskDoc.data["date"])
                  ),
                  SizedBox(height: 5.0,),
                  SizedBox(height: 5.0,),
                  Text(
                    "Horário de término:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                     _taskDoc.data["time"]
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    children: <Widget>[
                      Text(
                        "Prioridade: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                          _taskDoc.data["priority"].toString()
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),

        );
      }
    );
  }
}
