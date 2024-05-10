import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas/database.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController senhaConfirmacaoController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CupertinoTextField(
                controller: nomeController,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                placeholder: 'Nome',
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 10),
              CupertinoTextField(
                controller: sobrenomeController,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                placeholder: 'Sobrenome',
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 10),
              CupertinoTextField(
                controller: telefoneController,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                placeholder: 'Telefone',
                keyboardType: TextInputType.phone,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 10),
              CupertinoTextField(
                controller: emailController,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                placeholder: 'E-mail',
                keyboardType: TextInputType.emailAddress,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 10),
              CupertinoTextField(
                controller: senhaController,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                placeholder: 'Senha',
                obscureText: true,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 10),
              CupertinoTextField(
                controller: senhaConfirmacaoController,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                placeholder: 'Repita sua senha',
                obscureText: true,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 20),
              CupertinoButton(
                color: Colors.deepPurple,
                child: Text('Registrar'),
                onPressed: () {
                  if (senhaController.text != senhaConfirmacaoController.text) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Erro'),
                        content: Text('As senhas não coincidem.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    _registerUser();
                    var nome = nomeController.text;
                    var sobrenome = sobrenomeController.text;
                    var telefone = telefoneController.text;
                    var email = emailController.text;
                    var senha = senhaController.text;
                    var user = {
                      'nome': nome,
                      'sobrenome': sobrenome,
                      'telefone': telefone,
                      'email': email,
                      'senha': senha,
                    };
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser() async {
    var nome = nomeController.text;
    var sobrenome = sobrenomeController.text;
    var telefone = telefoneController.text;
    var email = emailController.text;
    var senha = senhaController.text;

    var user = {
      'nome': nome,
      'sobrenome': sobrenome,
      'telefone': telefone,
      'email': email,
      'senha': senha,
    };

    int id = await DatabaseHelper.instance.insertUser(user);
    if (id != 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sucesso'),
          content: Text('Usuário registrado com sucesso!'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Falha ao registrar o usuário.'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
