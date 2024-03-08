import 'package:flutter/material.dart';
import 'package:lista_tarefas/cadastro_tarefa.dart';
import 'package:lista_tarefas/lista_tarefa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de lista de Tarefa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF673AB7)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Cadastro de lista de Tarefa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Tiago'),
              accountEmail: Text('tiago@gmail.com'),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage('../assets/images/1.png'),
              ),
            ),
            ListTile(
                leading: Icon(Icons.add),
                title: Text('Adicionar tarefa'),
                subtitle: Text('Pode meter aqui'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => cadastroTarefas()));
                }),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Minhas tarefas'),
              subtitle: Text('Tem coisa pra fazer'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => listaTarefas()));
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Remover tarefas'),
              subtitle: Text('Vai largar de mão?'),
              trailing: Icon(Icons.arrow_forward),
              onTap: null,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
