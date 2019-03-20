import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
 
  String valorDropDown="1";
  String day,month,year;
  bool datePicked = false;


  Future<DateTime> _selectDate(BuildContext context){
    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),

      //locale: Locale("br")
//      builder: (BuildContext context, Widget child) {
//        return Theme(
//          data: ThemeData.dark(),
//          child: child,
//        );
//      },
    );

    return selectedDate;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar tarefa"),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Título da tarefa"
              ),
            ),
            SizedBox(height: 20.0,),
            TextFormField(
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
                DropdownButton<String>(
                  value: valorDropDown,
                  onChanged: (valor){
                    setState(() {
                      valorDropDown=valor;
                    });

                  },
                  items: <String>["1","2","3","4","5"].map<DropdownMenuItem<String>>(
                          (String valor){
                        return DropdownMenuItem<String>(
                            value: valor,
                            child: Text(valor)
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
                  child: datePicked ? Text("$day/$month/$year") : Text("Selecionar data"),
                  onPressed: () async{
                    DateTime data = await _selectDate(context);

                    setState(() {
                      day = data.day.toString();
                      month = data.month.toString();
                      year = data.year.toString();
                      datePicked=true;
                    });


                  },
                )
              ],
            ),

            FlatButton(
              onPressed: (){

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


}
