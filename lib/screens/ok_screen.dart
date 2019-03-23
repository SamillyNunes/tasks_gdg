import 'package:flutter/material.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:tasks_gdg_arapiraca/screens/tasks_screen.dart';

class OkScreen extends StatefulWidget {
  @override
  _OkScreenState createState() => _OkScreenState();
}

class _OkScreenState extends State<OkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefa adicionada com sucesso!"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TasksScreen()));
        },
        child: FlareActor(
          "animations/ok.flr",
          alignment: Alignment.center,
          animation: "Untitled",
          fit: BoxFit.cover,
        ),
      )

//      Column(
//        children: <Widget>[
//          SizedBox(
//            height: 350.0,
//            width:350.0,
//            child: FlareActor(
//              "animations/ok.flr",
//              alignment: Alignment.center,
//              animation: "Untitled",
//              fit: BoxFit.cover,
//            ),
//          ),

//          RaisedButton(
//            onPressed: (){
//              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TasksScreen()));
//            },
//            child: Text("Ir para página inicial",style: TextStyle(color: Colors.white),),
//            color: Theme.of(context).primaryColor,
//          ),
//        ],
//      )
    );
  }
}

