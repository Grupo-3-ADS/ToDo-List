import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'lista_tarefa.dart';

class cadastroTarefas extends StatefulWidget {
  @override
  _cadastroTarefasState createState() => _cadastroTarefasState();
}

class _cadastroTarefasState extends State<cadastroTarefas> {
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  TextEditingController _horaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar tarefa'),
      ),
      body: Stack(children: <Widget>[
        ListView(children: [
          sizeBox(),
          descricaoTarefa(),
          sizeBox(),
          dataTarefa(),
          sizeBox(),
          horaTarefa(),
        ]),
      ]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            addListaTarefa(_descricaoController.text, _dataController.text,
                _horaController.text);
          }),
    );
  }

  Widget sizeBox() {
    return SizedBox(
      height: 30,
    );
  }

  Widget descricaoTarefa() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _descricaoController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Descrição',
            icon: Icon(Icons.add)),
      ),
    );
  }

  Widget dataTarefa() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _dataController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Data',
            icon: Icon(Icons.calendar_today)),
        onTap: () async {
          DateTime? pickDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime(2100));
          if (pickDate != null) {
            String dataFormatada = DateFormat('dd/MM/yyyy').format(pickDate);
            setState(() {
              _dataController.text = dataFormatada;
            });
          }
        },
      ),
    );
  }

  Widget horaTarefa() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _horaController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Hora',
            icon: Icon(Icons.timer)),
        onTap: () async {
          TimeOfDay? pickTime = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());
          if (pickTime != null) {
            setState(() {
              _horaController.text = pickTime.format(context);
            });
          }
        },
      ),
    );
  }
}

void addListaTarefa(String descricao, String data, String hora) {
  Task t = Task(descricao, data, hora);
  listTask.add(t);
}
