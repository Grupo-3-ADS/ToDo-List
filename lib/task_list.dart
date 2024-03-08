import 'package:flutter/material.dart';
import 'package:lista_tarefas/model.dart';
import 'package:lista_tarefas/register_task.dart';

List<Task> listTask = [];

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late DatabaseProvider database;
  List<dynamic> tasks = [];

  @override
  void initState() {
    super.initState();
    database = DatabaseProvider();
    _getAllTasks();
  }

  void _getAllTasks() {
    database.getAllTasks().then((list) {
      setState(() {
        tasks = list;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getAllTasks();
  }

  void editTask(int index) async {
    Task task = tasks[index];
    Task? newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterTask(task: task, editIndex: index),
      ),
    );
    if (newTask != null) {
      setState(() {
        tasks[index] = newTask;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas tarefas'),
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            String name = tasks[index].name;
            String data = tasks[index].date;
            String hora = tasks[index].time;
            return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.purple),
                onDismissed: (direction) {
                  Task task = tasks[index];
                  database.deleteTask(task.id!);
                  setState(() {
                    tasks.removeAt(index);
                  });
                },
                child: ListTile(
                  leading: CircleAvatar(child: Text(index.toString())),
                  title: (Text('Tarefa: $name')),
                  subtitle: Text('Data: $data' + ' - ' + ' Hora: $hora'),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/register');
        },
        tooltip: 'Adicionar novo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
