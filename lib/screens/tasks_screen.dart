import 'package:flutter/material.dart';
import 'package:tasks_gdg_arapiraca/screens/add_screen.dart';
import 'package:tasks_gdg_arapiraca/tiles/task_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  List<TaskTile> tasksStateList = List<TaskTile>();
  List<DocumentSnapshot> tasksDocuments = List<DocumentSnapshot>();
  List<TaskTile> tasksSearch = List<TaskTile>();
  final _searchController = TextEditingController();
  bool _search = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Tasks GDG Arapiraca"),
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: Colors.deepOrange,

                tabs: <Widget>[
                  Tab(text: "To-do",),
                  Tab(text: "Doing",),
                  Tab(text: "Done",),
                ]
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>AddScreen())
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: TabBarView(
              children: [
                _tasksStates("to-do"),
                _tasksStates("doing"),
                _tasksStates("done"),
              ]
            )
        )

    );
  }

//  Widget _searchWidget(BuildContext context, String state){
//    return Padding(
//      padding: EdgeInsets.all(20.0),
//      child: Row(
//        children: <Widget>[
//          Expanded(
//            child: TextField(
//              controller: _searchController,
//              decoration: InputDecoration(
//                  hintText: "Pesquisar",
//                  hintStyle: TextStyle(
//                      color: Theme.of(context).primaryColor
//                  )
//              ),
//
//            ),
//          ),
//          IconButton(
//              icon: Icon(
//                Icons.search,
//                color: Theme.of(context).primaryColor,
//              ),
//              onPressed: () async{
//
//
//                return FutureBuilder<QuerySnapshot>(
//                  future: Firestore.instance.collection("tasks").where("title",isEqualTo: _searchController.text).getDocuments(),
//                  builder: (context,snapshot){
//                    if(!snapshot.hasData){
//                      return Center(child: CircularProgressIndicator(),);
//                    } else {
//                      for(DocumentSnapshot d in snapshot.data.documents){
////                        if(d.data["title"]==_searchController && d.data["state"]==state){
////                          tasksSearch.add(TaskTile(d));
////                        }
//                        print(d.data);
//                        tasksSearch.add(TaskTile(d));
//                      }
//
////                      return ListView(
////                        children: tasksSearch,
////                      );
//                    }
//
//                    setState(() {
//                      _search=true;
//                    });
//                  },
//                );
//              }
//          )
//        ],
//      ),
//    );
//  }

  Widget _tasksStates(String state){

    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("tasks").orderBy("priority",descending: true).getDocuments(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        } else {
          tasksStateList.clear(); //Limpa para quando voltar pra tela n repetir os itens

          for(DocumentSnapshot d in snapshot.data.documents){
            if(d.data["state"]==state){
              tasksStateList.add(TaskTile(d));
              tasksDocuments.add(d);
            }
          }

          return ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                            hintText: "Pesquisar",
                            hintStyle: TextStyle(
                                color: Theme.of(context).primaryColor
                            )
                        ),
                        onSubmitted: (string){
                          tasksSearch.clear();
                          _searchFunction(state);
                        },

                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed:(){
                          tasksSearch.clear();
                          _searchFunction(state);
                        },
                    )
                  ],
                ),
              ),
              _search ? Column(children: tasksSearch,) : Column(children: tasksStateList)
            ],
          );
        }
      },
    );
  }

  void _searchFunction(String state){
    tasksSearch.clear();

    for(DocumentSnapshot d in tasksDocuments){
      if(d.data["title"].toString().contains(_searchController.text) && d.data["state"]==state){
        print(d.data["title"]);
        tasksSearch.add(TaskTile(d));
      }
    }

    setState(() {
      _search=true;
    });
  }

}
