import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {

  String titleTask;
  String descriptionTask;

  TaskTile(this.titleTask);

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
            title: Text(titleTask),
            trailing: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: (){}
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              icon: Icons.delete,
              color: Colors.red,
              caption: "Deletar",
              onTap: (){},
            ),
            IconSlideAction(
              icon: Icons.edit,
              color: Colors.blue,
              caption: "Editar",
              onTap: (){},
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
                children: <Widget>[
                  Text(
                    titleTask,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0
                    ),
                  ),
                  Text(
                    "teste"
                  )

                ],
              ),
            ),
          ),

        );
      }
    );
  }
}
