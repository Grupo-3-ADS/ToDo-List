import 'package:flutter/material.dart';
import 'package:lista_tarefas/login.dart';
import 'package:lista_tarefas/register_task.dart';
import 'package:lista_tarefas/task_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de lista de Tarefa',
      theme: ThemeData(
          primaryColor: Colors.pink[600], // Cor base personalizada
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.pink[400], // Personalizando a cor terciária
                secondary: Colors.pink[200], // Personalizando a cor secundária
                tertiary: Colors.pink[50],
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.pink[400],
          )),
      home: const LoginPage(),
      routes: {
        '/register': (context) => const RegisterTask(),
        '/list': (context) => const TaskList(),
      },
    );
  }
}
