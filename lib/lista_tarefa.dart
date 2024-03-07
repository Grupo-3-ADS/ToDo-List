import 'package:flutter/material.dart';

List<Task> listTask = [];

class listaTarefas extends StatefulWidget {
  @override
  _listaTarefasState createState() => _listaTarefasState();
}

class _listaTarefasState extends State<listaTarefas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas tarefas'),
      ),
      body: ListView.builder(
          itemCount: listTask.length,
          itemBuilder: (BuildContext context, int index) {
            String desc = listTask[index].descricao;
            String data = listTask[index].data;
            String hora = listTask[index].hora;
            return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.purple),
                onDismissed: (direction) {
                  listTask.removeAt(index);
                },
                child: ListTile(
                  leading: CircleAvatar(child: Text(index.toString())),
                  title: (Text('Tarefa: $desc')),
                  subtitle: Text('Data: $data' + ' - ' + ' Hora: $hora'),
                ));
          }),
    );
  }
}

class Task {
  String descricao;
  String data;
  String hora;
  Task(this.descricao, this.data, this.hora);
}
