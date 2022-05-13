import 'package:flutter/material.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Sexo { masculino, feminino }

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController controller;
  List<Pacient> pacients = [];
  String name = '';
  Sexo s = Sexo.masculino;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  void _incrementList(String nome, String sexo) {
    setState(() {
      pacients.add(
        Pacient(
          name: nome,
          sex: sexo,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
      ),
      body: _buildListView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.value = TextEditingValue.empty;
          s = Sexo.masculino;
          final name = await openDialog();
          final sex;
          if (s == Sexo.feminino) {
            sex = 'Feminino';
          } else {
            sex = 'Masculino';
          }
          if (name == null || name.isEmpty) return;
          setState(() {
            this.name = name;
          });
          _incrementList(name, sex);
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
              ListTile(
                title: const Text('Masculino'),
                leading: Radio<Sexo>(
                  value: Sexo.masculino,
                  groupValue: s,
                  onChanged: (value) => setState(() {
                    s = value!;
                  }),
                ),
              ),
              ListTile(
                title: const Text('Feminino'),
                leading: Radio<Sexo>(
                  value: Sexo.feminino,
                  groupValue: s,
                  onChanged: (value) => setState(() {
                    s = value!;
                  }),
                ),
              ),
            ],
          ),
          actions: [
            Column(
              children: <Widget>[
                TextButton(
                  child: const Text('SALVAR'),
                  onPressed: submit,
                ),
              ],
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context).pop(controller.text);
  }

  ListView _buildListView(BuildContext context) {
    return ListView.builder(
      itemCount: pacients.length,
      itemBuilder: (context, index) {
        final paciente = pacients[index];
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                ),
                title: Text(
                  paciente.name,
                ),
                subtitle: const Text("Clique para mais informações"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => DetailsPage(index, paciente)),
                    ),
                  );
                },
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.purple,
                    onPressed: () async {
                      controller.value = TextEditingValue(text: paciente.name);
                      final name = await openDialog();
                      if (name == null || name.isEmpty) return;
                      setState(() {
                        paciente.name = name;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.purple,
                    onPressed: () {
                      setState(() {
                        pacients.remove(paciente);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class Pacient {
  String name;
  String sex;

  Pacient({
    required this.name,
    required this.sex,
  });
}
