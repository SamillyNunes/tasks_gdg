import 'package:flutter/material.dart';
import 'package:tasks_gdg_arapiraca/screens/add_screen.dart';
import 'package:tasks_gdg_arapiraca/tiles/task_tile.dart';

class TasksScreen extends StatelessWidget {
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
                ListView(
                  children: <Widget>[
                    _searchWidget(context),
                    TaskTile("Terminar projeto"),
                    TaskTile("Caminhada"),
                    TaskTile("Lavar louça"),
                    TaskTile("Estudar"),

                  ],
                ),
                ListView(
                  padding: EdgeInsets.all(20.0),
                  children: <Widget>[
                    _searchWidget(context),
                    Text("teste2")
                  ],
                ),
                ListView(
                  padding: EdgeInsets.all(20.0),
                  children: <Widget>[
                    _searchWidget(context),
                    Text("teste3")
                  ],
                ),
              ]
            )
        )

    );
  }

  Widget _searchWidget(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Pesquisar",
                  hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor
                  )
              ),

            ),
          ),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: (){}
          )
        ],
      ),
    );
  }
}
