import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_tarefas/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

List<Task> listTask = [];

class RegisterTask extends StatefulWidget {
  final Task? task;
  final int? editIndex;
  final Function(List<Task>)? updateTasks;

  const RegisterTask({Key? key, this.task, this.editIndex, this.updateTasks})
      : super(key: key);

  @override
  _RegisterTaskState createState() => _RegisterTaskState();
}

class _RegisterTaskState extends State<RegisterTask> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _nameController.text = widget.task!.name ?? '';
      _dateController.text = widget.task!.date ?? '';
      _timeController.text = widget.task!.time ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              widget.editIndex != null ? 'Editar Tarefa' : 'Adicionar Tarefa'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SingleChildScrollView(
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var userId = await prefs.getInt('userId');
              final dbProvider = DatabaseProvider();
              if (widget.editIndex != null) {
                // Atualiza tarefa existente
                Task newTask = Task(widget.task!.id, _nameController.text,
                    _dateController.text, _timeController.text, userId);
                await dbProvider.updateTask(newTask);
              } else {
                // Adiciona nova tarefa
                Task newTask = Task(null, _nameController.text,
                    _dateController.text, _timeController.text, userId);
                await dbProvider.saveTask(newTask);
                listTask.add(newTask);
              }
              if (widget.updateTasks != null) {
                widget.updateTasks!(listTask);
              }
              Navigator.pop(context); // Retorna para a tela anterior
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            child: Text(widget.editIndex != null ? 'Salvar' : 'Adicionar',
                style: TextStyle(color: Colors.black)),
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
            icon: Icon(Icons.add),
            floatingLabelStyle: TextStyle(
              color: Theme.of(context)
                  .primaryColor, // Define a cor do texto do rótulo
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ));
  }

  Widget taskDate() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _dateController,
        keyboardType: TextInputType.text,
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Data',
          icon: Icon(Icons.calendar_today),
          floatingLabelStyle: TextStyle(
            color: Theme.of(context)
                .primaryColor, // Define a cor do texto do rótulo
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        onTap: () async {
          DateTime? pickDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Theme.of(context)
                        .colorScheme
                        .secondary, // Cabeçalho e seleção
                    onPrimary: Colors.white, // Texto do cabeçalho
                    onSurface: Colors.black, // Texto padrão
                  ),
                  dialogBackgroundColor: Colors.white, // Fundo do dialog
                ),
                child: child!,
              );
            },
          );

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
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Hora',
          icon: Icon(Icons.timer),
          floatingLabelStyle: TextStyle(
            color: Theme.of(context)
                .primaryColor, // Define a cor do texto do rótulo
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        onTap: () async {
          TimeOfDay? pickTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Theme.of(context)
                        .colorScheme
                        .secondary, // Cabeçalho e seleção
                    onPrimary: Colors.white, // Texto do cabeçalho
                    onSurface: Colors.black, // Texto padrão
                  ),
                  dialogBackgroundColor: Colors.white, // Fundo do dialog
                ),
                child: child!,
              );
            },
          );
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
