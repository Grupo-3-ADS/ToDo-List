import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_tarefas/model.dart';
import 'package:table_calendar/table_calendar.dart';

List<Task> listTask = [];

class RegisterTask extends StatefulWidget {
  final Task? task;
  final int? editIndex;

  const RegisterTask({Key? key, this.task, this.editIndex}) : super(key: key);

  @override
  _RegisterTaskState createState() => _RegisterTaskState();
}

class _RegisterTaskState extends State<RegisterTask> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.editIndex != null ? 'Editar Tarefa' : 'Adicionar Tarefa'),
      ),
      body: SingleChildScrollView(
        // Adiciona um SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              sizeBox(),
              taskName(),
              sizeBox(),
              taskDate(),
              sizeBox(),
              taskTime(),
              sizeBox(),
            ],
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(33, 0, 0, 10),
          child: ElevatedButton(
            onPressed: () async {
              final dbProvider = DatabaseProvider();
              if (widget.editIndex != null) {
                // Atualiza contato existente
                Task newTask = Task(
                  widget.task!.id,
                  _nameController.text,
                  _dateController.text,
                  _timeController.text,
                );
                await dbProvider.updateTask(newTask);
                listTask[widget.editIndex!] = newTask;
              } else {
                // Adiciona novo contato
                Task newTask = Task(
                  null,
                  _nameController.text,
                  _dateController.text,
                  _timeController.text,
                );
                await dbProvider.saveTask(newTask);
                listTask.add(newTask);
              }
              Navigator.pop(context); // Retorna para a tela anterior
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            child: Text(widget.editIndex != null ? 'Salvar' : 'Adicionar'),
          ),
        ),
      ),
    );
  }

  Widget sizeBox() {
    return SizedBox(
      height: 15,
    );
  }

  Widget taskName() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Tarefa',
            icon: Icon(Icons.add)),
      ),
    );
  }

  Widget taskDate() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _dateController,
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
              _dateController.text = dataFormatada;
            });
          }
        },
      ),
    );
  }

  Widget taskTime() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _timeController,
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
              _timeController.text = pickTime.format(context);
            });
          }
        },
      ),
    );
  }
}
