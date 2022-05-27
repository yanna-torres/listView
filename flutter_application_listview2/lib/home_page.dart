import 'package:flutter/material.dart';
import 'data/pacient.dart';
import 'list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  List<Pacient> pacients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
      ),
      body: listView(
        pacients: pacients,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
        },
        tooltip: 'Adicionar',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Dados do Paciente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Digite o nome'),
                controller: controller,
              ),
              TextField(
                autofocus: true,
                decoration:
                    const InputDecoration(hintText: 'Sexo do paciente (F/M)'),
                controller: controller2,
              ),
            ],
          ),
          actions: [
            Column(
              children: <Widget>[
                TextButton(
                  child: const Text('ADICIONAR'),
                  onPressed: submit,
                ),
              ],
            ),
          ],
        ),
      );

  void submit() {
    _incrementList();
    Navigator.of(context).pop();
    controller.clear();
    controller2.clear();
  }

  _incrementList() {
    setState(() {
      pacients.add(Pacient(name: controller.text, sex: controller2.text));
    });
  }
}
