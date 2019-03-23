import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_gdg_arapiraca/screens/ok_screen.dart';
import 'package:tasks_gdg_arapiraca/screens/tasks_screen.dart';
import 'package:intl/intl.dart';

class AddScreen extends StatefulWidget {

  DocumentSnapshot _docTask;

  AddScreen({DocumentSnapshot doc}){
    _docTask = doc;
  }

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  int _valuePriority=1;
  DateTime _date;
  String _time;
  String _day,_month,_year;
  bool _datePicked=false;
  bool _timePicked = false;
  bool _editing=false;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<DateTime> _selectDate(BuildContext context){

    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),

      //locale: Locale("pt")
    );

//    Future<TimeOfDay> selectedTime = showTimePicker(
//      context: context,
//      initialTime: TimeOfDay.now(),
//    );



    return selectedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context){
    Future<TimeOfDay> selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    return selectedTime;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget._docTask!=null){
      _editing=true;
      _titleController.text=widget._docTask.data["title"];
      _descriptionController.text = widget._docTask.data["description"];
      _valuePriority=widget._docTask.data["priority"];

      DateTime _dateEditing = widget._docTask.data["date"];
      _date = _dateEditing;
      _day=_dateEditing.day.toString();
      _month=_dateEditing.month.toString();
      _year=_dateEditing.year.toString();

      String _timeEditing = widget._docTask.data["time"];

      _datePicked=true;
      _timePicked=true;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar tarefa"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Título da tarefa"
              ),
              validator: (text){
                if (text.isEmpty) return "Este campo deve ser preenchido.";
              },
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  labelText: "Descrição"
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              children: <Widget>[
                Text(
                  "Prioridade:"
                ),
                SizedBox(width: 20.0,),
                DropdownButton<int>(
                  value: _valuePriority,
                  onChanged: (value){
                    setState(() {
                      _valuePriority=value;
                    });

                  },
                  items: <int>[1,2,3,4,5].map<DropdownMenuItem<int>>(
                          (int value){
                        return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString())
                        );
                      }
                  ).toList(),
                ),
              ],
            ),

            SizedBox(height: 20.0,),

            Row(
              children: <Widget>[
                Text(
                  "Data de término:",
                ),
                FlatButton(
                  child: _datePicked ? Text("$_day/$_month/$_year") : Text("Selecionar data"),
                  onPressed: () async{
                    _date = await _selectDate(context);

                    _date != null ?
                      setState(() {
                        _day = _date.day.toString();
                        _month = _date.month.toString();
                        _year = _date.year.toString();

//                        _hour = _date.hour.toString();
//                        _minute = _date.minute.toString();
                        _datePicked=true;
                      }) : _datePicked=false;

                  },
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Horário de término:",
                ),
                FlatButton(
                  child: _timePicked ? Text("$_time") : Text("Selecionar horário"),
                  onPressed: () async{
                    TimeOfDay t = await _selectTime(context);


                    t!= null ?
                    setState(() {
                      _time=t.format(context);
                      _timePicked=true;
                    }) : _timePicked=false;

                  },
                )
              ],
            ),

            FlatButton(
              onPressed: () async{


                if(_formKey.currentState.validate() && _date!=null && _time!=null){
                  _editing==false ?
                    Firestore.instance.collection("tasks").document().setData(
                      {
                        "title":_titleController.text,
                        "description":_descriptionController.text,
                        "priority": _valuePriority,
                        "date":_date,
                        "time":_time,
                        "state":"to-do",
                      })
                    : Firestore.instance.collection("tasks").document(widget._docTask.documentID).updateData(
                      {
                        "title":_titleController.text,
                        "description":_descriptionController.text,
                        "priority": _valuePriority,
                        "date":_date,
                        "time":_time,
                        "state":"to-do"
                      });

//                  await _popupSave();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>OkScreen()));

                } else if(_date==null){
                  _popupDateTime("Data não selecionada.","uma data");
                } else if(_time==null){
                  _popupDateTime("Horário não selecionado","um horário");
                }
              },
              child: Text(
                "Salvar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              color: Theme.of(context).primaryColor,
            )
          ],
        )
      ),
    );
  }

//  Future<void> _popupSave() async{
//    return showDialog<void>(
//      context: context,
//      builder: (BuildContext context){
//        return AlertDialog(
//          title: Text(
//            "Tarefa enviada com sucesso!",
//            style: TextStyle(
//              color: Theme.of(context).primaryColor
//            ),
//          ),
//          content: SingleChildScrollView(
//            child: ListBody(
//              children: <Widget>[
//                Text("Sua tarefa foi salva no estado to-do. Deseja voltar para o ínicio?")
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              onPressed: (){
//                Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(builder: (context)=>TasksScreen())
//                );
//              },
//              child: Text(
//                "Sim",
//                style: TextStyle(color: Theme.of(context).primaryColor),
//              ),
//            ),
//            FlatButton(
//              onPressed: (){
//                Navigator.of(context).pop();
//              },
//              child: Text(
//                "Não",
//                style: TextStyle(color: Theme.of(context).primaryColor),
//              ),
//            )
//          ],
//        );
//      }
//    );
//  }

  Future<void> _popupDateTime(String title, String type) async{
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor
            ),
          ),
          content: SingleChildScrollView( //uma caixa na qual um unico widget pode ser rolado
            child: ListBody( //organiza seus filhos sequencialmente
              children: <Widget>[
                Text("Por favor selecione $type de término para poder prosseguir.")
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Ok",style: TextStyle(color: Theme.of(context).primaryColor),),
            )
          ],
        );
      }
    );
  }

}
